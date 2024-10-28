module LawnServices
  class Searcher
    attr_accessor :services

    def self.call(user=nil, opts = {})
      new(user,opts).call
    end

    def initialize(user,opts)
      @opts = opts
      @user = user
    end

    def call
      services = Service.all
			services = services.by_availability(availablity)
      services = services.search_by_company_name(company_name) if company_name.present?
			services = services.search_by_area_code(area_code) if area_code.present?
			services = services.by_budget(budget) if budget.present?
			services
		end

    private

    def company_name
      @opts[:company_name]
    end

		def area_code
      @opts[:area_code]
    end

		def availablity
      return true if @opts[:availablity].nil?
			@opts[:availablity]
    end

		def budget
      @opts[:budget]
    end

  end
end