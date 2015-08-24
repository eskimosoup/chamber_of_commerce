class AddTableSizeAndTableDiscountToEventAgendas < ActiveRecord::Migration
  def change
    add_column :event_agendas, :table_size, :integer, default: 10
    add_column :event_agendas, :table_discount, :decimal, precision: 5, scale: 2, default: 0.00
  end
end
