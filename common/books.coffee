Babble = Babble || {}
Babble.Book = Babble.Book || {}

Babble.Book.getBySlug = (slug) -> Books.findOne slug: slug

Babble.Book.getById = (id) -> Books.findOne _id: id

Babble.Book.exists = (slug) ->
  Books.find(slug: slug).count() > 0

Babble.Book.writable = (book, userId = null) ->
  if typeof book is 'string'
    book = Babble.Book.getById book

  if userId
    _.contains book.authors, userId
  else
    _.contains book.authors, Meteor.userId()

Babble.Book.Deletable = (book, userId = null) ->
  if typeof book is 'string'
    book = Babble.Book.getById book

  if Babble.Book.writable book, userId
    return not book.stories or book.stories is 0

  return false


if Meteor.is_server
  # DO NOT call the following functions directly
  Babble.Book.create = (info) ->
    bookId = Books.insert info
    Libraries.update info.lid, $inc: books: 1
    return bookId

  Babble.Book.update = (id, info) ->
    info['updatedAt'] = Babble.now()
    Books.update id, $set: info

  Babble.Book.delete = (book) ->
    Books.remove _id: book._id
    Libraries.update book.lid, $inc: books: -1
