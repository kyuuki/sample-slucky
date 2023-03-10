class CreateSubscriptionValidPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :subscription_valid_periods do |t|
      t.references :subscription, null: false, foreign_key: true
      t.datetime :starts_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
