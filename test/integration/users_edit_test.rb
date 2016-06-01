require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user =  users(:fourfan)
  end
  
  test "Unsuccessful edit" do 
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: "", email: "fourfan@gmail.com", password: "123", password_confirmation: "1234"}
    assert_template 'users/edit'
  end
 
end
