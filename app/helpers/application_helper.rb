module ApplicationHelper
  def full_time_employees_for_select
    full_time_ids = HireType.full_time.pluck(:id)
    employees = Profile.where(hire_type_id: full_time_ids).order(:first_name)
    decorated_employees = ProfileDecorator.decorate_collection(employees)
    decorated_employees.map { |employee| [employee.full_name, employee.id] }
  end

  def hire_types_for_select
    HireType.ordered.map { |hire_type| [hire_type.name, hire_type.id] }
  end

  def teams_for_select
    Team.ordered.map { |team| [team.name, team.id] }
  end
end
