class AddForeignKeyBulletinsUsers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :bulletins, :users, on_delete: :cascade
  end
end
