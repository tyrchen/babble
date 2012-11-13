Meteor.methods
  createBook: (info) ->
    user = Meteor.user()
    library = Babble.Library.getById info.lid

    if not library
      throw new Meteor.Error(403, "参数错误，无法创建系列: #{info.lid}")

    logger.info "created book: #{info.title}, #{info.slug}, #{info.subtitle}, #{info.description} for #{library.title} by #{user.username}"

    if not Babble.Library.writable library
      throw new Meteor.Error(403, '您没有权限添加系列')

    if Babble.Book.exists info.slug
      throw new Meteor.Error(403, "已经存在有相同slug的系列")

    now = Babble.now()
    info =
      title: info.title
      slug: info.slug
      lid: library._id
      subtitle: info.subtitle
      description: info.description
      createdAt: now
      updatedAt: now
      authors: [user._id]
      stories: 0
      hearts: 0
      reads: 0

    return Babble.Book.create info
