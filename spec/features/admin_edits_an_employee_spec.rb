require 'rails_helper'

feature 'Admin edits a user' do
  context 'valid submissions' do
    scenario 'Admin changes information' do
      profile = create(:profile)
      new_profile = build_stubbed(:profile)

      visit edit_profile_path(profile)

      fill_in 'Email', with: new_profile.user.email
      fill_in 'Name', with: new_profile.first_name
      fill_in 'enrollment_form_last_name', with: new_profile.last_name

      click_button 'Save'

      profile.reload
      expect(profile.email).to eq(new_profile.user.email)
      expect(profile.first_name).to eq(new_profile.first_name)
      expect(profile.last_name).to eq(new_profile.last_name)
    end

    scenario 'Admin changes only profile information' do
      profile = create(:profile)
      new_profile = build(:profile)

      visit edit_profile_path(profile)

      fill_in 'Name', with: new_profile.first_name
      fill_in 'enrollment_form_last_name', with: new_profile.last_name

      click_button 'Save'

      profile.reload
      expect(profile.first_name).to eq(new_profile.first_name)
      expect(profile.last_name).to eq(new_profile.last_name)
    end

    scenario 'Admin resets photo' do
      profile = create(:profile, :has_photo)

      visit edit_profile_path(profile)

      check 'enrollment_form_reset_photo'

      click_button 'Save'

      profile.reload
      expect(profile.photo_file_name).to eq(nil)
    end
  end

  context 'invalid submissions' do
    scenario 'Admin enters nil for required fields' do
      profile = create(:profile)

      visit edit_profile_path(profile)

      fill_in 'Email', with: nil
      fill_in 'Name', with: nil
      fill_in 'enrollment_form_last_name', with: nil

      click_button 'Save'

      expect(page).to have_content("can't be blank")
    end

    scenario 'Admin enters a duplicate email address' do
      profile = create(:profile)
      duplicate_user = create(:user, email: 'taken@intrepid.io')

      visit edit_profile_path(profile)

      fill_in 'Email', with: duplicate_user.email
      click_button 'Save'

      expect(page).to have_content('Email is already in use')
    end
  end
end
