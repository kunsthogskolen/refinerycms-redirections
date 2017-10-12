class Refinery::Redirections::RedirectionsController < ActionController::Base
  def redirect
    redirection =
      Refinery::Redirections::Redirection.from_url(request.fullpath).first
    return if redirection.nil?
    redirect_to(redirection.to_url, status: redirection.status_code)
  end
end
