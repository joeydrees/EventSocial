class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@event = Event.find(params[:event_id])
		@comments = Comment.where(event_id: @event.id)
		@comment = Comment.new
	end

	def new
		@event = Event.find(params[:event_id])
		@comment = Comment.new(:parent_id => params[:parent_id])
	end

	def show
		@event = Event.find(params[:event_id])
		@comment = Comment.find(params[:id])
	end

    def create
    	@event = Event.find(params[:event_id])
    	@comments = Comment.where(event_id: @event.id)
    	@comment = Comment.new(comment_params)
    	@comment.user_id = current_user.id
    	@comment.event_id = @event.id
	    if @comment.save
	      	respond_to do |format|
	      		flash.now[:notice] = 'Comment was sucessfully posted.'
	        	format.html do
	          		flash[:notice] = 'Comment was sucessfully posted.'
	          		redirect_to event_comments_path(@event, @comments)
	        	end
	        	format.js
	      	end
	    else
	    	flash[:alert] = 'There was an error posting your comment.'
	    	redirect_to event_comments_path(@event, @comments)
	    end
  	end

	def destroy
		@event = Event.find(params[:event_id])
		@comments = Comment.where(event_id: @event.id)
		@comment = Comment.find(params[:id])
	    if @comment.destroy
		    respond_to do |format|
		    	flash.now[:notice] = 'Comment was sucessfully deleted.'
			    format.html do
			    	flash[:notice] = 'Comment was successfully deleted.'
			        redirect_to event_comments_path(@event, @comments)
			    end
			    format.js
			end
		else
			flash[:alert] = 'There was an error posting your comment.'
	    	redirect_to event_comments_path(@event, @comments)
	    end
	end

  	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def comment_params
	      params.require(:comment).permit(:comment, :parent_id)
	    end

end