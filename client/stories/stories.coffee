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

    'click .story-edit': (e) ->
      e.preventDefault()
      e.stopPropagation()
      info =
        id: @_id
        title: @title
        subtitle: @subtitle
        html: @html

      # provide data to create panel so that user can edit
      amplify.store('storyToCreate', info)
      Babble.State.bookDisplay.set 2
      Router.setBook @bid

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