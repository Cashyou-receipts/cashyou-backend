require 'rails_helper'

RSpec.describe "ReceiptsController" do
  before do
    @fixture_path = "spec/fixtures/"
    @receipt_count = Receipt.count
    @user = User.create(email: "user@example.com")
  end

  describe "create" do
    it "creates receipt" do
      filename = @fixture_path + "/hmart_1.json?user=#{@user.id}"
      get "/receipts/create", body: File.read(filename)
      expect(Receipt.count).to eq(@receipt_count + 1)
    end
    
    it "creates receipt with line items" do
      filename = @fixture_path + "/hmart_1.json?user=#{@user.id}"
      get "/receipts/create", body: File.read(filename)
      receipt_id = JSON.parse(response.body)[:id]
      receipt = Receipt.find receipt_id
      expect(receipt.items.first).to be_a(Item)
    end
    
    it "doesn't create without proper json format" do
      filename = "spec/fixtures/sad_path/receipts/improper_format.json"
      get "/receipts/create", body: File.read(filename)
      body = response.body
      expect(response.status).to eq(400)
      expect(body["error"]).to_equal("Improper json format: unrecognized OCR")
    end
    
    it "doesn't create unless one of the following is detected: Recognized Vendor, a list of items, or a total balance." do
      filename = "spec/fixtures/sad_path/receipts/safeway_1.json"
      revised_file = File.read(filename).to_string.gsub(ReceiptDissector::Categories["price"], "").to_json
      get "/receipts/create", body: revised_file
      expect(response.status).to eq(400)
      expect(body["error"]).to_equal("No price, Vendor, or items detected")
    end
  end

end