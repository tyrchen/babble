Babble = Babble || {}
Babble.setBodyClass = ->
  if Babble.State.story.get()
    $('body').removeClass('book library').addClass('story')
  else if Babble.State.book.get()
    $('body').removeClass('story library').addClass('book')
  else
    $('body').removeClass('story book').addClass('library')

_.extend Template.nav,
  title: -> 'Babble'