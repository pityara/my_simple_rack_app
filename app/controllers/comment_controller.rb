class CommentController < Controller
  def create(params)
    Comment.create(params)
    comment = Comment.last
    "<b>" + comment.author + "</b>" + " : " + comment.text
  end
end
