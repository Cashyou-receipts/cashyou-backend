require 'rails_helper'

RSpec.describe ReceiptDissector, type: :model do
  describe "create" do
    before do
      @user = User.create(email: "user@example.com")
      @fixture_path = "./spec/fixtures/json_responses"
      @file1 = @fixture_path + "/hmart_1.json" #14
      @file2 = @fixture_path + "/soops_4.json" #5
      @file3 = @fixture_path + "/costco_1.json" #12
      @file4 = @fixture_path + "/tj_2.json" #2
      @file5 = @fixture_path + "/safeway_1.json" #6
      @dissector1 = ReceiptDissector.new(JSON.parse(File.read(@file1)))
      @dissector1.parse_receipt
      @dissector2 = ReceiptDissector.new(JSON.parse(File.read(@file2)))
      @dissector2.parse_receipt
      @dissector3 = ReceiptDissector.new(JSON.parse(File.read(@file3)))
      @dissector3.parse_receipt
      @dissector4 = ReceiptDissector.new(JSON.parse(File.read(@file4)))
      @dissector4.parse_receipt
      @dissector5 = ReceiptDissector.new(JSON.parse(File.read(@file5)))
      @dissector5.parse_receipt
    end

    it "creates the correct number of items" do
      expect(@dissector1.items.size).to eq(14)
      expect(@dissector2.items.size).to eq(5)
      expect(@dissector3.items.size).to eq(12) 
      expect(@dissector4.items.size).to eq(2) 
      expect(@dissector5.items.size).to eq(6) 
    end
    
    it "gets accurate balance" do
      expect(@dissector1.balance).to eq(53.83)
      expect(@dissector2.balance).to eq(11.82)
      expect(@dissector3.balance).to eq(160.23)
      expect(@dissector4.balance).to eq(6.08)
      expect(@dissector5.balance).to eq(17.96)
    end

    it "gets accurate tax" do
      expect(@dissector1.tax).to eq(2.00)
      expect(@dissector2.tax).to eq(0.58)
      expect(@dissector3.tax).to eq(7.92)
      expect(@dissector4.tax).to be_nil
      expect(@dissector5.tax).to eq(0.67)
    end
  end
end
