class ArchivalLocationsController < ApplicationController
  def index
    @archival_locations = ArchivalLocation.with_ancestry
  end

  def show
    @archival_location = ArchivalLocation.with_ancestry.find(params[:id])
  end

  def new
    @archival_location = ArchivalLocation.new
  end

  def edit
    @archival_location = ArchivalLocation.find(params[:id])
  end

  def create
    @archival_location = ArchivalLocation.new(archival_location_params)

    respond_to do |format|
      if @archival_location.save
        format.html { redirect_to @archival_location, notice: 'archival_location was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @archival_location = ArchivalLocation.find(params[:id])

    respond_to do |format|
      if @archival_location.update(archival_location_params)
        format.html { redirect_to @archival_location, notice: 'archival_location was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @archival_location = ArchivalLocation.find(params[:id])

    @archival_location.destroy
    respond_to do |format|
      format.html { redirect_to archival_locations_url, notice: 'archival_location was successfully destroyed.' }
    end
  end

  private

  def archival_location_params
    params.require(:archival_location)
          .permit(:name, :extended_info, :address_code, :parent_id, :organization_id)
  end
end
