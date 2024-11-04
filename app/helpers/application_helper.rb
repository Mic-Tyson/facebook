module ApplicationHelper
  def display_card_comments(comments)
    if comments.size > 2
      displayed_comments = comments.first(2).map { |comment| "#{comment.body.truncate(50)} - #{comment.user.username}" }
      result = displayed_comments.join("<br>") + " ... (#{comments.size - 2} more)"
    else
      result = comments.map { |comment| "#{comment.body.truncate(50)} - #{comment.user.username}" }.join("<br>")
    end
    result.html_safe
  end

  def display_follow_button(user)
    return if current_user == user

    if current_user.following?(user)
      unfollow_button = button_to "Unfollow",
        unfollow_user_path(current_user, user_id: user.id),
        method: :delete,
        remote: true,
        class: "like-button"

      content_tag(:div, unfollow_button, class: "follow-button-container", id: "follow_button_#{user.id}")
    else
      follow_button = button_to "Follow",
        follow_user_path(current_user, user_id: user.id),
        method: :post,
        remote: true,
        class: "like-button"

      content_tag(:div, follow_button, class: "follow-button-container", id: "follow_button_#{user.id}")
    end
  end
end
