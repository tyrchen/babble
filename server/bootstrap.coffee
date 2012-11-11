# if database is empty, on startup, create some basic data

resetData = ->
  user = Meteor.users.findOne username: '陈天_Tyr'

  if Libraries.find().count() is 0 and user?
    # Library = {
    #   _id: uuid, title: '觅珠人', slug: 'dive-for-pearls', createdAt: new Date()
    #   logo: '', subtitle: 'xxxx', authors: []
    #   books: 123, readers: 456, articles: 789
    # }
    data = [
      {title: '觅珠人', slug: 'dive-for-pearls', authors: [user._id]}
    ]

    for item in data
      id = Libraries.insert
        title: item.title
        slug: item.slug
        subtitle: ''
        authors: item.authors
        createdAt: Babble.now()
        logo: null
        books: 0
        readers: 0
        articles: 0

createUserHook = ->
  Accounts.onCreateUser (options, user) ->
    profile = options.profile

    if user.services.weibo?
      user.username = profile.screen_name
      user.description = profile.description
      user.avatar = profile.profile_image_url
      user.url = "http://weibo.com/#{profile.profile_url}"
      user.location = profile.location
      profile.status = null

    if user.services.github?
      user.username = profile.name
      user.description = profile.bio
      user.avatar = profile.avatar_url
      user.url = profile.html_url
      user.location = profile.location

    if user.services.google?
      user.username = profile.name
      user.description = ''
      user.avatar = ''
      user.url = profile.link
      user.location = ''

    return user

Meteor.startup ->
  resetData()
  createUserHook()