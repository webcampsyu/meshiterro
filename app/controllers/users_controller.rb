class UsersController < ApplicationController
  before_action :is_matching_login_user, only:[:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page])
    #@post_images = @user.post_imagesを上記に変更(ページネーションのため)
    #アソシエーションを持っているモデル同士の記述方法
    #特定のユーザー(@user)に関連付けられた投稿全て(@post_images)を取得し
    #全体の投稿ではなく、個人の投稿したものを全て表示する
  end

  def edit
    #他のユーザーからのアクセス制限
    #user = User.find(params[:id])
    #unless user.id == current_user.id
      #ログインしているユーザーのidをcurrent_user.idで取得
      #一致しなければ投稿一覧画面へリダイレクト
      #redirect_to post_images_path
    #end
    #updateと同じ記述のためメソッドをis_matchin_login_userでprivateにまとめる
    #まとめたメソッドを記述
    is_matching_login_user
    
    @user = User.find(params[:id])
  end
  
  def update
    #他のユーザーからのアクセス制限
    #user = User.find(params[:id])
    #unless user.id == current_user.id
      #redirect_to post_images_path
    #end 
    is_matching_login_user
    
    @user = User.find(params[:id])
    @user.update(user_params)
     redirect_to user_path(@user.id)
  end 
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end 
  end 
   
end
