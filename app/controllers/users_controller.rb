##
# Users Controller: User Registration
#
class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user, only: [:show, :index]
  
  def index
    @notes = Note.all.order(created_at: :desc)
  end

  #show all user notes to be shared to all
  def show 
    @notes = Note.all.order(created_at: :desc)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users : Register new user
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {}).permit(:name, :email, :password, :password_confirmation)
    end
end
