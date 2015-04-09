class Team < ActiveRecord::Base
  has_many :profiles

  validates_presence_of :name

  def self.ordered
    order('lower(name)')
  end
end
