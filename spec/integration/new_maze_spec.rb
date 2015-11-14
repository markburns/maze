require "rails_helper"

describe "New Maze", type: :feature do
  it do
    visit new_maze_path

    save_and_open_page
    click_on "12x12 Maze"

    expect(page).to have_content "←"
  end
end
