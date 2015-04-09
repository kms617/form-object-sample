class Profile < ActiveRecord::Base
  has_one :user, dependent: :destroy
  delegate :email, to: :user
  belongs_to :hire_type
  belongs_to :team, touch: true
  belongs_to :manager, class_name: 'Profile'
  belongs_to :mentor, class_name: 'Profile'

  has_attached_file :photo, styles: { large: ['100x100#', :png],
                                      medium: ['74x74#', :png],
                                      small: ['48x48#', :png]
                                    },
                            default_url: '/assets/images/:style/missing.png'

  validates :bio, length: { maximum: 140 }
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :hire_type
  validates :slack_handle, length: { maximum: 21 }
  validates_presence_of :team

  validates_attachment :photo, content_type: { content_type: /\Aimage\/.*\Z/ },
                               size: { less_than: 4.megabyte }

  def self.ordered
    order(:first_name)
  end

  def photo_url(style = :large)
    photo && photo.url(style, false)
  end
end
