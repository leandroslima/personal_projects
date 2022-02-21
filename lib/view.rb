class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      mark = recipe.done? ? "[X]" : "[]"
      puts "#{index + 1}. #{mark} #{recipe.name}: #{recipe.description} - #{recipe.prep_time} (#{recipe.rating}/5)"
    end
  end

  def ask_user_for_name
    puts "What´s the name of the recipe?"
    gets.chomp
  end

  def ask_user_for_description
    puts "Please describe the recipe"
    gets.chomp
  end

  def ask_user_for_rating
    puts "Please give a rating from 1 to 5 to the recipe"
    rating = gets.chomp.to_i
    while rating < 1 || rating > 5
      puts "Invalid rating. Please give a rating from 1 to 5 to the recipe"
      rating = gets.chomp.to_i
    end
    rating
  end

  def ask_user_for_prep_time
    puts "What´s the preparation time?"
    gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    gets.chomp.to_i - 1
  end

  def ask_user_what_ingredient_to_search
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end

  def display_five_recipes(keyword, five_recipes)
    puts "Looking for \"#{keyword}\" recipes on the Internet..."
    five_recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
    end
  end

  def ask_user_what_recipe_to_import
    puts "Which recipe would you like to import? (enter index)"
  end

  def display_chosen_recipe(five_recipes, index)
    puts "Importing \"#{five_recipes[index].name}\"..."
  end
end
