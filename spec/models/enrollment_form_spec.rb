describe EnrollmentForm do
  describe 'validations' do
    it 'validates presence of email' do
      profile = create(:profile)
      user = profile.user

      form = EnrollmentForm.new(email: user.email)

      expect(form).to validate_presence_of(:email)
    end
  end

  describe '.save' do
    context 'valid attributes' do
      it 'creates a valid user and profile' do
        user = build(:user)
        profile = build(:profile, user: user)

        form = EnrollmentForm.new(email: profile.email,
                                  first_name: profile.first_name,
                                  last_name: profile.last_name,
                                  hire_type_id: profile.hire_type_id,
                                  team_id: profile.team_id)
        form.save

        expect(User.count).to eq(1)
        expect(Profile.count).to eq(1)
      end
    end

    context 'missing user attributes' do
      it 'creates neither a user nor profile' do
        user = build(:user)
        profile = build(:profile, user: user)

        form = EnrollmentForm.new(first_name: profile.first_name,
                                  last_name: profile.last_name,
                                  hire_type_id: profile.hire_type_id,
                                  team_id: profile.team_id)
        form.save

        expect(User.count).to eq(0)
        expect(Profile.count).to eq(0)
      end
    end

    context 'invalid user attributes' do
      it 'creates neither a user nor profile' do
        taken = create(:user)
        user = build(:user)
        profile = build(:profile, user: user)

        form = EnrollmentForm.new(email: taken.email,
                                  first_name: profile.first_name,
                                  last_name: profile.last_name,
                                  hire_type_id: profile.hire_type_id,
                                  team_id: profile.team_id)
        form.save

        expect(User.count).to eq(1)
        expect(Profile.count).to eq(0)
      end
    end

    context 'invalid profile attributes' do
      it 'creates neither a user nor profile' do
        user = build(:user)

        form = EnrollmentForm.new(email: user.email)
        form.save

        expect(User.count).to eq(0)
        expect(Profile.count).to eq(0)
      end
    end
  end

  describe '.update' do
    context 'valid attributes' do
      it 'udpates a user and profile' do
        profile = create(:profile)

        form = EnrollmentForm.new(email: 'new@intrepid.io',
                                  first_name: 'New',
                                  last_name: 'Newman'
                                  )
        form.update(profile.user.id, profile.id)

        expect(User.count).to eq(1)
        expect(Profile.count).to eq(1)
      end
    end

    context 'invalid user attributes' do
      it 'updates neither the user nor profile' do
        taken = create(:user)
        profile = create(:profile)

        form = EnrollmentForm.new(email: taken.email,
                                  first_name: 'New',
                                  last_name: 'Newman'
                                  )
        form.update(profile.user.id, profile.id)

        expect(profile.email).not_to eq(taken.email)
        expect(profile.first_name).not_to eq('New')
        expect(User.count).to eq(2)
        expect(Profile.count).to eq(1)
      end
    end

    context 'invalid profile attributes' do
      it 'updates neither the user nor profile' do
        profile = create(:profile)

        form = EnrollmentForm.new(email: 'new@intrepid.io',
                                  first_name: nil
                                  )
        form.update(profile.user.id, profile.id)

        expect(profile.email).not_to eq('new@intrepid.io')
        expect(User.count).to eq(1)
        expect(Profile.count).to eq(1)
      end
    end
  end

  describe '.reset_default_photo' do
    it 'resets the photo to nil' do
      profile = create(:profile, :has_photo)

      form = EnrollmentForm.new(reset_photo: '1')
      form.reset_default_photo(profile.id)

      profile.reload
      expect(profile.photo_file_name).to eq(nil)
    end
  end
end
