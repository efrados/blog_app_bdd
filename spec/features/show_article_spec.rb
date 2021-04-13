require "rails_helper"

RSpec.feature "Showing an Article" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    login_as(@fred)
    @article = Article.create(title: "First Article", body: "Lorem Ipsum", user: @fred)
    logout
  end

  scenario 'to non signed user hide the edit and delete buttons' do

    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'to non owner user hide the edit and delete buttons' do
    login_as(@john)
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario 'to owner user, signed in, show the edit and delete buttons' do

    visit '/'
    login_as(@fred)
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end