class Tweet < ActiveRecord::Base

	belongs_to :event

	def self.get_tweet(tweet, event)
		where(id_str: tweet.id).first_or_create do |t|
    		t.name =  tweet.user.name
    		t.username = tweet.user.screen_name
    		t.text = tweet.text
 			t.id_str = tweet.id
 			t.event_id = event.id
 			t.tweet_created_at = tweet.created_at
 			t.hashtag = event.hashtag
   		end
	end

	def self.search(hashtag, count)
		@search = $twitter.search("##{hashtag} -filter:retweets", lang: "en").take(count)
		return @search
	end

end