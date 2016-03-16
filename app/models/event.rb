class Event < ActiveRecord::Base
	has_many :users

	has_many :subscribers, through: :passive_relationships, source: :subscriber
	has_many :passive_relationships, class_name:  "Subscription", foreign_key: "subscribed_id", dependent: :destroy

	validates_presence_of :name

end