require "rails_helper"

describe "New Maze", type: :feature do
  it do
    visit root_path

    click_on "12x12 Maze"

    expect(page).to have_content "←"
  end
end
