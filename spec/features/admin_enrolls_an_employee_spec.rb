require 'rails_helper'

feature 'Admin enrolls an employee' do
  context 'valid submissions' do
    scenario 'Admin enters required information' do
      profile = build_stubbed(:profile)

      visit new_profile_path

      fill_in 'Email', with: profile.user.email
      fill_in 'Name', with: profile.first_name
      fill_in 'enrollment_form_last_name', with: profile.last_name

      click_button 'Save'

      expect(page).to have_content(I18n.t('flashes.profiles.create.success'))
      expect(page).to have_content(profile.first_name)
      expect(page).to have_content(profile.last_name)
    end

    scenario 'Admin assigns a manager' do
      manager_profile = create(:profile)
      manager = manager_profile.decorate
      profile = build_stubbed(:profile)

      visit new_profile_path

      fill_in 'Email', with: profile.user.email
      fill_in 'Name', with: profile.first_name
      fill_in 'enrollment_form_last_name', with: profile.last_name
      select manager.full_name, from: 'Manager'

      click_button 'Save'

      saved_profile = Profile.find_by(first_name: profile.first_name)
      saved_manager = Profile.find_by(first_name: manager_profile.first_name)

      expect(saved_profile.manager).to eq(saved_manager)
      expect(page).to have_content(I18n.t('flashes.profiles.create.success'))
      expect(page).to have_content(profile.first_name)
      expect(page).to have_content(profile.last_name)
    end

    scenario 'Admin assigns a mentor' do
      mentor_profile = create(:profile)
      mentor = mentor_profile.decorate
      profile = build_stubbed(:profile)

      visit new_profile_path

      fill_in 'Email', with: profile.user.email
      fill_in 'Name', with: profile.first_name
      fill_in 'enrollment_form_last_name', with: profile.last_name
      select mentor.full_name, from: 'Mentor'

      click_button 'Save'

      saved_profile = Profile.find_by(first_name: profile.first_name)
      saved_mentor = Profile.find_by(first_name: mentor_profile.first_name)

      expect(saved_profile.mentor).to eq(saved_mentor)
      expect(page).to have_content(I18n.t('flashes.profiles.create.success'))
      expect(page).to have_content(profile.first_name)
      expect(page).to have_content(profile.last_name)
    end
  end

  context 'invalid submissions' do
    scenario 'Admin enters a blank form' do

      visit new_profile_path
      click_button 'Save'

      expect(page).to have_content(I18n.t('flashes.profiles.create.failure'))
      expect(page).to have_content("can't be blank")
    end

    scenario 'Admin duplicates a profile' do
      user = create(:user, email: 'taken@intrepid.io')
      profile = create(:profile)

      visit new_profile_path

      fill_in 'Email', with: user.email
      fill_in 'Name', with: profile.first_name
      fill_in 'enrollment_form_last_name', with: profile.last_name
      click_button 'Save'

      expect(page).to have_content(I18n.t('flashes.profiles.create.failure'))
      expect(page).to have_content('is already in use')
    end
  end
end
