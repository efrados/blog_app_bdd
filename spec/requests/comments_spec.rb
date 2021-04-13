require 'rails_helper'

RSpec.describe "Coments", type: :request do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    login_as(@john)
    @article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
    logout
  end

  describe 'POST /articles/:id/comments' do 
    context 'with a non signed-in user' do
      before do
        post "/articles/#{@article.id}/comments/",params: { comment: { body: "Awesome blog" } }
      end

      it "redirect user to the sign in page" do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        flash_message = "Please sign in or sign up first"
        expect(flash[:alert]).to eq flash_message
      end 
    end

    context 'with a signed-in user' do
      before do
        login_as(@john)
        post "/articles/#{@article.id}/comments/",params: { comment: { body: "Awesome blog" } }
      end

      it 'creates the comment succesfully' do
        flash_message = "Comment has been created."
        expect(flash[:notice]).to eq flash_message
      end
    end
  end 
end
