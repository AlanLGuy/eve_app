module EveApp
  class Character

    attr_accessor :name, :id, :skills, :portrait, :blueprints, :character_info

    def initialize(character_id)
      raise("Cannot initialize Character with a null ID") unless character_id
      @id = character_id
      populate_basic_character_info
      populate_skills
      populate_blueprints
    end

    def populate_basic_character_info
      unless @character_info
        @character_info = EveClient::Characters.get_basic_info(@id)
        @portrait = EveClient::Characters.get_portrait_url(@id)['px128x128']
        @name = @character_info['name']
      end
    end

    def populate_blueprints
      unless @blueprints
        char_blueprints = EveClient::Characters.get_blueprints(@id)
        blueprints = Blueprint.all({type_id: char_blueprints.map {|blueprint| blueprint['type_id'].to_i}})

        @blueprints = blueprints.map do |blueprint|
          blueprint.name
        end
      end
    end

    def populate_skills
      unless @skills
        character_skills = EveClient::Characters.get_skills(@id)
        skills = Skill.all({type_id: character_skills['skills'].map {|skill| skill['skill_id'].to_i}})

        @skills = skills.map do |blueprint|
          blueprint.name
        end
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