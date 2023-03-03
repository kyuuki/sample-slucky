class CreateSubscriptionStripes < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_stripes do |t|
      t.references :subscription, null: false, foreign_key: true
      t.string :stripe_customer_identifier
      t.string :status

      t.timestamps
    end
  end
end
