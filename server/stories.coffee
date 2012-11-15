Meteor.methods
  createStory: (info) ->
    user = Meteor.user()
    library = Babble.Library.getById info.lid
    book = Babble.Book.getById info.bid

    if not library or not book
      throw new Meteor.Error(403, "参数错误，无法创建文章: #{info.lid}, #{info.bid}")

    if not Babble.Library.writable(library) and not Babble.Book.writable(book)
      logger.info library, book, Babble.Library.writable(library), Babble.Book.writable(book)
      throw new Meteor.Error(403, '您没有权限在该系列中添加文章')

    #if Babble.Story.exists info.slug
    #  throw new Meteor.Error(403, "已经存在有相同slug的文章")


    if info.id
      cmd = 'update'
    else
      cmd = 'create'
    logger.info "#{cmd} story: #{info.title}, #{info.slug}, #{info.subtitle} for #{book.title} by #{user.username}"

    if info.id
      # if we found a story, then update existing one instead of creating a new story
      story = Babble.Story.getById info.id
      if story
        if not Babble.Story.writable story
          throw new Meteor.Error(403, "您没有权限修改该文章")

        info =
          title: info.title
          subtitle: info.subtitle
          content: info.content
          html: info.html
        Babble.Story.update story._id, info
        return story._id

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

  deleteStory: (id) ->
    user = Meteor.user()
    story = Babble.Story.getById id
    if not story
      return null

    if not Babble.Story.writable story
      throw new Meteor.Error(403, "您没有权限删除该文章")

    logger.info "delete story #{story.title}"
    Babble.Story.delete story
