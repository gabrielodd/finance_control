class UserConfiguration < ApplicationRecord
  belongs_to :user

  def panel_color
    self[:panel_color] || "bg-2"
  end
end
