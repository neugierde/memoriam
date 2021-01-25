class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy]

  # GET /documents
  # GET /documents.json
  def index
    @filter = Document::Filter.new(params.fetch(:filter, {}).permit!)
    @documents = @filter.call(Document.all)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show; end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit; end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def document_params
    params.require(:document)
          .permit(:title, :file, :extended_info, :archival_location_id, :taxon_id, :organization_id, :tags)
          .tap { |params| params[:tags] = untagifize(params[:tags]) if params[:tags].is_a?(String) }
  end

  def filter_params
    params.require(:filter).permit(:format)
  end

  def untagifize(string)
    JSON.parse(string).map { _1['value'] }
  end
end
