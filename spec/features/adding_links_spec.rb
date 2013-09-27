require 'spec_helper'

feature 'User adds a new post' do

	scenario 'when browsing the homepage' do
		expect(Post.count).to eq(0)
		visit '/'
		add_post("http://www.makersacademy.com/", "Makers Academy")
		expect(Post.count).to eq(1)
		post = Post.first
		expect(post.url).to eq("http://www.makersacademy.com/")
		expect(post.title).to eq("Makers Academy")
	end

	scenario 'with a few tags' do
		visit '/'
		add_post("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])
		post = Post.first
		expect(post.tags.map(&:text)).to include('education')
		expect(post.tags.map(&:text)).to include('ruby')
	end

	def add_post(url, title, tags = [])
		within("#new-post") do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			fill_in 'tags', :with => tags.join(' ')
			click_button 'Add post'
		end
	end
end