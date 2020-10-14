class PrototypesController < ApplicationController

  before_action :move_to_sign, except: [:index, :show]
  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    
    prototype = Prototype.find(params[:id])
    if prototype.destroy
      redirect_to root_path
    end
  end

  private

  def prototype_params
    # requireでprototypeモデル選択 permitで取得したいキーを指定 mergeでuser_idをもつハッシュを結合 current_userはログインしているユーザーのid情報取得
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_sign
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def move_to_index
    prototype = Prototype.find(params[:id])
    unless prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end
end