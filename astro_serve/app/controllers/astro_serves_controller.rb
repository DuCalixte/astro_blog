class AstroServesController < ApplicationController
	# before_filter :set_blog!, except: [:create, :index]
	# render :layout => false
	layout false
	respond_to :json

  def index
  	respond_with AstroBlog.all
  end

  def show
  	# respond_with @blog, serializer: AstroBlogSerializer
  	respond_with AstroBlog.find(params[:uuid]), serializer: AstroBlogSerializer
  end

  def create
  	AstroBlog.transaction do
  	  @blog = AstroBlog.new create_params
      @blog.save
  	end
  	respond_with @blog
  end

  private

    def set_blog!
    @blog = AstroBlog.cached_find(params[:uuid])
  end
end
