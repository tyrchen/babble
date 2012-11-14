_.extend Template.book,
  events:
    'click .book .control > li': (e) ->
      Babble.State.bookDisplay.set parseInt($(e.target).data('value'))

  book: ->
    Babble.Book.getById Babble.State.book.get()

  authors: ->
    _.map @authors, (id) -> Babble.User.getById id

  writable: ->
    Babble.Library.writable @lid or Babble.Book.writable @

  allActive: ->
    if Babble.State.bookDisplay.get() is 0
      return 'active'
    return ''

  unreadActive: ->
    if Babble.State.bookDisplay.get() is 1
      return 'active'
    return ''

  composeActive: ->
    if Babble.State.bookDisplay.get() is 2
      return 'active'
    return ''

_.extend Template.composePanel,
  rendered: ->
    logger.debug 'compose panel rendered'
    $('#story-content').tinymce
      script_url: '/tiny_mce/tiny_mce.js'
      theme: 'advanced'
      plugins: 'autolink,lists,style,fullscreen'
      theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,forecolor,backcolor,|,fullscreen"


