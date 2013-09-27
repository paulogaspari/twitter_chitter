require 'spec_helper'

describe Post do

	context "|||| The Database::     " do

		it 'has no posts' do
			expect(Post.count).to eq(0)
		end

		it 'has a post after creating one' do
			Post.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			expect(Post.count).to eq(1)
		end

		it 'has a post url of makers academy after creating that record' do
			Post.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")			
			post = Post.first
			expect(post.url).to eq("http://makersacademy.com/")
		end
 
		it 'has a post with title Makers Academy after creating that record' do
			Post.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			post = Post.first
			expect(post.title).to eq("Makers Academy")
		end
 
		it 'has no post after destroying a previously created post' do
			Post.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			post = Post.first
			post.destroy
			expect(Post.count).to eq(0)
		end
	end
end



