require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user =  User.create(username: "john", email: "john@example.com", password: "password")
  end

  test "should create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: {title: "My Title", description: "this is my article description for my integration test"} }
      follow_redirect!
    end
    assert_template "articles/show"
    assert_match "succesfully", response.body
  end
  
  test "invalid article results in failure" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: {title: " ", description: " "} }
    end
    assert_template "articles/new"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
  end
  
  
  
  
end