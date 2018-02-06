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
  end


end