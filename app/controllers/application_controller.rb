class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user! #NB => TO CHANGE
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # Defines profile type at user creation => permitted params management => Devise
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password,
     :password_confirmation, :first_name, :last_name, :phone, :gender, :age,
     :country_of_origin, :address, :arrival_date, :category, user_languages_attributes: [:id, :language_id, :_destroy] )
    }
  end

end
