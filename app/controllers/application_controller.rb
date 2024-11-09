class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = current_user&.user_configuration&.locale || session[:locale] || I18n.default_locale
  end
end
