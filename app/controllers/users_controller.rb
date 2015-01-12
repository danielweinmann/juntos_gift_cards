class UsersController < StateController
  
  respond_to :html

  def index
    @users = policy_scope(User)
    authorize User.new
    respond_with @users
  end

end
