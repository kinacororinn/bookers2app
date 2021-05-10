class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = @book.id
    comment.save
    @book_comments = @book.book_comments
    @book_comment = BookComment.new
    #render 'create.js.erb'
  end

  def destroy
    @book_comment = BookComment.find_by(id: params[:id])
    @book = @book_comment.book
    @book_comment.destroy
    @book_comments = @book.book_comments
    #render 'destroy.js.erb'
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:book_comment)
  end

end
