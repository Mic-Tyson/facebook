module ApplicationHelper
  def display_card_comments(comments)
    if comments.size > 2
      displayed_comments = comments.first(2).map { |comment| "#{comment.body.truncate(50)} - #{comment.user.username}" }
      result = displayed_comments.join("<br>") + "<br>" " ... (#{comments.size - 2} more)"
    else
      result = comments.map { |comment| "#{comment.body.truncate(50)} - #{comment.user.username}" }.join("<br>")
    end
    result.html_safe
  end

  def display_follow_button(user)
    return if user == current_user

    action, path, method = determine_follow_action(user)
    button = button_to(action, path, method: method, remote: true, class: "like-button")

    content_tag(:div, button, class: "follow-button-container", id: "follow_button_#{user.id}")
  end

  def delete_follower_button(user)
    return nil if user == current_user || !user.following?(current_user)

    action = "Remove"
    path = remove_follower_user_path(user)

    button = button_to(action, path, method: :delete, class: "unfollow-button")

    content_tag(:div, button, class: "follow-button-container", id: "remove_follow_button_#{user.id}")
  end

  def accept_request_button(user)
    path = accept_follow_request_user_path(user)

    button = button_to("Accept", path, method: :post, class: "accept-request-button")

    content_tag(:div, button, class: "request-button-container", id: "accept_request_button_#{user.id}")
  end

  def deny_request_button(user)
    path = deny_follow_request_user_path(user)

    button = button_to("Deny", path, method: :delete, class: "deny-request-button")

    content_tag(:div, button, class: "request-button-container", id: "deny_request_button_#{user.id}")
  end


  private

  def determine_follow_action(user)
    if current_user.requesting?(user)
      [ "Unrequest", unrequest_follow_user_path(user), :delete ]
    elsif current_user.following?(user)
      [ "Unfollow", unfollow_user_path(user), :delete ]
    else
      [ "Request", request_follow_user_path(user), :post ]
    end
  end
end
