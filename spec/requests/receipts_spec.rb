require 'rails_helper'

RSpec.describe "/receipts", type: :request do
  let(:valid_receipt_data) {
    JSON.parse(File.read("spec/fixtures/json_responses/soops_1.json"))
  }

  let(:non_receipt_photo_data) {
    JSON.parse(File.read("spec/fixtures/sad_path/receipts/no_text.json"))
  }

  let(:incorrect_format_data) {
    JSON.parse(File.read("spec/fixtures/sad_path/receipts/improper_format.json"))
  }

  let(:valid_headers) {
    {}
  }

  let(:user) {
    User.create(email: "test@example.com")
  }
  
  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Receipt" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        expect {
          post receipts_url,
          params: { receipt: valid_receipt_data }, as: :json
        }.to change(Receipt, :count).by(1)
      end
      
      it "renders a JSON response with the new receipt" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        vendor = user.vendors.create!(name: "king soopers")
        post receipts_url,
        params: { receipt: valid_receipt_data }, as: :json
        puts JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
      
      it "creates a new receipt with the correct attributes" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        vendor = user.vendors.create!(name: "king soopers")
        post receipts_url,
        params: { receipt: valid_receipt_data }, as: :json
        created_receipt = Receipt.find JSON.parse(response.body)["receipt"]["id"]
        expect(created_receipt.balance).to eq(5.99)
        expect(created_receipt.subtotal).to be_nil
        expect(created_receipt.tax).to eq(0.22)
        expect(created_receipt.receipt_items.size).to eq(5)
        expect(created_receipt.items.size).to eq(5)
      end
    end
    
    context "with invalid parameters" do
      xit "does not create a new Receipt if no grocery data" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        expect {
          post receipts_url,
          params: { receipt: invalid_attributes }, as: :json
        }.to change(Receipt, :count).by(0)
      end
      
      it "renders a JSON response with errors for no data" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        output = StringIO.new
        $stdout = output
        post receipts_url, params: { receipt: non_receipt_photo_data }, as: :json
        $stdout = STDOUT
        expect(response).to have_http_status(:unprocessable_entity)
        expect(output.string).to include("INCOMING REQUEST MISSING DATA")
        expect(JSON.parse(response.body)["errors"]).to eq("missing data")
      end
      
      it "renders a JSON response with errors for incorrect format" do
        allow_any_instance_of(ReceiptsController).to receive(:verify_request).and_return(nil)
        output = StringIO.new
        $stdout = output
        post receipts_url, params: { receipt: incorrect_format_data }, as: :json
        $stdout = STDOUT
        expect(response).to have_http_status(:unprocessable_entity)
        expect(output.string).to include("INCOMING REQUEST MISSING DATA")
        expect(JSON.parse(response.body)["errors"]).to eq("missing data")
      end
    end
  end
end
