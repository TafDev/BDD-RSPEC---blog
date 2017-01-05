require 'rails_helper'

RSpec.feature "Adding comments to articles" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		@barvis = User.create(email: "barvis@example.com", password: "123456")
		@article = Article.create(title: "first article", body: "lorem ipsum 1", user: @john)
	end

	scenario "permits a signed in user to write a comment" do
		login_as @barvis
		visit '/'
		click_link @article.title
		fill_in "New Comment", with: "What an article!"
		click_button "Add Comment"

		expect(page).to have_content("Comment has been created")
		expect(page).to have_content("What an article!")
		expect(current_path).to eq article_path(@article.id)
	end
end