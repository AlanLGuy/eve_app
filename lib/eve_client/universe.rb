module EveClient
  class Universe < ESI

    class << self

      def get_item_group_information(group_id)
        get("/universe/groups/#{group_id}/")
      end

      def get_item_type_information(type_id)
        get("/universe/types/#{type_id}/")
      end

    end
  end
end