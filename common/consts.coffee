Babble = Babble || {}
Babble.Const = Babble.Const || {}
Babble.Const.DEFAULT_LIBRARY = 'dive-for-pearls'
Babble.Const.DEFAULT_LIBRARY_ID = '2df5d6ba-d644-459b-8471-1fc5aa8b774e'

Babble.Const.VALID_ELEMENTS = 
  '''
  @[class|title],a[href|target|title],strong/b,em/i,strike,u,
  #p,-ol[type|compact],-ul[type|compact],-li,br,img[src|border|alt=|title|hspace|vspace|width|height|align],-sub,-sup,
  -blockquote,-table[border=0|cellspacing|cellpadding|width|frame|rules|
  height|align|summary|bgcolor|background|bordercolor],-tr[rowspan|width|
  height|align|valign|bgcolor|background|bordercolor],tbody,thead,tfoot,
  #td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor
  |scope],#th[colspan|rowspan|width|height|align|valign|scope],caption,-div,
  -span,-code,-pre,address,-h1,-h2,-h3,-h4,-h5,-h6,hr[size|noshade],-font[face
  |size|color],dd,dl,dt,cite,abbr,acronym,del[datetime|cite],ins[datetime|cite],
  object[classid|width|height|codebase|*],param[name|value|_value],embed[type|width
  |height|src|*],script[src|type],map[name],area[shape|coords|href|alt|target],bdo,
  col[align|char|charoff|span|valign|width],colgroup[align|char|charoff|span|
  valign|width],dfn,,small,tt,var,big
  '''