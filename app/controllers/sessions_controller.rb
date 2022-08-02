class SessionsController < ApplicationController
  
  def new 
  
  end

  def create
    
    user = User.authenticate_with_credentials(params[:email], params[:password])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
      redirect_to root_path
      
    else
      #flash[:alert] = ' Invalid email or password'
      redirect_to "/login", notice: 'Invalid Email or Password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

