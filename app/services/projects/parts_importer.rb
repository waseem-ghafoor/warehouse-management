require 'csv'

class Projects::PartsImporter
  attr_accessor :errors, :success_import

  def initialize(project, file_path)
    @csv_file_path = file_path
    @project = project
    @errors = {}
    @success_import = 0
  end

  def import
    @errors = Hash.new { |hash, key| hash[key] = [] }
    begin
      @rows = CSV.read(@csv_file_path, headers: true, encoding: 'ISO-8859-1')


      @rows.each_with_index do |row, index|
        begin
          part = Part.find_or_initialize_by(part_number: row['Part No'], project_id: @project.id)
          part.material = row['Material ID']
          if part.save
            sub_part = part.sub_parts.find_or_initialize_by(sub_part_no: row['Sub Part NO'], part_id: part.id)
            sub_part.job_id = row['JOB ID']
            sub_part.sap_order_number = row['SAP ORDER NO']
            sub_part.status = map_status(row['Status'])
            sub_part.height = row['Height (MM)']
            sub_part.width = row['Width (MM)']
            sub_part.length = row['Length (MM)']
            sub_part.qty_no = row['Qty No.']
            sub_part.per_qty = row['Per Qty (Kg)']
            sub_part.totat_qty = row['Total Qty (Kg)']
            sub_part.start_time = parse_time(row['Start time'])
            sub_part.stop_time = parse_time(row['Stop time'])
            sub_part.time_taken = row['Time taken']
            sub_part.stage = map_stage(row['Stage'])
            sub_part.quality_control = map_quality_control(row['Quality Control'])
            sub_part.note = row['Note']
            sub_part.worker_id = assign_worker row

            if sub_part.save
              @success_import += 1
            else
              @errors[part.part_number&.to_sym] += sub_part.errors.full_messages
            end
          else
            @errors[part.part_number&.to_sym] += part.errors.full_messages
          end
        rescue => e
          @errors[:base] << "Row #{index + 1}: Failed to process part data - #{e.message}"
          next
        end
      end
    rescue => e
      @errors[:base] << "An error occurred: File format is not correct - #{e.message}"
    end

    @errors
  end

  private

  def map_status(status)
    case status
    when 'Started' then 1
    when 'In Progress' then 2
    when 'Completed' then 3
    else 0
    end
  end

  def map_stage(stage)
    case stage
    when 'Cutting' then 1
    when 'Welding' then 2
    else 0
    end
  end

  def assign_worker row
    @user = User.find_by_email(row['Worker Email'])
    return @user.id if @user.present?

    @user = User.create(email: row['Worker Email'], name: row['Worker Name'], password: "password", role: "worker" )
    return @user.id
  end

  def map_quality_control(quality_control)
    quality_control == 'Approved' ? 1 : 0
  end

  def parse_time(time_str)
    Time.parse(time_str) rescue nil
  end
end
