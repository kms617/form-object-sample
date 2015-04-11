class EnrollmentForm
  include ActiveModel::Model

  attr_accessor :email,
                :bio,
                :communication_style,
                :first_name,
                :hire_type_id,
                :last_name,
                :manager_id,
                :mentor_id,
                :photo_file_name,
                :reset_photo,
                :slack_handle,
                :team_id,
                :title

  attr_reader :profile,
              :user

  validates :email, presence: true
  validates :first_name, presence: true
  validates :hire_type_id, presence: true
  validates :last_name, presence: true
  validates :team_id, presence: true

  def formatted_name
    "#{first_name} #{last_name}"
  end

  def name
    if formatted_name.blank?
      'New Employee'
    else
      formatted_name
    end
  end

  def photo
    if photo_file_name.blank?
      default_photo
    else
      photo_file_name
    end
  end

  def reset_default_photo(profile_id)
    profile = Profile.find(profile_id)
    if reset_photo?
      profile.photo.clear
      profile.save
    end
  end

  def save
    if valid? && email_is_unique
      create_user_profile
    end
  end

  def update(user_id, profile_id)
    if email_is_unique(user_id) && valid?
      reset_default_photo(profile_id)
      update_user_profile(user_id, profile_id)
      profile = Profile.find(profile_id)
    end
  end

  private

  def create_user_profile
    new_user = User.create!(email: email)
    profile = Profile.create!(profile_attrs.merge(user: new_user))
  end

  def default_photo
    'medium/missing.png'
  end

  def email_is_unique(user_id = nil)
    if User.where(email: email).where.not(id: user_id).present?
      errors.add(:email, 'is already in use')
      false
    else
      true
    end
  end

  def profile_attrs
    { bio: bio,
      communication_style: communication_style,
      first_name: first_name,
      hire_type_id: hire_type_id,
      last_name: last_name,
      manager_id: manager_id,
      mentor_id: mentor_id,
      photo_file_name: photo_file_name,
      slack_handle: slack_handle,
      team_id: team_id,
      title: title
    }
  end

  def reset_photo?
    mapping = { '1' => true, '0' => false }
    mapping[reset_photo]
  end

  def update_user_profile(user_id, profile_id)
    user = User.find(user_id)
    user.update(email: email)
    profile = Profile.find(profile_id)
    profile.update(profile_attrs)
  end
end
