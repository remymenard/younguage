class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.text :content
      t.string :author
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
