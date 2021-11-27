class LikesController < ApplicationController
    def create
        like = current_user.likes.create(publication_id: params[:publication_id])
        redirect_to publication_path(like.publication), notice: "J'aime"
      end
      def destroy
        like = current_user.likes.find_by(id: params[:id]).destroy
        redirect_to publication_path(like.publication), notice: "J'aime plus"
      end
end
