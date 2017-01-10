require 'rails_helper'

describe FavoritesController, type: :feature do
  describe "User Favorites" do 
    it "shows an error if user doesn't exist" do 
      visit '/users/44444_notauser/favorites'

      expect(page).to have_content "The page you were looking for doesn't exist."
    end
  end
end
