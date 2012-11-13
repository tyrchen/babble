Babble = Babble || {}
Babble.bodyClass = ->
  if Babble.State.story.get()
    return 'story'
  else if Babble.State.book.get()
    return 'book'
  else
    return 'library'

_.extend Template.nav,
  title: -> 'Babble'


Meteor.startup ->
  logger.info 'startup'
  $('body').addClass(Babble.bodyClass())