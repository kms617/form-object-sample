class ProfilesController < ApplicationController
  def index
    @profiles = Profile.ordered
  end

  def new
    @enrollment = EnrollmentForm.new(bio: t('helpers.defaults.profile.bio'))
  end

  def create
    @enrollment = EnrollmentForm.new(enrollment_params)

    if @enrollment.save
      flash[:notice] = t('flashes.profiles.create.success')
      redirect_to profiles_path
    else
      flash[:alert] = t('flashes.profiles.create.failure')
      render :new
    end
  end

  def edit
    @profile = find_profile
    profile_attrs = create_profile_attrs(@profile)

    @enrollment = EnrollmentForm.new(profile_attrs)
  end

  def update
    @profile = find_profile
    @enrollment = EnrollmentForm.new(enrollment_params)

    if @enrollment.update(@profile.user.id, @profile.id)
      flash[:notice] = t('flashes.profiles.update.success')
      redirect_to profiles_path
    else
      flash[:alert] = t('flashes.profiles.update.failure')
      render :edit
    end
  end

  def destroy
    @profile = Profile.find(params[:id])

    if @profile.destroy
      flash[:notice] = t('flashes.profiles.destroy.success')
      redirect_to profiles_path
    else
      flash[:alert] = t('flashes.profiles.destroy.failure')
      render :edit
    end
  end

  private

  def create_profile_attrs(profile)
    profile.
      attributes.
      except('id',
             'created_at',
             'updated_at',
             'photo_content_type',
             'photo_file_size',
             'photo_updated_at').
      merge('email' => profile.email)
  end

  def enrollment_params
    params.
      require(:enrollment_form).
      permit(:bio,
             :communication_style,
             :first_name,
             :hire_type_id,
             :last_name,
             :manager_id,
             :mentor_id,
             :photo_file_name,
             :reset_photo,
             :slack_handle,
             :team_id,
             :title,
             :email)
  end

  def find_profile
    Profile.
      includes(:user).
      find(params[:id])
  end
end
