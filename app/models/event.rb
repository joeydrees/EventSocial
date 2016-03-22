class Event < ActiveRecord::Base
	has_many :users
	has_many :tweets

	has_attached_file :event_pic, url: "/system/:hash.:extension", hash_secret: "csc440", :styles => { :medium => "800x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :event_pic, :content_type => /\Aimage\/.*\Z/

	has_many :subscribers, through: :passive_relationships, source: :subscriber
	has_many :passive_relationships, class_name:  "Subscription", foreign_key: "subscribed_id", dependent: :destroy

	validates_presence_of :name

end