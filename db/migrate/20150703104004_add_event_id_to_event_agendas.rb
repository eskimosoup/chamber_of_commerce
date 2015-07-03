class AddEventIdToEventAgendas < ActiveRecord::Migration
  def change
    add_reference :event_agendas, :event, index: true, foreign_key: true
  end
end
