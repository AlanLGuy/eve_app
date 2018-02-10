module EveClient
  class Characters < ESI

    class << self

      def get_basic_info(character_id)
        get("/characters/#{character_id}/")
      end

      def get_skills(character_id)
        get("/characters/#{character_id}/skills/")
      end

      def get_agent_research(character_id)
        get("/characters/#{character_id}/agent_research/")
      end

      def get_blueprints(character_id)
        get("/characters/#{character_id}/blueprints/")
      end

      def get_chat_channels(character_id)
        get("/characters/#{character_id}/chat_channels/")
      end

      def get_corporation_history(character_id)
        get("/characters/#{character_id}/corporationhistory/")
      end

      def get_jump_fatigue(character_id)
        get("/characters/#{character_id}/fatigue/")
      end

      def get_medals(character_id)
        get("/characters/#{character_id}/medals/")
      end

      def get_notifications(character_id)
        get("/characters/#{character_id}/notifications/")
      end

      def get_contact_notifications(character_id)
        get("/characters/#{character_id}/notifications/contacts/")
      end

      def get_portrait_url(character_id)
        get("/characters/#{character_id}/portrait/")
      end

      def get_corporation_roles(character_id)
        get("/characters/#{character_id}/roles/")
      end

      def get_standings(character_id)
        get("/characters/#{character_id}/standings/")
      end

      def get_stats(character_id)
        get("/characters/#{character_id}/stats/")
      end

      def get_titles(character_id)
        get("/characters/#{character_id}/titles/")
      end

      def bulk_character_lookup(character_id_array)
        data = {character_ids: character_id_array}
        post("/characters/affiliation/", data)
      end

      def bulk_character_name_lookup(character_id_array)
        data = character_id_array.join(',')
        get("/characters/names/?character_ids=#{data}")
      end

    end
  end
end