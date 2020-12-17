module Spoonacular
    class Movie < Base
        attr_accessor :name,
                    :length,
                    :plot,
                    :poster_url,
                    :summary,
                    :imdb_link,

    MAX_LIMIT = 10
    CACHE_DEFAULTS = { expires_in: 3.days, force: false }

    def self.search(query = {}, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        response = MovieRequest.where("title/auto-complete?q=", cache, query)
        movies = response.fetch('d', []).map { |movie| movie.key?["l"] ? ["l"] : '', movie.key?["id"] ? ["id"] : '', movie.key?("i") ? ["i"]["imageUrl"] : ''}
        [ movies, response[:errors] ]
    end

      def self.find(id)
        response = MovieRequest.get("recipes/#{id}/information", CACHE_DEFAULTS)
        Recipe.new(response)
      end
  
      def initialize(args = {})
        super(args)
        self.ingredients = parse_ingredients(args)
        self.instructions = parse_instructions(args)
      end
  
      def parse_ingredients(args = {})
        args.fetch("extendedIngredients", []).map { |ingredient| Ingredient.new(ingredient) }
      end
  
      def parse_instructions(args = {})
        instructions = args.fetch("analyzedInstructions", [])
        if instructions.present?
          steps = instructions.first.fetch("steps", [])
          steps.map { |instruction| Instruction.new(instruction) }
        else
          []
        end
      end
    end
  end