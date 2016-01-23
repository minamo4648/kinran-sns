require 'test_helper'

class MylistsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
