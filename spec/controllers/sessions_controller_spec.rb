# XXX all xit-disabled until in use
describe SessionsController, :omniauth do

  render_views

  before do
    request.env['omniauth.auth'] = auth_mock
  end

  describe "#create" do

    xit "creates a user" do
      expect {post :create, provider: :facebook}.to change{ User.count }.by(1)
    end

    xit "creates a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :facebook
      expect(session[:user_id]).not_to be_nil
    end

    xit "redirects to the home page" do
      post :create, provider: :facebook
      expect(response).to redirect_to root_url
    end

  end

  describe "#destroy" do

    before do
      post :create, provider: :facebook
    end

    xit "resets the session" do
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    xit "redirects to the home page" do
      delete :destroy
      expect(response).to redirect_to root_url
    end

  end

end
