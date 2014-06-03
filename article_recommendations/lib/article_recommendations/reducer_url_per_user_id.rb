module ArticleRecommendations
  class ReducerUrlPerUserId < Humboldt::Reducer
    input :text, :json
    output :text, :json

    reduce do |key, values|
      result = nil
      values.each do |value|
        unless result
          result = Hash.new()
          result['user_id'] = value['user_id']
          result['embed_url_list'] = [{ "embed_url" => value['embed_url'], "category" => value['category'] }]
          next
        end
        result['embed_url_list'] << { "embed_url" => value['embed_url'], "category" => value['category'] }
      end
#      puts "RED1 - emitting #{key} / #{result}"
      emit key, result
    end
  end
end