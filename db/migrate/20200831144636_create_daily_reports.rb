class CreateDailyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports do |t|
      t.string :state

      t.timestamps
    end
  end
end
