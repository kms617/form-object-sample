describe ProfileDecorator do
  describe 'full_name' do
    it 'assigns first and last name' do
      profile = create(:profile)
      full_name = "#{profile.first_name} #{profile.last_name}"

      decorator = ProfileDecorator.new(profile)

      expect(decorator.full_name).to eq(full_name)
    end
  end

  describe 'team_name' do
    it 'assigns team_name' do
      profile = create(:profile)

      decorator = ProfileDecorator.new(profile)

      expect(decorator.team_name).to eq(profile.team.name)
    end
  end
end
