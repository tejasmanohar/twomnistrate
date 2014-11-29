# helper methods
helpers do
  # is the user admin?
  def logged_in?
    session[:admin] if env['omniauth.auth']
  end
end
