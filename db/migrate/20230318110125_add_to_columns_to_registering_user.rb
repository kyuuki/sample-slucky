class AddToColumnsToRegisteringUser < ActiveRecord::Migration[7.0]
  def change
    add_column :registering_users, :name, :string
    add_column :registering_users, :name_kana, :string
    add_column :registering_users, :phone_number, :string
    add_column :registering_users, :zipcode, :string
    add_column :registering_users, :prefecture_id, :integer
    add_column :registering_users, :address, :string
    add_column :registering_users, :birthday, :date
  end
end
