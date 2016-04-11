class Comment < ActiveRecord::Base
	belongs_to :event
	has_ancestry

	validates :comment, :presence => true
end