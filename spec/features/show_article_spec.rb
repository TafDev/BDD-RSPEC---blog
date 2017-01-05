require 'rails_helper'

RSpec.feature "Show Article" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		@barvis = User.create(email: "barvis@example.com", password: "123456")
		@article = Article.create(title: "first article", body: "lorem ipsum 1", user: @john)
	end
	scenario "hide edit and delete buttons for non signed in users" do
		visit '/'
		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
	end

	scenario "hide edit and delete buttons for non owner" do
		login_as(@barvis)
		visit '/'
		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
	end
end