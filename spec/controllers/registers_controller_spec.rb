describe RegistersController do

  render_views

  describe "GET app" do
    it "returns http success" do
      get :app
      expect(response).to have_http_status(:success)
    end
  end

end
