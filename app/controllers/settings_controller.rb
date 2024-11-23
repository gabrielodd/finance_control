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
      redirect_to categorias_settings_path, notice: "Category created successfully."
    else
      render :new
    end
  end

  def update_categories
    category_ids = params[:category_ids]
    current_user.user_configuration.update(categories: category_ids.map(&:to_i))

    redirect_to categorias_settings_path, notice: "Categories updated successfully."
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

  def change_panel_color
    panel_color = params[:panel_color]
    user_config = current_user.user_configuration || current_user.build_user_configuration
    user_config.panel_color = panel_color
    user_config.save

    redirect_back(fallback_location: root_path)
  end

  def change_currency
    currency = params[:currency]
    user_config = current_user.user_configuration || current_user.build_user_configuration
    user_config.currency = currency
    user_config.save

    redirect_back(fallback_location: root_path)
  end

  def change_ordering
    order = params[:order]
    user_config = current_user.user_configuration || current_user.build_user_configuration
    user_config.order = order
    user_config.save

    redirect_back(fallback_location: root_path)
  end

  private

  def category_params
    params.require(:categoria).permit(:name, :description)
  end
end