class AddDateToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :tweet_created_at, :datetime
  	add_column :tweets, :hashtag, :string
  end
end
