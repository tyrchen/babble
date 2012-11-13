Babble = Babble || {}
Babble.Router = Babble.Router || {}
Babble.Router.setState = (state, slug) ->
  # here we need to delay initial url parsing since data hasn't arrived
  Meteor.autorun (handle)->
    logger.debug state, slug

    switch state
      when 'library' then item = Babble.Library.getBySlug slug
      when 'book' then item = Babble.Book.getBySlug slug
      when 'story' then item = Babble.Story.getBySlug slug
      else
        handle.stop()
        return

    if not item then return

    handle.stop()

    logger.debug 'item:', item
    Babble.State[state].set
      id: item._id
      name: item.slug

Babble.Router.router = Backbone.Router.extend
  routes:
    '': 'home'
    'sets/:id': 'library'
    'series/:id': 'book'
    'articles/:id': 'story'

  home: ->
    this.navigate "/sets/#{Babble.Const.DEFAULT_LIBRARY_ID}"

  library: (id) ->
    #Babble.Router.setState 'library', slug
    Babble.State.library.set {id: id}
    Babble.State.story.set null
    Babble.State.book.set null
    Babble.setBodyClass()

  book: (id) ->
    #Babble.Router.setState 'book', slug
    Babble.State.book.set {id: id}
    Babble.State.story.set null
    Babble.setBodyClass()

  story: (id) ->
    #Babble.Router.setState 'story', slug
    Babble.State.story.set {id: id}
    Babble.setBodyClass()

  setLibrary: (id) ->
    this.navigate "/sets/#{id}", true

  setBook: (id) ->
    this.navigate "/series/#{id}", true

  setStory: (id) ->
    this.navigate "/articles/#{id}", true

Router = new Babble.Router.router

Meteor.startup ->
  Backbone.history.start pushState: true
