describe ProfilesController do
  describe 'GET #index' do
    it 'assigns profiles to @profiles' do
      admin_sign_in
      create(:profile)

      get :index

      expect(assigns[:profiles]).to be_a(ProfileQuery)
    end

    it 'renders the index template' do
      admin_sign_in

      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    it 'renders the new enrollment template' do
      admin_sign_in

      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
    end

    context 'valid attributes' do
      it 'saves the profile and associated user' do
        admin_sign_in
        profile = build_profile

        user_count = User.count
        profile_count = Profile.count

        post :create, enrollment_form: { email: profile.email,
                                         first_name: profile.first_name,
                                         last_name: profile.last_name,
                                         hire_type_id: profile.hire_type_id,
                                         team_id: profile.team_id
                                        }
        expect(User.count).to eq(user_count + 1)
        expect(Profile.count).to eq(profile_count + 1)
      end

      it 'redirects to index with a notice on successful save' do
        admin_sign_in
        profile = build_profile

        post :create, enrollment_form: { email: profile.email,
                                         first_name: profile.first_name,
                                         last_name: profile.last_name,
                                         hire_type_id: profile.hire_type_id,
                                         team_id: profile.team_id
                                        }

        expect(response).to redirect_to(profiles_path)
        expect(flash[:notice]).to eq(I18n.t('flashes.profiles.create.success'))
      end
    end

    context 'duplicate email address' do
      it 'renders the new template with a notice on failed save' do
        admin_sign_in
        create(:user, email: 'duplicate@intrepid.io')

        post :create, enrollment_form: { email: 'duplicate@intrepid.io',
                                         first_name: 'Duplicate',
                                         last_name: 'User'
                                        }

        expect(response).to render_template('new')
        expect(flash[:alert]).to eq(I18n.t('flashes.profiles.create.failure'))
      end
    end

    context 'blank email address' do
      it 'renders the new template with a notice on failed save' do
        admin_sign_in

        post :create, enrollment_form: { email: nil,
                                         first_name: nil,
                                         last_name: nil
                                       }

        expect(response).to render_template('new')
        expect(flash[:alert]).to eq(I18n.t('flashes.profiles.create.failure'))
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'located the requested @profile' do
        admin_sign_in
        new_attrs = create_new_profile_attrs
        profile = create(:profile)

        patch :update, id: profile, enrollment_form: new_attrs
        profile.reload

        expect(assigns[:enrollment].email).to eq(profile.email)
      end

      it 'changes profiles attributes' do
        admin_sign_in
        new_attrs = create_new_profile_attrs
        profile = create(:profile)

        patch :update, id: profile, enrollment_form: new_attrs
        profile.reload

        expect(profile.email).to eq(new_attrs['email'])
        expect(profile.first_name).to eq(new_attrs['first_name'])
        expect(profile.last_name).to eq(new_attrs['last_name'])
        expect(flash[:notice]).to eq(I18n.t('flashes.profiles.update.success'))
      end

      it 'redirects to the profile index' do
        admin_sign_in
        new_attrs = create_new_profile_attrs
        profile = create(:profile)

        patch :update, id: profile, enrollment_form: new_attrs

        expect(response).to redirect_to(profiles_path)
        expect(flash[:notice]).to eq(I18n.t('flashes.profiles.update.success'))
      end

      context 'when changing teams' do
        it 'modifies the profile assigned onboarding items' do
          admin_sign_in
          profile = create(:profile, team: Team.find_by(name: 'Android'))
          other_team = Team.find_by(name: 'Backend')
          create(:onboarding_item, subject: profile.team)
          item = create(:onboarding_item, subject: other_team)
          AssignedOnboardingItemsCreator.perform(profile: profile)
          params = create_new_profile_attrs.merge(team_id: other_team.id)

          patch :update, id: profile, enrollment_form: params
          profile.reload

          expect(profile.onboarding_items).to match_array([item])
        end
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template with a notice on failed save' do
        admin_sign_in
        invalid_attrs = create_invalid_profile_attrs
        profile = create(:profile)

        patch :update, id: profile, enrollment_form: invalid_attrs

        expect(response).to render_template('edit')
        expect(flash[:alert]).to eq(I18n.t('flashes.profiles.update.failure'))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a user and a profile' do
      admin_sign_in
      profile = create(:profile)

      delete :destroy, id: profile

      expect(response).to redirect_to(profiles_path)
      expect(flash[:notice]).to eq(I18n.t('flashes.profiles.destroy.success'))
    end

    it 'deletes all associated assigned onboarding items' do
      admin_sign_in
      profile = create(:profile)
      create(:assigned_onboarding_item, profile: profile)

      delete :destroy, id: profile

      expect(profile.assigned_onboarding_items).to be_empty
    end
  end

  def build_profile
    user = build(:user)
    profile = build(:profile, user: user)
    profile
  end

  def create_new_profile_attrs
    new_user = build(:user)
    new_profile = build(:profile, user: new_user)
    new_profile.attributes.except('id',
                                  'created_at',
                                  'updated_at',
                                  'photo_content_type',
                                  'photo_file_size',
                                  'photo_updated_at').
                                  merge('email' => new_profile.email)
  end

  def create_invalid_profile_attrs
    new_user = create(:user, email: 'taken@intrepid.io')
    invalid_profile_attrs = { 'email' => new_user.email }
  end
end
