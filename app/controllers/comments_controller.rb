class CommentsController < ApplicationController

	before_filter :authenticate_user!

	def index
		@event = Event.find(params[:event_id])
		@comments = Comment.all
	end

	def new
		@comments = Comment.all
		@event = Event.find(params[:event_id])
		@comment = Comment.new
	end

    def create
    	@event = Event.find(params[:event_id])
    	@comments = Comment.all
    	@comment = Comment.new(comment_params)
    	@comment.user_id = current_user.id
    	@comment.event_id = @event.id
	    if @comment.save
	      	respond_to do |format|
	        	format.html do
	          		flash[:notice] = 'Comment was sucessfully posted.'
	          		redirect_to event_comments_path(@event, @comments)
	        	end
	        	format.js # JavaScript response
	      	end
	    end
  	end

	def edit
		@comment = Comment.find(params[:id])
	end

	def update
		@comments = Comment.all
		@comment = Comment.find(params[:id])

		@comment.update_attributes(comment_params)
	end

	def destroy
		@comment = Comment.find(params[:id])
	    @post = @comment.post
	    @comment.destroy
	    respond_to do |format|
		    format.html do
		    	flash[:notice] = 'Comment was successfully deleted.'
		        redirect_to event_comments_path(@event, @comments)
		    end
		    format.js # JavaScript response
		end
	end

  	private

  		def all_comments
	      @comments = Comment.all
	    end

	    def set_comments
	      @comment = Comment.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def comment_params
	      params.require(:comment).permit(:comment)
	    end

end