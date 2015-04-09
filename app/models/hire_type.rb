class HireType < ActiveRecord::Base
  enum contract_type: [:full_time, :apprentice]
  enum work_status: [:no_visa, :visa]

  has_many :profiles

  validates_presence_of :contract_type
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :work_status

  def self.ordered
    order(:name)
  end
end
