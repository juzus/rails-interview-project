class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :api_key, index: true, null: false, unique: true

      t.timestamps null: false
    end
  end
end
