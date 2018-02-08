class Character

  attr_accessor :name, :id, :skills, :portrait
  attr_reader :access_token

  def initialize(access_token)

    @access_token = access_token
    response = RestClient.get('https://login.eveonline.com/oauth/verify', {Authorization: "Bearer #{@access_token}"})

    if response.code == 200
      @id = JSON(response.body)["CharacterID"]
    end
    populate_basic_character_info
    populate_skils
  end

  def populate_basic_character_info
    response = RestClient.get("https://esi.tech.ccp.is/latest/characters/#{@id}/", {Authorization: "Bearer #{@access_token}"})
    @portrait = "https://imageserver.eveonline.com/Character/#{@id}_128.jpg"

    if response.code == 200
      character_info = JSON(response.body)
      @name = character_info['name']
    end
  end

  def populate_skils
    response = RestClient.get("https://esi.tech.ccp.is/latest/characters/#{@id}/skills", {Authorization: "Bearer #{@access_token}"})

    if response.code == 200
      skills = JSON(response.body)
      @skills = skills
    end


    #
    # response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/", {Authorization: "Bearer #{@access_token}"})
    #
    # categories = JSON(response.body)
    #
    # response = RestClient.get("https://esi.tech.ccp.is/latest/universe/categories/16/", {Authorization: "Bearer #{@access_token}"})
    # puts JSON(response.body)['groups']
    #
    #

    skill_groups = %w(255
    256
    257
    258
    266
    268
    269
    270
    272
    273
    274
    275
    278
    505
    1209
    1210
    1213
    1216
    1217
    1218
    1220
    1240
    1241
    1545)

    types =[]
    skill_groups.each do |group_id|
    response = RestClient.get("https://esi.tech.ccp.is/latest/universe/groups/#{group_id}/", {Authorization: "Bearer #{@access_token}"})
     types << JSON(response.body)['types']
    end

    skill_names = []
    types.flatten.each do |type_id|
      response = RestClient.get("https://esi.tech.ccp.is/latest/universe/types/#{type_id}/", {Authorization: "Bearer #{@access_token}"})
      skill_names << JSON(response.body)['name']
    end

    puts skill_names

  end
end