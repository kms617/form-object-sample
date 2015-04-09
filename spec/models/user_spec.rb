describe User do
  describe 'associations' do
    it { should belong_to(:profile) }
  end

  describe 'validations' do
    context 'email' do
      it { should validate_presence_of(:email) }

      it 'is valid' do
        user = build :user, email: 'foo@intrepid.io'
        expect(user).to be_valid
      end

      it 'is invalid with a nil email' do
        user = build :user, email: nil
        expect(user).to_not be_valid
      end

      it 'is invalid' do
        user = build :user, email: 'fooexamplecom'
        expect(user).to_not be_valid
      end
    end
  end
end
