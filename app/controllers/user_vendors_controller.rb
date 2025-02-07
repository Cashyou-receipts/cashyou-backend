class UserVendorsController < ApplicationController
  before_action :set_user_vendor, only: %i[ show update destroy ]

  # GET /user_vendors
  def index
    @user_vendors = UserVendor.all

    render json: @user_vendors
  end

  # GET /user_vendors/1
  def show
    render json: @user_vendor
  end

  # POST /user_vendors
  def create
    @user_vendor = UserVendor.new(user_vendor_params)

    if @user_vendor.save
      render json: @user_vendor, status: :created, location: @user_vendor
    else
      render json: @user_vendor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_vendors/1
  def update
    if @user_vendor.update(user_vendor_params)
      render json: @user_vendor
    else
      render json: @user_vendor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_vendors/1
  def destroy
    @user_vendor.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_vendor
      @user_vendor = UserVendor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_vendor_params
      params.require(:user_vendor).permit(:user_id, :vendor_id)
    end
end
