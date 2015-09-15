class CreateEventOffices < ActiveRecord::Migration
  def change
    create_table :event_offices do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
