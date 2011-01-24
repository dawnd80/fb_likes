class FBUser
  attr_accessor :id, :name, :graph
  
  def initialize(token)
    set_graph(token)
    user = graph.get_object('me')
    user.each do |k, v|
      self.send("#{k}=", v) if self.respond_to? k
    end if user
    self
  end
  
  def friends
    graph.get_connections(id, "friends").sort{|f1, f2| f1['name'] <=> f2['name']}
  end
  
  def friend(id)
    graph.get_object(id)
  end

  def likes(userid='me')
    graph.get_connections(userid, "likes")
  end

  protected
  def set_graph(token)
    self.graph = Koala::Facebook::GraphAPI.new(token)
  end

end