require 'rails_helper'

RSpec.feature "Listing Articles" do
	before do
		@article1 = Article.create(title: "first article", body: "lorem ipsum 1")
		@article2 = Article.create(title: "second article", body: "lorem ipsum 2")
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