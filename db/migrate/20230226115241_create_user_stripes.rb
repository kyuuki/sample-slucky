class CreateUserStripes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stripes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_customer_identifier
      t.string :status

      t.timestamps
    end
  end
end
