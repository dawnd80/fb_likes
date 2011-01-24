class FbUser
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

  def find_commons(friend_id)
    user_likes = self.class.likes(graph, id)
    friend_likes = self.class.likes(graph, friend_id)
    common_likes = user_likes.map{|like| like["id"].to_i} & friend_likes.map{|like| like["id"].to_i}
    user_likes.select{|like| common_likes.include?(like["id"].to_i)}
  end

  protected
  def set_graph(token)
    self.graph = Koala::Facebook::GraphAPI.new(token)
  end
  
  def self.likes(api, userid)
    api.get_connections(userid, "likes")
  end

end