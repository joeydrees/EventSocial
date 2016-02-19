class Tweet < ActiveRecord::Base

	def self.get_tweet(tweet)
		where(id_str: tweet.id).first_or_create do |t|
    		t.name =  tweet.user.name
    		t.username = tweet.user.screen_name
    		t.text = tweet.text
 			t.id_str = tweet.id
   		end
	end

	def self.search(hashtag, count)
		@search = $twitter.search("##{hashtag} -filter:retweets", lang: "en").take(count)
		return @search
	end

end