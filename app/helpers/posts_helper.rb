module PostsHelper
  def display_all_comments(post)
    comments_html = post.comments.where(parent_id: nil).map do |comment|
      content_tag(:div, class: "comment") do
        display_single_comment(comment)
      end
    end.join.html_safe

    content_tag(:div, comments_html, class: "comments-container")
  end

  def post_comment_field(post)
    return unless current_user

    content_tag(:div, class: "comment-form-container") do
      form_with(model: [ @post, Comment.new ], url: post_comments_path(@post), local: true, class: "comment-form") do |form|
        content_tag(:div, class: "comment-input-group") do
          form.hidden_field(:user_id, value: current_user.id) +
          form.text_area(:body, placeholder: "Share your thoughts...", class: "comment-input") +
          form.submit("Comment", class: "comment-submit-button")
        end
      end
    end
  end

  private

  def display_single_comment(comment)
    comment_div = content_tag(:div, comment.body, class: "comment")
    user_likes_reply_div = content_tag(:div, class: "user-likes-reply") do
      user_div = content_tag(:div, "- " + comment.user.username, class: "username")
      like_button = button_to "Like #{comment.likes.count}",
                            like_user_path(comment_id: comment.id),
                            method: :post,
                            remote: true,
                            class: "like-button"
      reply_button = button_tag "Reply",
                                class: "reply-button",
                                data: { action: "click->reply-form#toggle" }

      safe_join([ user_div, like_button, reply_button ])
    end

    reply_form = content_tag(:div, class: "reply-form-container", style: "display: none;", data: { reply_form_target: "formContainer" }) do
      form_with(model: [ @post, Comment.new ], url: post_comments_path(@post), remote: true) do |form|
        form.hidden_field(:parent_id, value: comment.id) +
        form.hidden_field(:user_id, value: current_user.id) +
        form.text_area(:body, placeholder: "Write your reply...") +
        form.submit("Post Reply", class: "reply-submit-button")
      end
    end

    replies_html = comment.replies.map { |reply| display_single_comment(reply) }.join.html_safe

    content_tag(:div, "#{comment_div} #{user_likes_reply_div} #{reply_form} #{replies_html}".html_safe,
                class: "comment-container",
                data: { controller: "reply-form" })
  end
end
