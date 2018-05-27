class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	# above code This type of method call is called a callback. The before_action part is called a filter

	# The next parameter means that it should only be run for the actions inside that array: show, edit, update, and destroy.

	# What it means is, before any action is run in this controller, call the method set_user. 
	
	# The below code makes sure the user is signed in before trying to access the users_controller
	before_action :authenticate_user
	# The below code will find the user, set the @user variable, and check their abilities to make sure they are authorized to perform that action.
	load_and_authorize_resource
	
	# GET /users
	# GET /users.json
	def index
		@users = User.all
	end

	# GET /users/1
	# GET /users/1.json
	def show
	end

	# GET /users/new
	def new
		@user = User.new
	end

	# GET /users/1/edit
	def edit
	end

	# POST /users
	# POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
def update
	respond_to do |format|
		if @user.update(user_params)
			format.html { redirect_to @user, notice: 'User was successfully updated.' }
			format.json { render :show, status: :ok, location: @user }
		else
			format.html { render :edit }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		end
	end
end

# DELETE /users/1
# DELETE /users/1.json
def destroy
	@user.destroy
	respond_to do |format|
		format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
		format.json { head :no_content }
	end
end

private
# If you look down in the private methods, you'll see that this method takes the ID parameter, fetches a user record from that database, and sets the @user variable:

# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def user_params
		params.require(:user).permit(:first_name, :last_name)
	end
end
