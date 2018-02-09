module EveApp
  class Character

    attr_accessor :name, :id, :skills, :portrait
    attr_reader :access_token

    def initialize(character_id)
      raise("Cannot initialize Character with a null ID") unless character_id
      @id = character_id
      populate_basic_character_info
      populate_skils
    end

    def populate_basic_character_info
      character_info = EveClient::Characters.get_basic_info(@id)
      @name = character_info['name']
      @portrait = "https://imageserver.eveonline.com/Character/#{@id}_128.jpg"
    end

    def populate_skils
      @skills = EveClient::Characters.get_skills(@id)
      #
      # response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/", {Authorization: "Bearer #{@access_token}"})
      #
      # categories = JSON(response.body)
      #
      # response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/16/", {Authorization: "Bearer #{@access_token}"})
      # puts JSON(response.body)['groups']
      #
      #
      #
      # skill_groups = %w(255
      # 256
      # 257
      # 258
      # 266
      # 268
      # 269
      # 270
      # 272
      # 273
      # 274
      # 275
      # 278
      # 505
      # 1209
      # 1210
      # 1213
      # 1216
      # 1217
      # 1218
      # 1220
      # 1240
      # 1241
      # 1545)
      #
      # types =[]
      # skill_groups.each do |group_id|
      # response = RestClient.get("https://esi.tech.ccp.is/latest/universe/groups/#{group_id}/", {Authorization: "Bearer #{@access_token}"})
      #  types << JSON(response.body)['types']
      # end
      #
      # skill_names = []
      # types.flatten.each do |type_id|
      #   response = RestClient.get("https://esi.tech.ccp.is/latest/universe/types/#{type_id}/", {Authorization: "Bearer #{@access_token}"})
      #   skill_names << JSON(response.body)['name']
      # end
      #
      # puts skill_names

    end
  end
end