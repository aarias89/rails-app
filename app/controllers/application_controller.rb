class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  protected

# following method will be left empty to be described in individual controllers.(application_controller extends to all other controllers.)
  def resource_not_found
  end
end
