require_relative "cookbook"
require_relative "view"
require_relative "recipe"
require_relative "scrape_all_recipes_service"
require "open-uri"
require "nokogiri"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for_name
    description = @view.ask_user_for_description
    rating = @view.ask_user_for_rating
    prep_time = @view.ask_user_for_prep_time
    recipe = Recipe.new(name, description, rating, prep_time)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    index = @view.ask_user_for_index
    @cookbook.remove_recipe(index)
  end

  def search_on_all_recipes
    keyword = @view.ask_user_what_ingredient_to_search
    # use ´keyword´ to search on allrecipes
    five_recipes = ScrapeAllRecipesService.new(keyword).call
    @view.display_five_recipes(keyword, five_recipes)
    @view.ask_user_what_recipe_to_import
    index = @view.ask_user_for_index
    @view.display_chosen_recipe(five_recipes, index)
    chosen_recipe = five_recipes[index]
    @cookbook.add_recipe(chosen_recipe)
    display_recipes
  end

  def mark_as_done
    # 1. Display recipes
    display_recipes
    # 2. Ask user for an index (view)
    index = @view.ask_user_for_index
    # 3. Use given index to mark a recipe as done and save it (cookboook)
    @cookbook.mark_recipe_as_done(index)
    # 4. Display recipes
    display_recipes
  end

  private

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
