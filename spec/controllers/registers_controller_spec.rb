describe RegistersController do

  render_views

  describe "GET app" do

    it "returns http success" do
      get 'app'
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST create" do

    let(:valid_params) do
      {
        key: 'dummydummydummydummy',
        title: 'Dummy'
      }
    end

    describe "with valid params" do

      before do
        xhr :post, 'create', valid_params
        expect(response).to have_http_status(:success)
      end

      it "creates a register" do
        register_data = JSON.parse(response.body) rescue nil
        expect(register_data).not_to be_nil
        expect(register_data['key']).to eq 'dummydummydummydummy'
        register = Register.find_by(key: 'dummydummydummydummy')
        expect(register).not_to be_nil
        expect(register.title).to eq 'Dummy'
        expect(register.subtitle).to be_nil
      end

    end

    describe "with invalid params" do

      let(:invalid_params) { valid_params.merge key: 'tooshort' }

      it "fails" do
        xhr :post, 'create', invalid_params
        expect(response).to have_http_status :unprocessable_entity
        expect(Register.find_by key: 'invalid').to be_nil
      end

    end

    describe "with unpertmitted params" do

      let(:invalid_params) { valid_params.merge user_id: 12345 }

      it "fails" do
        expect {
          xhr :post, 'create', invalid_params
        }.to raise_error
      end

    end

  end

end
