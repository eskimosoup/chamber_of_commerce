class CreateAttendeeEventAgendas < ActiveRecord::Migration
  def change
    create_table :attendee_event_agendas do |t|
      t.belongs_to :attendee, index: true, foreign_key: true
      t.belongs_to :event_agenda, index: true, foreign_key: true
      t.decimal :price, precision: 8, scale: 2, default: 0.00

      t.timestamps null: false
    end
  end
end
