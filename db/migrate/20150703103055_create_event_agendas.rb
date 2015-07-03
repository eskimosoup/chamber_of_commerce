class CreateEventAgendas < ActiveRecord::Migration
  def change
    create_table :event_agendas do |t|
      t.string :name, null: false
      t.belongs_to :event_category, index: true, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.text :description
      t.integer :maximum_capacity

      t.timestamps null: false
    end
  end
end
