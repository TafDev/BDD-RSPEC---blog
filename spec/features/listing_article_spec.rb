require 'rails_helper'

RSpec.feature "Listing Articles" do
	before do
		@john = User.create(email: "john@example.com", password: "123456")
		@article1 = Article.create(title: "first article", body: "lorem ipsum 1", user: @john)
		@article2 = Article.create(title: "second article", body: "lorem ipsum 2", user: @john)
	end

	scenario "lists all articles when user not signed in" do
		visit '/'
		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.body)
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.body)
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
		expect(page).not_to have_link("New Article")
	end

	scenario "lists all articles when user signed in" do
		login_as(@john)
		visit '/'
		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.body)
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.body)
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
		expect(page).to have_link("New Article")
	end

	scenario "user lists all articles" do
		visit '/'
		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.body)
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.body)
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
	end

	scenario "there is not article to display" do
		Article.delete_all
		visit "/"
		expect(page).not_to have_content(@article1.title)
		expect(page).not_to have_content(@article1.body)
		expect(page).not_to have_content(@article2.title)
		expect(page).not_to have_content(@article2.body)
		expect(page).not_to have_link(@article1.title)
		expect(page).not_to have_link(@article2.title)

		within("h1#no-articles") do
			expect(page).to have_content("No Articles Found")
		end
	end

end