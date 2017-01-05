require "rails_helper"

RSpec.feature "Creating articles" do
	before do
		@john = User.create!(email: "john@example.com", password: "123456")
		login_as(@john)
	end

	scenario "user creates a new article" do
		visit "/"
		click_link "New Article"
		fill_in "Title", with: "Creating a Blog"
		fill_in "Body", with: "Lorem Ipsum"
		click_button "Create Article"

		expect(Article.last.user).to eq(@john)
		expect(page).to have_content("Article has been created")
		expect(page.current_path).to eq(articles_path)
		expect(page).to have_content("Created by: #{@john.email}")
	end

	scenario "user fails to create new article" do
		visit "/"
		click_link "New Article"
		fill_in "Title", with: ""
		fill_in "Body", with: ""
		click_button "Create Article"

		expect(page).to have_content("Article has not been created")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Body can't be blank")
	end
end