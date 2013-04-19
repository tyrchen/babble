Babble = Babble || {}
Babble.User = Babble.User || {}

Babble.User.getById = (id) -> Meteor.users.findOne _id: id