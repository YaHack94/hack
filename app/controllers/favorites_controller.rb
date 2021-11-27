class FavoritesController < ApplicationController
    def create
        favorite = current_user.favorites.create(publication_id: params[:publication_id])
        redirect_to publication_path(favorite.publication), notice: "Publication ajoutée aux favories"
      end
      def destroy
        favorite = current_user.favorites.find_by(id: params[:id]).destroy
        redirect_to publication_path(favorite.publication), notice: "Publication supprimée des favories"
      end
end
