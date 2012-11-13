Babble = Babble || {}
Babble.Book = Babble.Book || {}

Babble.Book.getBySlug = (slug) -> Books.findOne slug: slug

Babble.Book.getById = (id) -> Books.findOne _id: id

Babble.Book.exists = (slug) ->
  Books.find(slug: slug).count() > 0

Babble.Book.create = (info) ->
  bookId = Books.insert info
  Libraries.update info.lid, $inc: books: 1

Babble.Book.writable = (book, userId = null) ->
  if typeof book is 'string'
    book = Babble.Book.getById book

  if userId
    _.contains book.authors, userId
  else
    _.contains book.authors, Meteor.userId()