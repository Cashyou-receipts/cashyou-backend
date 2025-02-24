class ReceiptsController < ApplicationController
  before_action :verify_request

  def create
    user = User.find_or_create_by(phone_number: params[:phone_number])
    receipt_data = params[:receipt].as_json
    parser = ReceiptDissector.new(receipt_data)
    parser.parse_receipt
    receipt_vendor = find_vendor_name(user, params[:receipt][:responses].first[:textAnnotations].first[:description].gsub("\n", " ").downcase)
    receipt = user.receipts.new(
      vendor: receipt_vendor,
      subtotal: parser.subtotal,
      tax: parser.tax,
      balance: parser.balance
    )
    if receipt.save
      render json: { receipt: receipt }, status: :created
    else
      render json: { errors: receipt.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def verify_request
    # TODO: OAuth
    auth = request.headers["lambda_auth"]
    unless auth && ActiveSupport::SecurityUtils.secure_compare(auth, ENV["lambda_auth"])
      render json: {error: "Unauthorized entity"}, status: :unauthorized
    end 
  end
  
  def find_vendor_name(user, text)
    text.downcase!
    vendors = user.vendors

    existing_vendor = vendors.detect { |vendor| text.match(vendor.name) }

    if existing_vendor.present?
      return existing_vendor
    end
  end
end