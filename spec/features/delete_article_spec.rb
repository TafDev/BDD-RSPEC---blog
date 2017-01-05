require 'rails_helper'

RSpec.feature "Delete Article" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		login_as(@john)
		@article = Article.create(title: "first article", body: "lorem ipsum 1", user: @john)
	end

	scenario "user deletes an article" do
		visit '/'
		click_link @article.title
		click_link "Delete Article"

		expect(page).to have_content("Article has been deleted")
		expect(current_path).to eq(articles_path)
	end
end