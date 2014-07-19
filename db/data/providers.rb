columns = [ :id, :name ]
values = [
  [0, "user"     ],
  [1, "email"     ],
  [2, "twitter"   ],
  [3, "open_id"   ],
  [4, "facebook"  ],
  [5, "github"    ],
  [6, "linked_in" ]
]

Provider.import columns, values, :validate => false