describe HireType do
  describe 'associations' do
    it { should have_many(:profiles) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:contract_type)}
    it { should define_enum_for(:contract_type).
           with([:full_time, :apprentice]) }
    it { should validate_presence_of(:work_status) }
    it { should define_enum_for(:work_status).
           with([:no_visa, :visa]) }
  end
end
