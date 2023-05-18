class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  #ログイン認証が成功していないと、トップページ以外は表示できない記述
  #authenticate_userメソッドはdevise側が用意しているメソッド
  #ログイン認証されていなければ、ログイン画面へリダイレクトする機能を実装できる
  before_action :configure_permitted_parameters, if: :devise_controller?
  #devise利用の機能が使われる前にconfigure_permitted_parametersメソッドを実行
  
  def after_sign_in_path_for(resource)
    #after_sign_in_path_forはdeviseが用意しているメソッド
    #サインイン後にどこに遷移するかを設定する
    about_path
  end 
  
  def after_sign_out_path_for(resource)
    #after_sign_out_path_forはdeviseが用意しているメソッド
    #サインアウト後にどこに遷移するかを設定
    about_path
  end
  
  #after_sign_in_path_forメソッド,after_sign_out_path_forメソッドは
  #deviseの初期設定を上書きする記述
  #deviseのメソッドを上書きしているため、引数にresourceを渡す
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #configure_permitted_parametersメソッドではdevise_parameter_sanitizer.permitメソッドを使うことで
  #sign_upの際にユーザー名のデータ操作を許可
  end 
  
end
