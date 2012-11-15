Babble = Babble || {}
Babble.Story = Babble.Story || {}

Babble.Story.getBySlug = (slug) -> Stories.findOne slug: slug

Babble.Story.getById = (id) -> Stories.findOne _id: id

Babble.Story.getNextById = (id) ->
  story = Babble.Story.getById id
  if story
    return Stories.findOne {createdAt: $gt: story.createdAt}, {sort: createdAt: 1}
  return null

Babble.Story.writable = (story, userId = null) ->
  if typeof story is 'string'
    story = Babble.Story.getById story

  if userId
    _.contains story.authors, userId
  else
    _.contains story.authors, Meteor.userId()

Babble.Story.exists = (slug) ->
  Stories.find(slug: slug).count() > 0

if Meteor.is_server
  # DO NOT call the following functions directly
  Babble.Story.create = (info) ->
    storyId = Stories.insert info
    Libraries.update info.lid, $inc: stories: 1
    Books.update info.bid, $inc: stories: 1
    return storyId

  Babble.Story.update = (id, info) ->
    info['updatedAt'] = Babble.now()
    Stories.update id, $set: info

  Babble.Story.delete = (story) ->
    Stories.remove _id: story._id
    delete story['_id']
    DeletedStories.insert story
    Books.update story.bid, $inc: stories: -1
    Libraries.update story.lid, $inc: stories: -1