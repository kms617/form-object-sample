namespace :data do
  namespace :employees do
    desc 'Create the Employees profile and user models'
    task load: :environment do

      employee_data_path = Rails.root.join('db/data/employees.csv')
      employee_data = File.read(employee_data_path)
      employees_count = employee_data.each_line.count - 1

      CSV.parse(employee_data,
                headers: true,
                header_converters: :symbol).each do |employee|
        profile = Employee.create(employee)
      end
    end

    class Employee
      def initialize(attrs)
        @attrs = attrs.to_h
      end

      def self.create(attrs)
        new(attrs).create
      end

      def create
        profile = Profile.create(bio: bio,
                                 communication_style: communication_style,
                                 first_name: @attrs[:first_name],
                                 hire_type: hire_type,
                                 last_name: @attrs[:last_name],
                                 photo: photo_url,
                                 slack_handle: @attrs[:slack_handle],
                                 team: team,
                                 title: @attrs[:title])
        User.find_or_create_by(email: @attrs[:email], profile: profile)
        profile
      end

      private

      def bio
        'This is my bio. There are many like it, but this one is mine.'
      end

      def team
        Team.find_by!(name: @attrs[:team])
      end

      def communication_style
        'Communicative'
      end

      def hire_type
        contract = @attrs[:hire_type].parameterize.underscore
        numeric_contract = HireType.contract_types[contract]
        work_status = @attrs[:visa]
        numeric_work_status = HireType.work_statuses[work_status]
        HireType.find_by!(contract_type: numeric_contract,
                          work_status: numeric_work_status)
      end

      def photo_url
        'http://lorempixel.com/100/200/people/'
      end
    end
  end
end
