module ArticleRecommendations
  class MapperUrlPerUserId < Humboldt::Mapper
    input :long, :json
    output :text, :json

    map do |key, value|
      embed_url = value['embed_url'][/[^\?]+/].sub(/(\/)+$/,'') # Remove query params and trailing slash
      category = value['category']
      user_id = value['user_id']

      active_duration = value['active_duration'] ? value['active_duration'].to_i : 0

      unless active_duration < 10000
        output_key = user_id
        output_value = {
          'user_id' => user_id,
          'embed_url' => embed_url,
          'category' => category, 
          'active_duration' => active_duration
        }
#        puts "MAP1 - emitting #{output_key} / #{output_value}"
        emit output_key, output_value
      end
    end
  end
end