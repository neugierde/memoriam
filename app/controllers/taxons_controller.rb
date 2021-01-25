class TaxonsController < ApplicationController
  def index
    @taxons = Taxon.with_ancestry
                   .order(:full_name)
                   .preload(:parent)
  end

  def show
    @taxon = Taxon.with_ancestry.find(params[:id])
  end

  def new
    @taxon = Taxon.new
  end

  def edit
    @taxon = Taxon.find(params[:id])
  end

  def create
    @taxon = Taxon.new(taxon_params)

    respond_to do |format|
      if @taxon.save
        format.html { redirect_to @taxon, notice: 'Taxon was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @taxon = Taxon.find(params[:id])

    respond_to do |format|
      if @taxon.update(taxon_params)
        format.html { redirect_to @taxon, notice: 'Taxon was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @taxon = Taxon.find(params[:id])

    @taxon.destroy
    respond_to do |format|
      format.html { redirect_to taxons_url, notice: 'Taxon was successfully destroyed.' }
    end
  end

  private

  def taxon_params
    params.require(:taxon).permit(:parent_id, :extended_info, :name)
  end
end
