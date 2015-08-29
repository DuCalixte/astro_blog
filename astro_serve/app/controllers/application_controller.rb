require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json

  before_filter :set_headers

  private

  def set_headers
    if request.headers["HTTP_ORIGIN"]
    	puts '*********************************************'
      # better way check origin
      # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
      headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
      headers['Access-Control-Max-Age'] = '86400'
      headers['Access-Control-Allow-Credentials'] = 'true'
    else
    	puts '------------------------------------------------'
      headers['Access-Control-Allow-Origin'] = 'http://localhost:4000'
      headers['Access-Control-Expose-Headers'] = 'ETag'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match'
      headers['Access-Control-Max-Age'] = '86400'
    end


  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
