module PostsHelper

  def join_tags(post)
    post.tags.map { |t| t.name }.sort.join(", ")
  end
  

end
