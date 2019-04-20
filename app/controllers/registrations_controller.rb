class RegistrationsController < ApplicationController
	def new

	end

	def create
		@user = User.new(registration_params)
    if @user.save
			flash[:notice] = 'User was successfully registered.'
			redirect_to root_url
    else
			flash[:notice] = "Error: "+@user.errors.messages.to_s
			redirect_to :registrations
    end
	end

	private
		def registration_params
			params.require(:registrations).permit(:name, :last_name, :email, :phone, :password)
		end

end
