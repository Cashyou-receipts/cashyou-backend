class ReceiptsController < ApplicationController
  before_action: :verify_request

  def create
    user = User.find_or_create_by(phone_number: params[:phone_number])
    receipt_data = params[:receipt]
    receipt_info = ReceiptDissector.new(receipt_data)
    receipt_info.parse_receipt
    first_section = receipt_info.first_section_text
    receipt_vendor = find_vendor_name(user, first_section)
    receipt = user.receipts.new(
      vendor: receipt_vendor,
      subtotal: receipt_info.subtotal,
      tax: receipt_info.tax,
      balance: receipt_info.balance
    )
  end
  
  private
  
  def verify_request
    auth = request.headers["lambda_auth"]
    unless auth && ActiveSupport::SecurityUtils.secure_compare(auth, ENV["lambda_auth"])
      render json: {error: "Unauthorized entity"}, status: :unauthorized
    end 
  end
  
  def find_vendor_name(user, text)
    text.downcase!
    vendor_names = user.vendors.pluck(:name)

    existing_vendor = vendor_names.detect { |name| text.match?(name) }

    if existing_vendor.present?
      return existing_vendor
    end
  end
end