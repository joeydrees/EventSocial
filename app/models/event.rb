class Event < ActiveRecord::Base
	has_many :users

	has_many :subscribers, through: :passive_subscriptions, source: :subscriber
	has_many :passive_relationships, class_name:  "Subscription", foreign_key: "subscribed_id", dependent: :destroy

end