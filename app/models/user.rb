# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :sub_parts, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :name, presence: true

  enum :role, { 
    admin: 0,
    worker: 1,
    qc: 1
  }
end
