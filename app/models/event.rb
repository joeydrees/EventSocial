class Event < ActiveRecord::Base
	
	has_many :users
	has_many :tweets

	has_attached_file :event_pic, 
					  :styles => { :medium => "800x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	
  	validates_attachment_content_type :event_pic, :content_type => /\Aimage\/.*\Z/

	has_many :subscribers, through: :passive_relationships, source: :subscriber
	has_many :passive_relationships, class_name:  "Subscription", foreign_key: "subscribed_id", dependent: :destroy

	def getYear(event_date)
		values = event_date.split(" ")
		year = values[2]
		return year
	end

	def getMonth(event_date)
		values = event_date.split(" ")
		month = values[0]
		if month == "January"
			return 1
		elsif month === "February"
			return 2
		elsif month == "March"
			return 3
		elsif month == "April"
			return 4
		elsif month == "May"
			return 5
		elsif month == "June"
			return 6
		elsif month == "July"
			return 7
		elsif month == "August"
			return 8
		elsif month == "September"
			return 9
		elsif month == "October"
			return 10
		elsif month == "November"
			return 11
		elsif month == "December"
			return 12
		else
			return -1
		end
	end

	def getDay(event_date)
		values = event_date.split(" ")
		day = values[1][0..1]
		return day
	end

	def getHour(event_time)
		time = event_time.split(" ")[1]
		hour = time.split(":")[0]
		return hour
	end

	def getMinute(event_time)
		time = event_time.split(" ")[1]
		hour = time.split(":")[2]
		return hour
	end
end