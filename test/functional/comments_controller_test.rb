require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Authlogic::TestCase

  setup :activate_authlogic

  test "should create new comment and redirect to entry with success message" do
    assert_difference('Entry.find(1).comments.count') do
      post :create, :entry_id => 1, :comment => { :comment => 'Comment' }
    end
    assert_redirected_to entry_path(assigns(:entry))
    assert_not_nil flash[:success]
  end

  test "should redirect to root without toggling spam if not admin" do
    put :toggle_spam, :entry_id => 1, :id => 1
    assert_redirected_to root_path
  end

  test "should redirect to entry after toggling spam if admin" do
    UserSession.create(users(:dodongo))
    put :toggle_spam, :entry_id => 1, :id => 1
    assert_redirected_to entry_path(assigns(:comment).entry)
  end

  test "should decrease entry's comment_count after marking comment as spam" do
    assert_difference 'Entry.first.comment_count', -1, Entry.first.comment_count do
      UserSession.create(users(:dodongo))
      put :toggle_spam, :entry_id => 1, :id => 1
    end
  end

  test "should increase entry's comment_count after marking comment as valid" do
    assert_difference 'Entry.first.comment_count', 1, Entry.first.comment_count do
      UserSession.create(users(:dodongo))
      put :toggle_spam, :entry_id => 1, :id => 4
    end
  end
end
