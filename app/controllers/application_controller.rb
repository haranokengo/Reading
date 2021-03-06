class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    # 管理者とユーザーでページを分けたいため
    if admin_admin_signed_in?
      admin_categories_path
    elsif user_signed_in?
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # ゲストユーザーが編集、退会できないようにメールアドレスで判断している
  def guest_user
    @user = User.find_by(email: 'guest@example.com')
    if @user == current_user
      flash[:danger] = 'ゲストユーザーは編集・投稿が出来ません'
      redirect_back(fallback_location: root_path)
    end
  end

  protected

  def configure_permitted_parameters
    # 新規登録時にメールとニックネームの入力追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :nickname])
  end
end
