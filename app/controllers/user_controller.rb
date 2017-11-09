class UserController < ApplicationController
  def index
    if session[:user_id]
      @email = User.find(session[:user_id]).email
    end
  end

  def new
    
  end

  def create
    require 'digest'
    @email = params[:user_email]
    @password = params[:user_pw]
    hidden_password = Digest::MD5.hexdigest(@password)
    
    User.create(
      email: @email,
      password: hidden_password
    )
  end
  
  def login
    
  end
  
  def login_process
    require 'digest'
    # 로그인으로 받아온 정보의 유저가 DB에 있는지 확인
    # 만약에 있다면, 비밀번호가 맞는지 확인
    # 그것도 만약에 맞다면, 로그인 시키기
    if User.exists?(email: params[:user_email])
      user = User.find_by(email: params[:user_email])
      if user.password == Digest::MD5.hexdigest(params[:user_pw])
        session[:user_id] = user.id
        p "로그인이 됐습니다."
        redirect_to '/'
      end
    end
  end
  
end
