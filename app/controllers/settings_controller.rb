class SettingsController < ApplicationController
  def index
    @user = current_user
  end

  def change_locale
    locale = params[:locale]
    
    session[:locale] = locale
    I18n.locale = locale
    
    redirect_back(fallback_location: root_path)
  end
end