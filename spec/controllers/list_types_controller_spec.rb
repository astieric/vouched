require 'spec_helper'

describe ListTypesController do
  before(:each) do
    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)
  end

  def mock_list_type(stubs={})
    @mock_list_type ||= mock_model(ListType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all list_types as @list_types" do
      ListType.stub!(:find).with(:all).and_return([mock_list_type])
      get :index
      assigns(:list_types).should eq([mock_list_type])
    end
  end

  describe "GET show" do
    it "assigns the requested list_type as @list_type" do
      ListType.stub(:find).with("37") { mock_list_type }
      get :show, :id => "37"
      assigns(:list_type).should be(mock_list_type)
    end
  end

  describe "GET new" do
    it "assigns a new list_type as @list_type" do
      ListType.stub(:new) { mock_list_type }
      get :new
      assigns(:list_type).should be(mock_list_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested list_type as @list_type" do
      ListType.stub(:find).with("37") { mock_list_type }
      get :edit, :id => "37"
      assigns(:list_type).should be(mock_list_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created list_type as @list_type" do
        ListType.stub(:new).with({'these' => 'params'}) { mock_list_type(:save => true) }
        post :create, :list_type => {'these' => 'params'}
        assigns(:list_type).should be(mock_list_type)
      end

      it "redirects to the created list_type" do
        ListType.stub(:new) { mock_list_type(:save => true) }
        post :create, :list_type => {}
        response.should redirect_to(list_type_url(mock_list_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved list_type as @list_type" do
        ListType.stub(:new).with({'these' => 'params'}) { mock_list_type(:save => false) }
        post :create, :list_type => {'these' => 'params'}
        assigns(:list_type).should be(mock_list_type)
      end

      it "re-renders the 'new' template" do
        ListType.stub(:new) { mock_list_type(:save => false) }
        post :create, :list_type => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested list_type" do
        ListType.should_receive(:find).with("37") { mock_list_type }
        mock_list_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :list_type => {'these' => 'params'}
      end

      it "assigns the requested list_type as @list_type" do
        ListType.stub(:find) { mock_list_type(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:list_type).should be(mock_list_type)
      end

      it "redirects to the list_type" do
        ListType.stub(:find) { mock_list_type(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(list_type_url(mock_list_type))
      end
    end

    describe "with invalid params" do
      it "assigns the list_type as @list_type" do
        ListType.stub(:find) { mock_list_type(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:list_type).should be(mock_list_type)
      end

      it "re-renders the 'edit' template" do
        ListType.stub(:find) { mock_list_type(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested list_type" do
      ListType.should_receive(:find).with("37") { mock_list_type }
      mock_list_type.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the list_types list" do
      ListType.stub(:find) { mock_list_type }
      delete :destroy, :id => "1"
      response.should redirect_to(list_types_url)
    end
  end

end
