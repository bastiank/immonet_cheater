class ImmonetLinksController < ApplicationController
  before_action :set_immonet_link, only: [:show, :edit, :update, :destroy]

  # GET /immonet_links
  # GET /immonet_links.json
  def index
    @immonet_links = ImmonetLink.all
  end

  # GET /immonet_links/1
  # GET /immonet_links/1.json
  def show
  end

  # GET /immonet_links/new
  def new
    @immonet_link = ImmonetLink.new
  end

  # GET /immonet_links/1/edit
  def edit
  end

  # POST /immonet_links
  # POST /immonet_links.json
  def create
    @immonet_link = ImmonetLink.new(immonet_link_params)

    respond_to do |format|
      if @immonet_link.save
        format.html { redirect_to @immonet_link, notice: 'Immonet link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @immonet_link }
      else
        format.html { render action: 'new' }
        format.json { render json: @immonet_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immonet_links/1
  # PATCH/PUT /immonet_links/1.json
  def update
    respond_to do |format|
      if @immonet_link.update(immonet_link_params)
        format.html { redirect_to @immonet_link, notice: 'Immonet link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @immonet_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immonet_links/1
  # DELETE /immonet_links/1.json
  def destroy
    @immonet_link.destroy
    respond_to do |format|
      format.html { redirect_to immonet_links_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immonet_link
      @immonet_link = ImmonetLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def immonet_link_params
      params.require(:immonet_link).permit(:immonet_mail_id, :object_id, :link, :status)
    end
end
