class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    if @comment.save
      redirect_to book_path(@book)
    else
      @book_comment = BookComment.new
      @book_comments = @book.book_comments
      render 'books/show'
    end
  end

  def destroy
    comment = BookComment.find(params[:id])
    if comment.user == current_user
      comment.destroy
    end
    redirect_to book_path(comment.book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
