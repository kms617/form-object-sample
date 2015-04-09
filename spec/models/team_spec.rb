describe Team do
  describe 'associations' do
    it { should have_many(:profiles) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
