Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do 
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    #resourceと単数形にすると/:idがurlに含まれなくなる
    #resourceは「それ自身のidが分からなくても、関連するほかのモデルのidから特定できる」
    #場合に用いる
  end 
  #コメントは登校画像に対してコメントするため、post_commentsはpost_imagesに紐づき親子関係となる
  #親子関係にしたことでurlを作成し、params[:post_image_id]でPostImageのidを取得できる
  resources :users, only: [:show, :edit, :update]
  get "homes/about" => 'homes#about', as: 'about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
