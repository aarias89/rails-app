module ArticlesHelper

 # this method will only show comments that are comming from db, not new comments
  def persistent_comments(comments)
    comments.reject{ |comment| comment.new_record?}
  end


end
