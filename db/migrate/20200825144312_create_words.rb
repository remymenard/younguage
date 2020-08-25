class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :word
      t.string :translation
      t.boolean :mastered, default: false

      t.timestamps
    end
  end
end
