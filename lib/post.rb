class Post

	include DataMapper::Resource

	has n, :tag, :through => Resource
	has 1, :user, :through => Resource

	property :id, 			Serial
	property :title, 		String
	property :body, 		Text
	property :created_at, 	DateTime


end