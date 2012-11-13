Babble = Babble || {}
Babble.getSession = (name) ->
  Session.get name

Babble.setSession = (name, value) ->
  Session.set name, value

Babble.State = {}
_.extend Babble.State,
  loaded:
    get: -> Babble.getSession('loaded') || false
    set: (value) -> Babble.setSession 'loaded', value

  library:
    get: -> Babble.getSession('library')?.id || null
    getName: -> Babble.getSession('library')?.slug || null
    set: (value) -> Babble.setSession 'library', value

  book:
    get: -> Babble.getSession('book')?.id || null
    getName: -> Babble.getSession('book')?.slug || null
    set: (value) -> Babble.setSession 'book', value

  story:
    get: -> Babble.getSession('story')?.id || null
    getName: -> Babble.getSession('story')?.slug || null
    set: (value) -> Babble.setSession 'story', value

  bookDisplay:
    get: -> Babble.getSession('bookDisplay') || 0
    set: (value) -> Babble.setSession 'bookDisplay', value