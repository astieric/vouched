#
#  Whether current object is in array of objects.
#   Usage examples: 
#      1.in? [1,2,3] # => true
#      1.in? [2,3] # => false
#  Can be possibly used for any object type, with overriden comparison operator
#

class Object
  def in? array
    array.include? self
  end
end
