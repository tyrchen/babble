if Meteor.is_server

  Meteor.publish null, ->
    # publish desired user data to client
    Meteor.users.find {}, {fields: {
      username: 1
      avatar: 1
      url: 1
      points: 1
    }, sort: {points: -1}}

  Meteor.publish 'profiles', ->
    Profiles.find userId: Meteor.userId()

  Meteor.publish 'libraries', ->
    Libraries.find {}

  Meteor.publish 'books', (lid) ->
    Books.find {lid: lid}, {sort: 'createdAt': 1}

  Meteor.publish 'stories', (bid) ->
    Stories.find {bid: bid}, {sort: 'createdAt': 1}


if Meteor.is_client
  Meteor.autosubscribe ->
    lid = Babble.State.library.get()
    bid = Babble.State.book.get()

    Meteor.subscribe 'libraries', ->
      logger.info 'Libraries loaded'

    if lid
      Meteor.subscribe 'books', lid, ->
        logger.info "books for library #{lid} loaded"

    if bid
      Meteor.subscribe 'stories', bid, ->
        logger.info 'stories for book #{bid} loaded'

