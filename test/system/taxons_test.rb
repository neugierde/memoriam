require "application_system_test_case"

class TaxonsTest < ApplicationSystemTestCase
  setup do
    @taxon = taxons(:one)
  end

  test "visiting the index" do
    visit taxons_url
    assert_selector "h1", text: "Taxons"
  end

  test "creating a Taxon" do
    visit taxons_url
    click_on "New Taxon"

    fill_in "Ancestry", with: @taxon.ancestry
    fill_in "Name", with: @taxon.name
    fill_in "Taxonomy", with: @taxon.taxonomy_id
    click_on "Create Taxon"

    assert_text "Taxon was successfully created"
    click_on "Back"
  end

  test "updating a Taxon" do
    visit taxons_url
    click_on "Edit", match: :first

    fill_in "Ancestry", with: @taxon.ancestry
    fill_in "Name", with: @taxon.name
    fill_in "Taxonomy", with: @taxon.taxonomy_id
    click_on "Update Taxon"

    assert_text "Taxon was successfully updated"
    click_on "Back"
  end

  test "destroying a Taxon" do
    visit taxons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Taxon was successfully destroyed"
  end
end
