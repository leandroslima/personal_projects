class ScrapeAllRecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html_data = URI.open(url).read
    nokogiri_object = Nokogiri::HTML(html_data, nil, "utf-8")
    five_recipes = []
    nokogiri_object.search(".card__recipe").first(5).each do |card|
      name = card.search(".card__imageContainer a").first.attribute("title").value.strip
      description = card.search(".card__detailsContainer .card__summary").first.text.strip
      rating_card = card.search(".card__detailsContainer .review-star-text").first
      rating = rating_card.text.strip.match(/\d\.?\d*/)
      recipe_url = card.search(".card__imageContainer a").first.attribute("href").value.strip
      recipe_html = URI.open(recipe_url).read
      recipe_doc = Nokogiri::HTML(recipe_html, nil, "utf-8")
      prep_card = recipe_doc.search(".recipe-meta-item").find do |card|
        card.text.strip.match?(/prep/i)
      end
      prep_time = prep_card ? prep_card.text.strip.match(/prep:\s+(\w* \w*)/i)[1] : nil
      five_recipes << Recipe.new(name, description, rating, prep_time)
    end
    five_recipes
  end
end
