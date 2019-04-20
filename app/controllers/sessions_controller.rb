class SessionsController < ApplicationController
	def new
	end

	def create
		credentials = session_params
		if user = authenticate(credentials[:email], credentials[:password])
			session[:current_user_id] = user.id
			flash[:notice] = "You have successfully logged in."
			redirect_to user_path(session[:current_user_id])
		else
			flash[:notice] = "Error: Invalid credentials."
			redirect_to root_url
		end
	end

	def destroy
		session[:current_user_id] = nil
		flash[:notice] = "You have successfully logged out."
		redirect_to root_url
	end

	private
		def session_params
			params.require(:session).permit(:email, :password)
		end

		def authenticate(email, password)
			user = User.where(["email = ? and password = ?", email, password])[0]
		end

end
