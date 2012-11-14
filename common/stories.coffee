Babble = Babble || {}
Babble.Story = Babble.Story || {}

Babble.Story.getBySlug = (slug) -> Stories.findOne slug: slug

Babble.Story.getById = (id) -> Stories.findOne _id: id

Babble.Story.getNextById = (id) ->
  story = Babble.Story.getById id
  if story
    return Stories.findOne {createdAt: $gt: story.createdAt}, {sort: createdAt: 1}
  return null

Babble.Story.exists = (slug) ->
  Stories.find(slug: slug).count() > 0

Babble.Story.create = (info) ->
  bookId = Stories.insert info
  Books.update info.bid, $inc: stories: 1

if Meteor.is_server
  Babble.Story.create = (info) ->
    storyId = Stories.insert info
    Libraries.update info.lid, $inc: stories: 1
    Books.update info.bid, $inc: stories: 1
    return storyId