require 'rails_helper'

feature 'Admin deletes a user' do
  it 'deletes a user and their profile' do
    profile = create(:profile)
    profile_count = Profile.count
    user_count = User.count

    visit edit_profile_path(profile)

    click_link 'Delete User'

    expect(page).to have_content(I18n.t('flashes.profiles.destroy.success'))
    expect(page).to_not have_content(profile.first_name)
    expect(Profile.count).to eq(profile_count - 1)
    expect(User.count).to eq(user_count - 1)
  end
end
