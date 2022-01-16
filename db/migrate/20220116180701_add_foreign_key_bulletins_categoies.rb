class AddForeignKeyBulletinsCategoies < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :bulletins, :categories, on_delete: :cascade
  end
end
