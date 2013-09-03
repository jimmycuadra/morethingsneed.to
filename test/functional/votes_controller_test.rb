require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  test "should create vote and redirect to entry with success message" do
    post :create, :entry_id => 1, :vote => { :up_vote => 1 }
    assert_redirected_to entry_path(assigns(:entry))
    assert_not_nil flash[:success]
  end

  test "should raise when parameters are missing" do
    assert_raises(ActionController::ParameterMissing) do
      post :create, :entry_id => 1
    end
  end
end
