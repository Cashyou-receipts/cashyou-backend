require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe "create" do
    it "creates the correct number of items" do
      file1 = @fixture_path + "/hmart_1.json?user=#{@user.id}" #14
      file2 = @fixture_path + "/soops_5.json?user=#{@user.id}" #5
      file3 = @fixture_path + "/costco_1.json?user=#{@user.id}" #12
      file4 = @fixture_path + "/tj_2.json?user=#{@user.id}" #2
      file5 = @fixture_path + "/safeway_1.json?user=#{@user.id}" #6
    end

    it "recognizes Vendor if in user's list of vendors" do
    end

    it "recognizes Vendor if NOT in user's list of vendors, but exists in database" do
    end
  end
end
