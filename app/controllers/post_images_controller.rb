class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
  
  def create
    @post_image =PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    #current_userはコードに記述するだけでログイン中のユーザーの情報を取得できる
    #[モデル名].[カラム名]のように記述することで、保存するカラム名の中身を操作できる
    #モデルに紐づくカラムの値を取得したり、逆に値を代入することが出来る
    #ここでは@post_image（投稿）のuser_idとして、current_user.idを代入するとなる
    if @post_image.save
     redirect_to post_images_path
    else
     render :new
    end 
  end 

  def index
    @post_images = PostImage.page(params[:page])
    #１ページ分の決められた数のデータだけを新しい順に取得するように変更
    #@post_images =PostImage.allを@post_images = PostImage.page(param[:page])に変更
    #pageメソッドはkaminariをインストールしたことで使用可能
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
     redirect_to post_images_path
  end 
  
  private
 #投稿データを保存するためにはストロングパラメータが必要
  def post_image_params
    params.require(:post_image).permit(:shop_name, :caption, :image)
  end 
  
end
