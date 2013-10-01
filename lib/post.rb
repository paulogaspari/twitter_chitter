class Post

	include DataMapper::Resource

	has n, :tags, :through => Resource
	belongs_to :user

	property :id, 			Serial
	property :title, 		String, length: 1..60, :message=> "Keep your title short. Max 60 chars."
	property :body, 		Text
	property :created_at, 	DateTime


end