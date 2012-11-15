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

    'click .story-delete': (e) ->
      e.preventDefault()
      e.stopPropagation()
      logger.debug @_id

      Template.storyDeleteDialog.show @

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

_.extend Template.storyDeleteDialog,
  events:
    'click #story-delete-cancel': (e) ->
      e.preventDefault()
      Template.storyDeleteDialog.hide()

    'click #story-delete-submit': (e) ->
      e.preventDefault()
      id = $('#story-delete-id').val()
      Meteor.call 'deleteStory', id, (error, result) ->
        logger.info 'error:', error, 'result:', result
        if error
          $("#story-delete-error").text(error.reason)
          return

        Template.storyDeleteDialog.hide()
        Babble.State.story.set null

  show: (story)->
    $node = $('#story-delete-dialog')
    $('#story-delete-id').val(story._id)
    $('h3', $node).text "确认删除 #{story.title}?"
    $('#story-delete-dialog').modal()

  hide: ->
    $('#story-delete-dialog').modal 'hide'