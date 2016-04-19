class AddApprovedToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :tweets_approved, :boolean, :default => true
  	add_column :events, :comments_approved, :boolean, :default => true
  end
end
