# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    if resource.avatar.attached?
      resource.pfp_url = url_for(current_user.avatar)
      resource.save
    end

    super(resource)
  end
end
