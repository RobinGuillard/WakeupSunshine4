class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :heures
      t.integer :minutes
      t.string :lieu
      t.boolean :active

      t.timestamps :creation
    end
  end
end
