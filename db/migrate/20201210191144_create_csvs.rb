class CreateCsvs < ActiveRecord::Migration[6.0]
  def change
    create_table :csvs do |t|
      t.string :name
      t.Date :date

      t.timestamps
    end
  end
end
