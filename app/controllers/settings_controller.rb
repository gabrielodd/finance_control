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
      redirect_to categorias_settings_path, notice: t('settings.category_created')
    else
      render :new
    end
  end

  def update_categories
    category_ids = params[:category_ids]
    current_user.user_configuration.update(categories: category_ids.map(&:to_i))

    redirect_to categorias_settings_path, notice: t('settings.category_updated')
  end

  def change_locale
    locale = params[:locale]
    user_config = current_user.user_configuration
    user_config.locale = locale
    user_config.save

    session[:locale] = locale
    I18n.locale = locale
    
    redirect_back(fallback_location: root_path)
  end

  def change_panel_color
    current_user.user_configuration.update(panel_color: params[:panel_color])

    redirect_back(fallback_location: root_path)
  end

  def change_currency
    current_user.user_configuration.update(currency: params[:currency])

    redirect_back(fallback_location: root_path)
  end

  def change_ordering
    current_user.user_configuration.update(order: params[:order])

    redirect_back(fallback_location: root_path)
  end

  private

  def category_params
    params.require(:categoria).permit(:name, :description)
  end
end