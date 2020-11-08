require "application_system_test_case"

class RacesTest < ApplicationSystemTestCase
  setup do
    @race = races(:one)
  end

  test "visiting the index" do
    visit races_url
    assert_selector "h1", text: "Races"
  end

  test "creating a Race" do
    visit races_url
    click_on "New Race"

    fill_in "City", with: @race.city
    fill_in "Country", with: @race.country
    fill_in "Description", with: @race.description
    fill_in "Enddate", with: @race.enddate
    fill_in "State", with: @race.state
    fill_in "Title", with: @race.title
    click_on "Create Race"

    assert_text "Race was successfully created"
    click_on "Back"
  end

  test "updating a Race" do
    visit races_url
    click_on "Edit", match: :first

    fill_in "City", with: @race.city
    fill_in "Country", with: @race.country
    fill_in "Description", with: @race.description
    fill_in "Enddate", with: @race.enddate
    fill_in "State", with: @race.state
    fill_in "Title", with: @race.title
    click_on "Update Race"

    assert_text "Race was successfully updated"
    click_on "Back"
  end

  test "destroying a Race" do
    visit races_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Race was successfully destroyed"
  end
end
