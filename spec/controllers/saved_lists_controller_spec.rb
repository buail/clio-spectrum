require 'spec_helper'

describe SavedListsController do

  before(:each) do
    @first_user_name = 'user_alpha'
    @first_user = FactoryGirl.create(:user, login: @first_user_name)
    @second_user_name = 'user_beta'
    @second_user = FactoryGirl.create(:user, login: @second_user_name)
  end

  it "anonymous users can't do much" do
    delete :destroy,  id: 1
    # page.save_and_open_page # debug
    response.status.should be(302)
    # Can't figure this out....
    # response.should redirect_to location: 'http://wind.columbia.edu/login'
    # response.should redirect_to %r(\Ahttp://wind.columbia.edu/login)

    put :update,  id: 1
    # page.save_and_open_page # debug
    response.status.should be(302)
    # Can't figure this out....
    # response.should redirect_to %r(\Ahttp://wind.columbia.edu/login)
  end

  it 'authenticated users can interact...' do

    # use Devise::TestHelpers methods for Controller tests
    # sign_in :user, @first_user
    spec_login @first_user

    # Try to delete a non-existant list
    delete :destroy,  id: 9_999_999
    response.status.should be(302)
    response.should redirect_to(root_path)
    flash[:error].should =~ /Cannot access list/i

    # Try to update a non-existant list
    put :update,  id: 9_999_999
    response.status.should be(302)
    response.should redirect_to(root_path)
    flash[:error].should =~ /Cannot access list/i
  end

end
