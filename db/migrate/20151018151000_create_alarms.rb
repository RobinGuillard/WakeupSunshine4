class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.integer :heures
      t.integer :minutes
      t.string :lieu

      t.timestamps null: false
    end
  end
end
