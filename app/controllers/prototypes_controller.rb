class PrototypesController < ApplicationController
  before_action  :authenticate_user!, except: [:index, :show]
  # before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  # before_action :move_to_new, except:[:destroy, :update, :edit]
  # before_action :move_to_index, only:[:edit, :show]
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
    # if prototype.create(prototype_params)
    #   redirect_to root_path
    # else
    #   render :
    # end

  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments

  end

  def edit
      @prototype = Prototype.find(params[:id])
    if user_signed_in? 
      if current_user.id!=@prototype.user.id
        redirect_to root_path
      end
    else
      render :index
    end
  end
      
    
    
    
    # current_users.id＝＝
    #   redirect_to root_path
    # else
    #   @prototype = Prototype.find(params[:id])
    #   render :index
    # end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if prototype.save
      redirect_to root_path
    else
      @prototype = Prototype.find(params[:id])
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  # def move_to_new
  #   if user_signed_in? && current_user.id == @prototype.user_id
  #     redirect_to root_path
  #   else
  #     render :new
  #   end
  # end

    # def contributor_confirmation
  #   redirect_to root_path unless current_user == @prototype.user
  # end
# end

  # def move_to_index
  #   unless user_signed_in? && current_users.id == @prototype.user.id
  #     redirect_to root_path
  #   end
  # end


  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.user.id)
  end
end
