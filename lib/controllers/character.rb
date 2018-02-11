module EveApp
  class Character

    attr_accessor :name, :id, :skills, :portrait, :portrait_small, :blueprints_, :character_info

    def initialize(character_id)
      raise("Cannot initialize Character with a null ID") unless character_id
      @id = character_id
      populate_basic_character_info
    end

    def populate_basic_character_info
      unless @character_info
        @character_info = EveClient::Characters.get_basic_info(@id)
        portrait_url = EveClient::Characters.get_portrait_url(@id)
        @portrait = portrait_url['px128x128']
        @portrait_small = portrait_url['px32x32']
        @name = @character_info['name']
      end
    end

    def blueprints
      unless @blueprints_
        char_blueprints = EveClient::Characters.get_blueprints(@id)
        @blueprints_ = char_blueprints.map {|blueprint| Blueprint.new(blueprint)}
      else
        @blueprints_
      end
    end

    def populate_skills
      unless @skills
        character_skills = EveClient::Characters.get_skills(@id)
        # skills = Skill.all({type_id: character_skills['skills'].map {|skill| skill['skill_id'].to_i}})
        #
        # @skills = skills.map do |blueprint|
        #   blueprint.name
        # end
      end
    end

    def get_agent_research
      research_data = EveClient::Characters.get_agent_research(@id)
      @current_research = []

      research_data.map do |research|
        research_hash = {}
        research_hash[:agent] = research["AgentID"] #TODO get agent name
        research_hash[:skill] = research["SkillTypeID"] #TODO get skill name
        research_hash[:start_date] = Date.parse(research["StartedAt"])
        research_hash[:points_per_day] = research["PointsPerDay"]
        research_hash[:remainder_points] = research["RemainderPoints"]
        research_hash[:current_research_points] = research_hash[:remainder_points] + research_hash[:points_per_day] * (Time.now - research_hash[:start_date])
        @current_research << research_hash
      end
    end

  end
end