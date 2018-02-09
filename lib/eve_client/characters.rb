  module EveClient
    class Characters < ESI

      class << self

        def get_stats(character_id)
          get("/characters/#{character_id}/stats")
        end

        def get_basic_info(character_id)
          get("/characters/#{character_id}/")
        end

        def get_skills(character_id)
          get("/characters/#{character_id}/skills")
        end

      end
    end
  end
