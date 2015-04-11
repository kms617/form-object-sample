namespace :data do
  task load: 'db:setup' do
    Rake::Task['data:employees:load'].invoke
  end
end
