Meteor.methods
  createBook: (info) ->
    user = Meteor.user()
    library = Babble.Library.getById info.lid

    if not library
      throw new Meteor.Error(403, "参数错误，无法创建系列: #{info.lid}")


    if not Babble.Library.writable library
      throw new Meteor.Error(403, '您没有权限添加系列')

    #if Babble.Book.exists info.slug
    #  throw new Meteor.Error(403, "已经存在有相同slug的系列")


    if info.id
      cmd = 'update'
    else
      cmd = 'create'
    logger.info "#{cmd} book: #{info.title}, #{info.slug}, #{info.subtitle}, for #{library.title} by #{user.username}"

    if info.id
      # if we found a story, then update existing one instead of creating a new story
      book = Babble.Book.getById info.id
      if book
        if not Babble.Book.writable book
          throw new Meteor.Error(403, "您没有权限修改该系列")

        info =
          title: info.title
          subtitle: info.subtitle
          description: info.description
        Babble.Book.update book._id, info
        return book._id

    now = Babble.now()
    info =
      title: info.title
      #slug: info.slug
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

  deleteBook: (id) ->
    user = Meteor.user()
    book = Babble.Book.getById id
    if not book
      return null

    if not Babble.Book.writable book
      throw new Meteor.Error(403, "您没有权限删除该系列")

    logger.info "delete book #{book.title}"
    Babble.Book.delete book