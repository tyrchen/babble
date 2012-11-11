# Library = {
#   _id: uuid, title: '觅珠人', slug: 'dive-for-pearls', createdAt: new Date()
#   logo: '', subtitle: 'xxxx', authors: []
#   books: 123, readers: 456, articles: 789
# }
Libraries = new Meteor.Collection 'libraries'

# Books = {
#   _id: uuid, title: '关于觅珠人的一切', slug: 'insider', createdAt: new Date()
#   cover: '', subtitle: 'xxxx', authors: [], lid: uuid
#   articles: 12, hearts: 6, reads: 88, forcastId: uuid
# }
Books = new Meteor.Collection 'books'

# Stories = {
#   _id: uuid, title: '为什么写babble?', slug: 'why-bubble', createdAt: new Date()
#   subtitle: 'xxx', authors: [], content: 'xxxx', files: []
#   lid: uuid, bid: uuid
#   hearts: 3, reads: 34
# }
Stories = new Meteor.Collection 'stories'

# profile = {
#   _id: uuid, userId: userId, online: true/false,
#   lastActive: new Date(), totalSeconds: integer
#   email: email, subscriptions: [bid1, bid2, ...]
# }
Profiles = new Meteor.Collection 'profiles'