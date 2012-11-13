Babble = Babble || {}
Babble.Story = Babble.Story || {}

Babble.Story.exists = (slug) ->
  Stories.find(slug: slug).count() > 0

Babble.Story.create = (info) ->
  bookId = Stories.insert info
  Books.update info.bid, $inc: stories: 1
