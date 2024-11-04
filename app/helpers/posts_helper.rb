module PostsHelper
  def display_all_comments(comments)
    comments.map do |comment|
      comment_div = content_tag(:div, comment.body, class: "comment")

      user_div = content_tag(:div, comment.user.username, class: "username")

      likes_div = content_tag(:div, "#{comment.likes.count} likes", class: "likes")

      like_button = button_to "Like #{comment.likes.count}",
        like_user_path(comment_id: comment.id),
        method: :post,
        remote: true,
        class: "like-button"

      content_tag(:div, "#{comment_div} #{user_div} #{likes_div} #{like_button}".html_safe, class: "comment-container")
    end.join.html_safe
  end
end
