class Comment < ActiveRecord::Base
	belongs_to :event
	has_ancestry
end