class AddMustBookToEventAgenda < ActiveRecord::Migration
  def change
    add_column :event_agendas, :must_book, :boolean
  end
end
