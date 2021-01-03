class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        profile_complete

        format.html { redirect_to races_path, notice: 'Race was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_complete
    u = current_user
    complete = (!u.name.nil? && u.name != '') \
               && (!u.birthdate.nil? &&  u.birthdate != '') \
               && (!u.gender.nil? && u.gender != '') \
               && (!u.phone.nil?  && u.phone != '') ? true : false

    u.update(profile_complete: true) if complete
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:id, :gender, :phone, :profile_complete, :name, :birthdate, :email)
  end
end
