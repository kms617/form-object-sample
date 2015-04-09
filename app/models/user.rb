class User < ActiveRecord::Base
  belongs_to :profile
  validates :email, presence: true, uniqueness: true, email: true
  enum role: [:employee, :admin]
end
