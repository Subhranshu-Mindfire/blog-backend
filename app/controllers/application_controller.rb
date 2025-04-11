class ApplicationController < ActionController::API
  rescue_from TokenNotFound, with: :handle_token_not_found

  private

  def handle_token_not_found(exception)
    render json: { error: exception.message }, status: :unauthorized
  end
end
