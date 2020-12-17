module Spoonacular
    class Api < Base

    MAX_LIMIT = 10
    CACHE_DEFAULTS = { expires_in: 3.days, force: false }

    def self.info_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = MovieRequest.where("title/get-overview-details?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def self.cast_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = MovieRequest.where("title/get-top-cast?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def self.crew_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = MovieRequest.where("title/get-top-crew?tconst=", cache, query)
        [ results, response[:errors] ]
    end

    def self.person_search(query, clear_cache)
        cache = CACHE_DEFAULTS.merge({ force: clear_cache })
        results = MovieRequest.where("actors/get-bio?nconst=", cache, query)
        [ results, response[:errors] ]
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