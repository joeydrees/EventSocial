class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@event = Event.find(params[:event_id])
		@comments = Comment.where(event_id: @event.id, approved: true)
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
    	@comments = Comment.where(event_id: @event.id, approved: true)
    	@comment = Comment.new(comment_params)
    	@comment.user_id = current_user.id
    	@comment.event_id = @event.id
    	if @event.comments_approved == true
    		@comment.approved = true
    	else
    		@comment.approved = false
    	end
	    if @comment.save && @comment.approved == true
	      	respond_to do |format|
	      		flash.now[:notice] = 'Comment was sucessfully posted.'
	        	format.html do
	          		flash[:notice] = 'Comment was sucessfully posted.'
	          		redirect_to event_comments_path(@event, @comments)
	        	end
	        	format.js
	      	end
	    elsif @comment.save && @comment.approved == false
	    	respond_to do |format|
	      		flash.now[:notice] = 'Comment was successfully submitted for approval.'
	        	format.html do
	          		flash[:notice] = 'Comment was successfully submitted for approval.'
	          		redirect_to event_comments_path(@event, @comments)
	        	end
	        	format.js
	      	end
	    else
	    	flash[:alert] = 'There was an error creating your comment.'
	    	redirect_to event_comments_path(@event, @comments)
	    end
  	end

  	def update
	    @comment = Comment.find(params[:id])
	    if @comment.update_attribute(:approved, "true")
	    	flash[:notice] = "Comment was successfully approved."
	      	redirect_to event_manage_events_path
	    else
	      	flash[:alert] = "There was an error approving the comment."
	      	redirect_to event_manage_events_path
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
			        redirect_to event_manage_events_path
			    end
			    format.js
			end
		else
			flash[:alert] = 'There was an error deleting your comment.'
	    	redirect_to event_comments_path(@event, @comments)
	    end
	end

  	private

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def comment_params
	      params.require(:comment).permit(:comment, :parent_id, :approved)
	    end

end