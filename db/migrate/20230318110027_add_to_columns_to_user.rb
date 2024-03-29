class AddToColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :name_kana, :string
    add_column :users, :phone_number, :string
    add_column :users, :zipcode, :string
    add_column :users, :prefecture_id, :integer
    add_column :users, :address, :string
    add_column :users, :birthday, :date
  end
end
