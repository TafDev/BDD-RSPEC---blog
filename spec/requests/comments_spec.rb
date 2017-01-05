require 'rails_helper'

RSpec.describe "Comments", type: :request do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		@barvis = User.create(email: "barvis@example.com", password: "123456")
		@article = Article.create!(title: "title1", body: "body of article 1", user: @john)
	end

	describe "POST /articles/:id/comments" do
		context "with a non signed in user" do
			before do
				post "/articles/#{@article.id}/comments", params: {comment: {body: "this is wack"}}
			end

			it "should redirect user to sign in page" do
				flash_message = "Please sign in or sign up first"
				expect(response).to redirect_to(new_user_session_path)
				expect(response.status).to eq 302
				expect(flash[:alert]).to eq flash_message
			end
		end

		context "with a signed in user" do
			before do
				login_as(@barvis)
				post "/articles/#{@article.id}/comments", params: {comment: {body: "this is wack"}}
			end

			it "should create the comment successfully" do
				flash_message = "Comment has been created"
				expect(response).to redirect_to(article_path(@article.id))
				expect(response.status).to eq 302
				expect(flash[:notice]).to eq flash_message
			end
		end
	end
end