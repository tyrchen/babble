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
    'sets/:slug': 'library'
    'series/:slug': 'book'
    'articles/:slug': 'story'

  home: ->
    logger.debug 'navigate to a sets'
    this.navigate "/sets/#{Babble.Const.DEFAULT_LIBRARY}"

  library: (slug) ->
    Babble.Router.setState 'library', slug
    Babble.State.story.set null
    Babble.State.book.set null

  book: (slug) ->
    Babble.Router.setState 'book', slug
    Babble.State.story.set null

  story: (slug) ->
    Babble.Router.setState 'story', slug

  setLibrary: (slug) ->
    this.navigate "/sets/#{slug}", true

  setBook: (slug) ->
    this.navigate "/series/#{slug}", true

  setStory: (slug) ->
    this.navigate "/articles/#{slug}", true

Router = new Babble.Router.router

Meteor.startup ->
  Backbone.history.start pushState: true
