class ImmonetMailsController < ApplicationController
  before_action :set_immonet_mail, only: [:show, :edit, :update, :destroy]

  # GET /immonet_mails
  # GET /immonet_mails.json
  def index
    @immonet_mails = ImmonetMail.all
  end

  # GET /immonet_mails/1
  # GET /immonet_mails/1.json
  def show
  end

  # GET /immonet_mails/new
  def new
    @immonet_mail = ImmonetMail.new
  end

  # GET /immonet_mails/1/edit
  def edit
  end

  # POST /immonet_mails
  # POST /immonet_mails.json
  def create
    @immonet_mail = ImmonetMail.new(immonet_mail_params)

    respond_to do |format|
      if @immonet_mail.save
        format.html { redirect_to @immonet_mail, notice: 'Immonet mail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @immonet_mail }
      else
        format.html { render action: 'new' }
        format.json { render json: @immonet_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immonet_mails/1
  # PATCH/PUT /immonet_mails/1.json
  def update
    respond_to do |format|
      if @immonet_mail.update(immonet_mail_params)
        format.html { redirect_to @immonet_mail, notice: 'Immonet mail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @immonet_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immonet_mails/1
  # DELETE /immonet_mails/1.json
  def destroy
    @immonet_mail.destroy
    respond_to do |format|
      format.html { redirect_to immonet_mails_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_immonet_mail
      @immonet_mail = ImmonetMail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def immonet_mail_params
      if params[:immonet_mail_json]
        JSON.parse params[:immonet_mail_json]
      else
        params.require(:immonet_mail).permit(:body, :subject, :headers, :raw)
      end
    end
end
