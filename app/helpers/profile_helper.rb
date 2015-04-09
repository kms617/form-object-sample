module ProfileHelper
  def link_to_delete_profile(profile)
    link_to 'Delete User',
            profile_path(profile),
            method: :delete,
            data: { confirm: t('helpers.confirmation.delete') }
  end
end
