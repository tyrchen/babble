_.extend Template.book,
  events:
    'click .menu-box': (e) ->
      lid = $(e.currentTarget).data('id')
      Router.setLibrary lid

    'click .book .control > li': (e) ->
      Babble.State.bookDisplay.set parseInt($(e.target).data('value'))

    'click .story-summary': (e) ->
      Babble.State.bookDisplay.set 0
      Router.setStory $(e.currentTarget).data('id')

  book: ->
    book = Babble.Book.getById Babble.State.book.get()
    if book and not Babble.State.library.get()
      Babble.State.library.set {id: book.lid}
    return book

  stories: ->
    Stories.find bid: Babble.State.book.get()

  total_stories: ->
    @stories

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
    info = amplify.store('storyToCreate')
    logger.debug 'compose panel rendered', info

    $('#story-content').tinymce
      script_url: '/tiny_mce/tiny_mce.js'
      theme: 'advanced'
      plugins: 'autolink,lists,style,fullscreen,filepicker'
      mode: 'exact'
      language: 'cn'
      valid_elements: Babble.Const.VALID_ELEMENTS
      theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,formatselect,fontselect,fontsizeselect,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,forecolor,backcolor,|,fullscreen,|,code,|,filepicker"
      theme_advanced_blockformats : "p,h1,h2,h3,h4,h5,h6,pre"

    if info
      $('#story-title').val(info.title)
      $('#story-slug').val(info.slug)
      $('#story-subtitle').val(info.subtitle)
      $('#story-content').html(info.html)

    $("#story-title").focus()

  events:
    'click #story-create-submit': (e) ->
      e.preventDefault()
      # format data
      html = '<div>' + $('#story-content').html() + '</div>'
      $node = $(html)
      $node.find('a').attr('target', '_blank')
      $node.find('pre').addClass('prettyprint linenums')

      html = $node.html()

      title = $.trim $('#story-title').val()
      #slug = $('#story-slug').val()
      subtitle = $.trim $('#story-subtitle').val()
      html = $.trim html
      content = $.trim $('#story-content').text().slice(0, 300)

      if not title or not content
        $("#story-create-error").text('标题和内容不能为空')
        return

      book = Books.findOne _id: Babble.State.book.get()

      info =
        title: title
        #slug: slug
        bid: book._id
        lid: book.lid
        subtitle: subtitle
        html: html
        content: content

      amplify.store 'storyToCreate', info

      Meteor.call 'createStory', info, (error, result) ->
        logger.info 'error:', error, 'result:', result
        if error
          $("#story-create-error").text(error.reason)
          return

        # TODO: Notify user item created successfully
        Template.composePanel.close()

    'click #story-create-cancel': (e) ->
      Template.composePanel.close()

  close: ->
    amplify.store('storyToCreate', null)
    Babble.State.bookDisplay.set 0

_.extend Template.storySummary,
  content: ->
    content = @content.slice(0, 300)
    return content.replace(/\n/g, '<br/>').replace(/&nbsp;/g, ' ')

  authors: ->
    _.map @authors, (id) -> Babble.User.getById id

  created: ->
    moment(new Date(@createdAt)).fromNow()

Meteor.startup ->
  filepicker.setKey 'Aty5T6XmXRWyke0IG01caz'