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
end
