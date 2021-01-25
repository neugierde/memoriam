class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.with_ancestry
  end

  def show
    @organization = Organization.with_ancestry.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @organization = Organization.find(params[:id])
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :extended_info, :parent_id)
  end
end
