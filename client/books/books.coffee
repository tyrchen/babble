_.extend Template.book,
  book: ->
    Babble.Book.getById Babble.State.book.get()

  authors: ->
    _.map @authors, (id) -> Babble.User.getById id
