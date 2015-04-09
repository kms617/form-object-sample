if Rails.env.development?
  require 'factory_girl'
  require Rails.root.join('spec', 'support', 'factories')

  namespace :dev do
    desc 'Seed data for development environment'
    task prime: 'db:setup' do
      include FactoryGirl::Syntax::Methods

      android = create(:team, :android)
      backend = create(:team, :backend)
      design = create(:team, :design)
      ios = create(:team, :ios)
      management = create(:team, :management)
      pm = create(:team, :pm)

      android_manager = create(:profile, team: android)

      create_list(:profile, 5, team: android, manager: android_manager)
      create_list(:profile, 5, team: backend)
      create_list(:profile, 5, team: design)
      create_list(:profile, 5, team: ios)
      create_list(:profile, 5, team: management)
      create_list(:profile, 5, team: pm)
    end
  end
end
