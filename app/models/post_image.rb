class PostImage < ApplicationRecord
  has_one_attached :image
  #ActiveStrageを使って、imageカラムをPostImageモデルに画像を持たせる
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :shop_name, presence: true
  validates :image, presence: true
  
  def get_image
  #get_imageというメソッド
  #アクションとは違い、特定の処理を名前で呼び出す
  #モデルの中に記述することでカラムを呼び出すようにメソッドを呼び出せる
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end 
     image
  end 
  #このメソッド内容は画像が設定されていない場合、app/assets/imageに格納されている
  #no_image.jpgという画像をデフォルト画像としてActiveStrageに格納し画像を表示する

  def favorited_by?(user)
      favorites.exists?(user_id: user.id)
   #favorited_byメソッド
   #引数で渡されたユーザーidがFavoriteテーブル内にexists(存在)するかを調べる
  end 
  
end
