class AddUserIdToCategoria < ActiveRecord::Migration[6.0]
  def change
    add_reference :categoria, :user, foreign_key: true, index: true, null: true
  end
end
