module ArticleRecommendations
  class ReducerUrlListPerUrl < Humboldt::Reducer
    input :text, :json
    output :none, :json

    reduce do |key, values|
      result = nil
      values.each do |value|
        unless result
          result = Hash.new{|h,k| h[k] = Hash.new(0)}
          result['embed_url'] = value['embed_url']
          result['category'] = value['category']
          value['other_embed_url_list'].each do |other_embed_url|
            result['other_embed_url_list'][other_embed_url] += 1
          end
          next
        end
        value['other_embed_url_list'].each do |other_embed_url|
          result['other_embed_url_list'][other_embed_url] += 1
        end
      end
#      puts "RED2 - emitting #{result}"
      emit nil, result
    end
  end
end