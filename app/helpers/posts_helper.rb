module PostsHelper
  def author_id_field(post)
    if post.author.nil? # allows us to have an extra author id field
        select_tag "post[:author_id]", options_from_collection_for_select(Author.all, :id, :name)
    else
        hidden_field_tag "post[:author_id]", post_author_id
    end
  end
end
