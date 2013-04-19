_.extend Template.library,
  events:
    'click .book-summary': (e) ->
      Router.setBook $(e.currentTarget).data('id')

    'click .create-book': (e) ->
      Template.bookCreatePanel.showDialog()

  library: ->
    lib = Babble.Library.getById Babble.State.library.get()

  authors: ->
    _.map @authors, (id) -> Babble.User.getById id

  writable: ->
    Babble.Library.writable @

  books: ->
    Books.find lid: @_id

_.extend Template.bookSummary,
  events:
    'click .book-edit': (e) ->
      e.preventDefault()
      e.stopPropagation()
      logger.debug 'click book edit'
      info =
        id: @_id
        title: @title
        #slug: @slug
        subtitle: @subtitle
        description: @description
      amplify.store 'bookToCreate', info
      Template.bookCreatePanel.showDialog()

    'click .book-delete': (e) ->
      e.preventDefault()
      e.stopPropagation()

      Template.confirmDialog.show @_id, "确认删除 #{@title}?", "系列一旦被删除就不能恢复!", (id) ->
        Meteor.call 'deleteBook', id, (error, result) ->
          if error
            return error.reason

          Router.setLibrary Babble.State.library.get()
          return null

  writable: ->
    Babble.Library.writable @lid

  deletable: ->
    Babble.Book.Deletable @

_.extend Template.bookCreatePanel,
  events:
    'click #book-create-submit': (e) ->
      e.preventDefault()
      e.stopPropagation()
      id = $('#book-id').val()
      title = $.trim $('#book-title').val()
      #slug = $('#book-slug').val()
      subtitle = $.trim $('#book-subtitle').val()
      description = $.trim $('#book-description').val()

      if not title
        $("#book-create-error").text('标题不能为空')
        return

      info =
        id: id
        title: title
        #slug: slug
        lid: Babble.State.library.get()
        subtitle: subtitle
        description: description
      amplify.store 'bookToCreate', info
      Meteor.call 'createBook', info, (error, result) ->
        if error
          $("#book-create-error").text(error.reason)
          return

        # TODO: Notify user item created successfully
        Template.bookCreatePanel.closeDialog()

    'click #book-create-cancel': (e) ->
      Template.bookCreatePanel.closeDialog()

  closeDialog: ->
    $('#book-create-dialog').modal 'hide'
    amplify.store 'bookToCreate', null
    $('#book-create-dialog form')[0]?.reset()
    $("#book-create-error").html('')

  showDialog: ->
    info = amplify.store 'bookToCreate'
    if info
      if info.id
        $('#book-id').val(info.id)
      $('#book-title').val(info.title)
      $('#book-slug').val(info.slug)
      $('#book-subtitle').val(info.subtitle)
      $('#book-description').val(info.description)

    $('#book-create-dialog').modal
      keyboard: false
      backdrop: 'static'