_.extend Template.story,
  rendered: ->
    prettyPrint()

  events:
    'click .menu-box': (e) ->
      bid = $(e.currentTarget).data('id')
      Router.setBook bid

    'click .next-story': (e) ->
      id = $(e.currentTarget).data('id')
      Router.setStory id

    'click .back-to-book': (e) ->
      story = Babble.Story.getById Babble.State.story.get()
      Router.setBook story.bid

  story: ->
    story = Babble.Story.getById Babble.State.story.get()
    if story and not Babble.State.book.get()
      Babble.State.book.set {id: story.bid}
      Babble.State.library.set {id: story.lid}

    return story

  writable: ->
    if @_id
      Babble.Story.writable @_id

  deletable: ->
    if @bid
      Babble.Book.writable @bid

  nextStory: ->
    return Babble.Story.getNextById Babble.State.story.get()