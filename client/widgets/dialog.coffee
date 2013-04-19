_.extend Template.confirmDialog,
  events:
    'click #confirm-dialog-cancel': (e) ->
      e.preventDefault()
      Template.confirmDialog.hide()

    'click #confirm-dialog-submit': (e) ->
      e.preventDefault()
      id = $('#confirm-dialog-id').val()
      ret = Template.confirmDialog.callback id
      if not ret
        Template.confirmDialog.hide()
      else
        $('#confirm-dialog-error').text(ret)

  show: (id, title, content, callback)->
    $node = $('#confirm-dialog')
    $('#confirm-dialog-id').val id
    $('.title', $node).text title
    $('.content', $node).text content
    Template.confirmDialog.callback = callback
    $('#confirm-dialog').modal()

  hide: ->
    $('#confirm-dialog').modal 'hide'