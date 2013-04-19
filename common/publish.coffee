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
    total = Books.find(lid:lid).count()
    if total > 0
      Books.find {lid: lid}, {sort: 'createdAt': 1}
    else
      Books.find {_id: lid}

  Meteor.publish 'stories', (bid) ->
    total = Stories.find(bid:bid).count()
    if total > 0
      Stories.find {bid: bid}, {sort: 'createdAt': 1}
    else
      Stories.find {_id: bid}


if Meteor.is_client
  Meteor.autosubscribe ->
    lid = Babble.State.library.get()
    bid = Babble.State.book.get()
    sid = Babble.State.story.get()

    Meteor.subscribe 'libraries', ->
      logger.info 'Libraries loaded'

    if lid
      Meteor.subscribe 'books', lid, ->
        logger.info "books for library #{lid} loaded"
    else if bid
      Meteor.subscribe 'books', bid, ->
        logger.info "books with id #{bid} loaded"


    if bid
      Meteor.subscribe 'stories', bid, ->
        logger.info "stories for book #{bid} loaded"
    else if sid
      Meteor.subscribe 'stories', sid, ->
        logger.info "stories with id #{sid} loaded"
