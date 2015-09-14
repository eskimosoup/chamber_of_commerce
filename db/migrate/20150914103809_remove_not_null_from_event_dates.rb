class RemoveNotNullFromEventDates < ActiveRecord::Migration
  def change
    change_column :events, :start_date, :date, null: true
    change_column :events, :end_date, :date, null: true
  end
end
