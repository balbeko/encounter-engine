class Users < Application
  def show
    @user = User.find_by_id(params[:id])
    raise NotFound unless @user
    display @user
  end
  
  def new
    only_provides :html    
    @user = User.new(params[:user])
    render
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      authenticate_user
      send_welcome_letter_to @user
      redirect url(:dashboard)
    else
      render :new
    end
  end

protected

  def authenticate_user
    session.user = @user
  end

  def send_welcome_letter_to(user)
    send_mail NotificationMailer, :welcome_letter,
      { :to => user.email,
        :from => "info@al.en.cx",
        :subject => "Регистрация на ENG!NE" },
      { :email => user.email,
        :password => user.password
      }
  end
end