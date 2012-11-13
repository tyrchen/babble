Babble.router = Backbone.Router.extend
  routes:
    '': 'home'
    'sets/:slug': 'library'
    'series/:slug': 'book'
    'articles/:slug': 'story'

  home: ->
    logger.debug 'navigate to a sets'
    this.navigate "/sets/#{Babble.Const.DEFAULT_LIBRARY}"

  library: (slug) ->
    Babble.State.library.set slug

  book: (slug) ->
    Babble.State.book.set slug

  story: (slug) ->
    Babble.State.story.set slug

  setLibrary: (slug) ->
    this.navigate "/sets/#{slug}", true

  setBook: (slug) ->
    this.navigate "/series/#{slug}", true

  setStory: (slug) ->
    this.navigate "/articles/#{slug}", true

Router = new Babble.router

Meteor.startup ->
  Backbone.history.start pushState: true
