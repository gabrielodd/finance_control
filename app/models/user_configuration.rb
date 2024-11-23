class UserConfiguration < ApplicationRecord
  belongs_to :user

  serialize :categories, Array

  after_initialize :set_default_categories

  def panel_color
    self[:panel_color] || "bg-2"
  end

  private

  def set_default_categories
    self.categories ||= Categoria.global_categories.pluck(:id)
  end
end
