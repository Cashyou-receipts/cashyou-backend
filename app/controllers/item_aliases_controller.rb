class ItemAliasesController < ApplicationController
  before_action :set_item_alias, only: %i[ show update destroy ]

  # GET /item_aliases
  def index
    @item_aliases = ItemAlias.all

    render json: @item_aliases
  end

  # GET /item_aliases/1
  def show
    render json: @item_alias
  end

  # POST /item_aliases
  def create
    @item_alias = ItemAlias.new(item_alias_params)

    if @item_alias.save
      render json: @item_alias, status: :created, location: @item_alias
    else
      render json: @item_alias.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_aliases/1
  def update
    if @item_alias.update(item_alias_params)
      render json: @item_alias
    else
      render json: @item_alias.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_aliases/1
  def destroy
    @item_alias.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_alias
      @item_alias = ItemAlias.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_alias_params
      params.require(:item_alias).permit(:item_name, :alias)
    end
end
