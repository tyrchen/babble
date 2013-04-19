Babble = Babble || {}
Babble.Library = Babble.Library || {}

Babble.Library.getBySlug = (slug) -> Libraries.findOne slug: slug

Babble.Library.getById = (id) -> Libraries.findOne _id: id

Babble.Library.writable = (lib, userId = null) ->
  if typeof lib is 'string'
    lib = Babble.Library.getById lib

  if userId
    _.contains lib.authors, userId
  else
    _.contains lib.authors, Meteor.userId()