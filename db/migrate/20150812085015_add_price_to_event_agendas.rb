class AddPriceToEventAgendas < ActiveRecord::Migration
  def change
    add_column :event_agendas, :price, :decimal, precision: 8, scale: 2, default: 0.00
  end
end
