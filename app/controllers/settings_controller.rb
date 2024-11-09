class SettingsController < ApplicationController
  def index
    @user = current_user
  end

  def categorias
    @categories = Categoria.user_categories(current_user)
  end

  def create_category
    @category = Categoria.new(category_params)
    @category.user_id = current_user.id

    if @category.save
      redirect_to settings_categorias_path, notice: "Category created successfully."
    else
      render :new
    end
  end

  def change_locale
    locale = params[:locale]
    user_config = current_user.user_configuration || current_user.build_user_configuration
    user_config.locale = locale
    user_config.save

    session[:locale] = locale
    I18n.locale = locale
    
    redirect_back(fallback_location: root_path)
  end

  private

  def category_params
    params.require(:categoria).permit(:name, :description)
  end
end