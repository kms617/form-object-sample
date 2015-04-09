describe Profile, model: true do
  describe 'associations' do
    it { should belong_to(:hire_type) }
    it { should belong_to(:team) }
    it { should have_one(:user) }
    it { should delegate_method(:email). to(:user) }
    it { should belong_to(:manager) }
    it { should belong_to(:mentor) }
    it { should have_attached_file(:photo) }
  end

  describe 'validations' do
    it { should validate_length_of(:bio).is_at_most(140) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:hire_type) }
    it { should validate_length_of(:slack_handle).is_at_most(21) }
    it { should validate_presence_of(:team) }
    it { should validate_attachment_content_type(:photo).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:photo).
                less_than(4.megabytes) }
  end
end
