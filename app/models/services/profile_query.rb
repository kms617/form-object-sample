class ProfileQuery
  def apprentices
    Profile.ordered.
            where(hire_type_id: apprentice_hire_ids)
  end

  def full_time
    Profile.find_by_sql(['SELECT DISTINCT p.*
                          FROM profiles p
                          INNER JOIN assigned_onboarding_items aobi
                          ON aobi.profile_id = p.id
                          INNER JOIN hire_types ht
                          ON ht.id = p.hire_type_id
                          WHERE ht.id IN (?)
                          AND p.created_at < ?
                          GROUP BY p.id
                          HAVING SUM(CASE WHEN aobi.completed_at IS NULL THEN 1 ELSE 0 END) = 0
                          ORDER BY p.first_name ASC',
                         full_time_hire_ids,
                         2.weeks.ago])
  end

  def new_hires
    Profile.find_by_sql(['SELECT DISTINCT p.*
                          FROM profiles p
                          INNER JOIN assigned_onboarding_items aobi
                          ON aobi.profile_id = p.id
                          JOIN hire_types ht
                          ON ht.id = p.hire_type_id
                          WHERE ht.id IN (?)
                          AND (p.created_at >= ?
                          OR aobi.completed_at IS NULL)
                          ORDER BY p.first_name ASC',
                         full_time_hire_ids,
                         2.weeks.ago])
  end

  private

  def apprentice_hire_ids
    @apprentice_hire_ids ||= HireType.apprentice.pluck(:id)
  end

  def full_time_hire_ids
    @full_time_hire_ids ||= HireType.full_time.pluck(:id)
  end
end
