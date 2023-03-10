class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :service, null: false, foreign_key: true
      t.string :title
      t.text :video_tag
      t.text :content
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
