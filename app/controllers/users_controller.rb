class UsersController < ApplicationController
    before_action :authenticate_user!
    def profil
        @publicat = current_user.publications.all
        @users = User.all
    end
end
