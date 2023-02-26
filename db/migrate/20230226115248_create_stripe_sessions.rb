class CreateStripeSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :session_identifier
      t.string :status

      t.timestamps
    end
  end
end
