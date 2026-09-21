class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :render_bad_request
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_bad_request(exception)
    render json: { error: "Required parameter is missing: #{exception.param}" }, status: :bad_request
  end

  def render_not_found(exception)
    render json: { error: "#{exception.model} was not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: "The request contains invalid data",
      details: exception.record.errors.full_messages
    }, status: :unprocessable_content
  end
end
