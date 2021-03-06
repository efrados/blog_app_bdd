require "rails_helper"

RSpec.feature "Creating Articles" do
  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
  end

  scenario "User creates a new Article" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: "Creating a blog" 
    fill_in "Body", with: "Lorem Ipsum" 
    click_button "Create Article"
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@john.email}")
  end

  scenario "User fails to create a new Article" do
    visit "/"
    click_link "New Article"
    fill_in "Title", with: "" 
    fill_in "Body", with: "" 
    click_button "Create Article"
    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page.current_path).to eq(articles_path) 
  end
end