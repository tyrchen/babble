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
    get: -> Babble.getSession('library') || null
    set: (value) -> Babble.setSession 'library', value

  book:
    get: -> Babble.getSession('book') || null
    set: (value) -> Babble.setSession 'book', value

  story:
    get: -> Babble.getSession('story') || null
    set: (value) -> Babble.setSession 'story', value