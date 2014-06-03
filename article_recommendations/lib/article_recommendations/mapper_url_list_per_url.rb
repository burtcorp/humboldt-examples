module ArticleRecommendations
  class MapperUrlListPerUrl < Humboldt::Mapper
    input :text, :json
    output :text, :json

    map do |key, value|
      user_id = value['user_id']
      embed_url_list = value['embed_url_list']
      category_embed_url_list = Hash.new { |h,k| h[k] = [] }

      embed_url_list.each do |url_category|
        embed_url = url_category["embed_url"]
        category = url_category["category"]

        category_embed_url_list[category] << embed_url
      end

      category_embed_url_list.each do |category, embed_url_list|
        embed_url_list.uniq.each do |embed_url|
          unless (embed_url_list - [embed_url]).empty?
            output_key = embed_url
            output_value = {
              'embed_url' => embed_url,
              'category' => category,
              'other_embed_url_list' => embed_url_list - [embed_url]
            }
#            puts "MAP2 - emitting #{output_key} / #{output_value}"
            emit output_key, output_value
          end
        end
      end
    end
  end
end
