require "csv"
require_relative "recipe"

class Cookbook
  def initialize(filepath)
    @recipes = []
    @filepath = filepath
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def mark_recipe_as_done(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@filepath) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
     end
  end

  def save_to_csv
    CSV.open(@filepath, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time]
      end
    end
  end
end
