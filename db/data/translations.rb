columns = [ :term_id, :phrase_id, :priority ]
values = [
  [25276,1,1],
  [34565,2,1],
  [34565,3,1],
  [34565,4,1],
  [34565,5,2],
  [34565,6,3],
  [34565,7,4],
  [34565,8,5],
  [23615,9,1],
  [23619,10,1],
  [23619,11,2],
  [414,12,1],
  [414,13,2],
  [628,14,1],
  [9792,15,1],
  [19079,16,1],
  [40678,17,1],
  [31699,18,1]
]

Translation.import columns, values, :validate => false