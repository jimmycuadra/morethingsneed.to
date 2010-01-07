require 'test_helper'
require 'authlogic/test_case'

class CommentsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  test "should create new comment and redirect to entry with success message" do
    assert_difference('Entry.find(1).comments.count') do
      post :create, :entry_id => 1, :comment => { :comment => 'Comment' }
    end
    assert_redirected_to entry_path(assigns(:entry))
    assert_not_nil flash[:success]
  end
  
  test "should redirect to entry and not toggle spam if not admin" do
    initial_spam_flag = Comment.find(1).spam
    put :toggle_spam, :entry_id => 1, :id => 1
    assert_redirected_to entry_path(Entry.find(1))
    assert_equal initial_spam_flag, Comment.find(1).spam
  end
  
  test "should redirect to entry and toggle spam flag if admin" do
    UserSession.create(users(:dodongo))
    initial_spam_flag = Comment.find(1).spam
    put :toggle_spam, :entry_id => 1, :id => 1
    assert_redirected_to entry_path(assigns(:comment).entry)
    assert_not_equal initial_spam_flag, Comment.find(1).spam
  end
end