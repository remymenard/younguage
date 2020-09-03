class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.text :subtitles
      t.string :author
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
