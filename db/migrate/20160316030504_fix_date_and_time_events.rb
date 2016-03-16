class FixDateAndTimeEvents < ActiveRecord::Migration
  def change
  	change_column :events, :event_date, :string
  	change_column :events, :event_time, :string
  	add_column :events, :hashtag, :string
  end
end
