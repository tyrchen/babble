_.extend Template.library,
  events:
    'click .book-create': (e) ->
      Template.bookCreatePanel.showDialog()

    'click .book-summary': (e) ->
      Router.setBook $(e.currentTarget).data('id')

  library: ->
    lib = Babble.Library.getById Babble.State.library.get()

  authors: ->
    _.map @authors, (id) -> Babble.User.getById id

  writable: ->
    Babble.Library.writable @

  books: ->
    Books.find lid: @_id

_.extend Template.bookCreatePanel,
  events:
    'click #book-create-submit': (e) ->
      title = $.trim $('#book-title').val()
      #slug = $('#book-slug').val()
      subtitle = $.trim $('#book-subtitle').val()
      description = $.trim $('#book-description').val()

      if not title
        $("#book-create-error").text('标题不能为空')
        return
        
      info =
        title: title
        #slug: slug
        lid: Babble.State.library.get()
        subtitle: subtitle
        description: description
      amplify.store 'bookToCreate', info
      Meteor.call 'createBook', info, (error, result) ->
        logger.info 'error:', error, 'result:', result
        if error
          $("#book-create-error").text(error.reason)
          return

        # TODO: Notify user item created successfully
        Template.bookCreatePanel.closeDialog()

    'click #book-create-cancel': (e) ->
      Template.bookCreatePanel.closeDialog()

  closeDialog: ->
    amplify.store 'bookToCreate', null
    $('#book-create-dialog form')[0]?.reset()
    $("#book-create-error").html('')
    $('#book-create-dialog').modal 'hide'

  showDialog: ->
    info = amplify.store 'bookToCreate'
    if info
      $('#book-title').val(info.title)
      $('#book-slug').val(info.slug)
      $('#book-subtitle').val(info.subtitle)
      $('#book-description').val(info.description)

    $('#book-create-dialog').modal
      keyboard: false
      backdrop: 'static'