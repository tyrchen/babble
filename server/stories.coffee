Meteor.methods
  createStory: (info) ->
    user = Meteor.user()
    library = Babble.Library.getById info.lid
    book = Babble.Book.getById info.bid

    if not library or not book
      throw new Meteor.Error(403, "参数错误，无法创建文章: #{info.lid}, #{info.bid}")

    logger.info "created story: #{info.title}, #{info.slug}, #{info.subtitle} for #{book.title} by #{user.username}"

    if not Babble.Library.writable(library) and not Babble.Book.writable(book)
      logger.info library, book, Babble.Library.writable(library), Babble.Book.writable(book)
      throw new Meteor.Error(403, '您没有权限在该系列中添加文章')

    #if Babble.Story.exists info.slug
    #  throw new Meteor.Error(403, "已经存在有相同slug的文章")

    now = Babble.now()
    info =
      title: info.title
      #slug: info.slug
      lid: library._id
      bid: book._id
      subtitle: info.subtitle
      content: info.content
      html: info.html
      createdAt: now
      updatedAt: now
      publishedAt: now
      authors: [user._id]
      files: []
      hearts: 0
      reads: 0


    return Babble.Story.create info