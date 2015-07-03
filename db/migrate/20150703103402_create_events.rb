class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.references :event_agendas, index: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :image
      t.references :event_location, index: true
      t.text :description
      t.boolean :display, default: true
      t.integer :event_agendas_count, default: 0

      t.timestamps null: false
    end
  end
end
