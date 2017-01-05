require 'rails_helper'

RSpec.feature "Show Article" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		login_as(@john)
		@article = Article.create(title: "first article", body: "lorem ipsum 1", user: @john)
	end
	scenario "user shows an article" do
		visit '/'
		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(current_path).to eq(article_path(@article))
	end
end