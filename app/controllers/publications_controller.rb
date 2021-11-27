class PublicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_publication, only: %i[ show edit update destroy ]
  
    def publication
      @publications = Publication.all
      @users = User.all
    end

    def publi
        @publicat = current_user.publications.all
        @users = User.all
    end
  
    def show 
        @comments = @publication.comments
        @comment = @publication.comments.build
        @like = current_user.likes.find_by(publication_id: @publication.id)
        @favorite = current_user.favorites.find_by(publication_id: @publication.id)
    end
  
    def new
      @publication = Publication.new
    end
  
    def edit
    end
  
    def create
      @publication = current_user.publications.build(publication_params)
      #@publication.user_id = current_user.id
      respond_to do |format|
        if @publication.save
          #PublicationMailer.published_mail(@publication).deliver
          format.html { redirect_to @publication, notice: "Publication crée avec succès." }
          format.json { render :show, status: :created, location: @publication }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @publication.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @publication.update(publication_params)
          format.html { redirect_to @publication, notice: "Publication mise à jour." }
          format.json { render :show, status: :ok, location: @publication }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @publication.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @publication.destroy
      respond_to do |format|
        format.html { redirect_to allpub_path, notice: "Publication supprimé." }
        format.json { head :no_content }
      end
    end
  
    private
    def set_publication
      @publication = Publication.find(params[:id])
    end
  
    def publication_params
      params.require(:publication).permit(:image, :image_cache, :content)
    end
end
  