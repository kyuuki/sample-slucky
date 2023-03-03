class CreateServiceStripes < ActiveRecord::Migration[7.0]
  def change
    create_table :service_stripes do |t|
      t.references :service, null: false, foreign_key: true
      t.string :stripe_price_identifier

      t.timestamps
    end
  end
end
