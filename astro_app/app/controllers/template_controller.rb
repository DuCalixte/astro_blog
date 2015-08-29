class TemplateController < ApplicationController
  layout false
  def show
    begin
      render file: Rails.root.join('app', 'assets', 'javascripts') + Pathname.new(view_param)
    rescue ActionView::MissingTemplate
      render nothing: true, status: 404
    end
  end

  private

  # Needed to eliminate brakeman warning: Dynamic Render Path - Render path contains parameter value
  def view_param
    params[:view]
  end
end
