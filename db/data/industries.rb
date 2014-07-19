columns = [ :id, :name ]
values = [
  [1,"Agriculture and Mining"],
  [2,"Business Services"],
  [3,"Computers and Electronics"],
  [4,"Consumer Services"],
  [5,"Education"],
  [6,"Energy and Utilities"],
  [7,"Financial Services"],
  [8,"Government"],
  [9,"Healthcare, Pharmaceuticals, and Biotech"],
  [10,"Manufacturing"],
  [11,"Media and Entertainment"],
  [12,"Non-Profit"],
  [13,"Other"],
  [14,"Real Estate and Construction"],
  [15,"Retail"],
  [16,"Software and Internet"],
  [17,"Telecommunications"],
  [18,"Transportation and Storage"],
  [19,"Travel, Recreation, and Leisure"],
  [20,"Wholesale and Distribution"]
]

Industry.import columns, values, :validate => false