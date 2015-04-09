class ProfileDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def full_name
    "#{first_name} #{last_name}"
  end

  def photo_full_url(style = :large)
    URI.join(h.request.url, photo_url(style)).to_s
  end

  def team_name
    object.team.name
  end
end
