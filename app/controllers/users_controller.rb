class UsersController < StateController
  
  before_action :set_user, except: %i[index]

  respond_to :html

  def index
    @users = policy_scope(User)
    authorize User.new
    respond_with @users
  end

  def make_pending
    transition_state(:make_pending)
  end

  def make_regular
    transition_state(:make_regular)
  end

  def make_admin
    transition_state(:make_admin)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def transition_state(transition)
    super(@user, transition, users_path)
  end

end
