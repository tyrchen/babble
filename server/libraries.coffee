Meteor.methods
  createLibrary: (title, subtitle, description) ->
    logger.info "create library with title #{title} by #{Meteor.user().username}"
