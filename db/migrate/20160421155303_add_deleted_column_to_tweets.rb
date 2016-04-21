class AddDeletedColumnToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :deleted, :boolean, :default => false
  end
end
