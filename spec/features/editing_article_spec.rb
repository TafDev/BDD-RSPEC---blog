require 'rails_helper'

RSpec.feature "Edit Article" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		login_as(@john)
		@article = Article.create(title: "title1", body: "body of article 1", user: @john)
	end

	scenario "user update an article" do
		visit '/'
		click_link @article.title
		click_link "Edit Article"
		fill_in "Title", with: "Updated Title"
		fill_in "Body", with: "Updated Body"
		click_button "Update Article"

		expect(page).to have_content("Article has been updated")
		expect(page.current_path).to eq(article_path(@article))

	end

	scenario "update article fails" do
		visit '/'
		click_link @article.title
		click_link "Edit Article"
		fill_in "Title", with: ""
		fill_in "Body", with: ""
		click_button "Update Article"

		expect(page).to have_content("Article has not been updated")
		expect(page.current_path).to eq(article_path(@article))
	end
end