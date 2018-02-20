require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
  
  end
  
  test "Should be able to sign up" do
    get signup_path
    assert_template "users/new"
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "Coady", email: "coady@example.com", password: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_match "Welcome", response.body
  end
  
  test "Should NOT be able to sign up" do
    get signup_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: " ", email: "coady@example.com", password: "password" } } 
    end
    assert_template "users/new"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
