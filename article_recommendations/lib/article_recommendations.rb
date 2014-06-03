require 'humboldt'
require 'article_recommendations/mapper_url_per_user_id'
require 'article_recommendations/reducer_url_per_user_id'
require 'article_recommendations/mapper_url_list_per_url'
require 'article_recommendations/reducer_url_list_per_url'

Rubydoop.configure do |input_paths, output_path|
  url_list_per_user_id = 'data/intermediate/url_list_per_user_id'

  job 'list urls per user id' do
    input input_paths, format: :combined_text
    set 'mapreduce.input.fileinputformat.split.maxsize', 32 * (1024 ** 2)
    output url_list_per_user_id, format: :sequence_file

    mapper ArticleRecommendations::MapperUrlPerUserId
    reducer ArticleRecommendations::ReducerUrlPerUserId

    enable_compression!
  end

  job 'other url frequency per url' do
    input url_list_per_user_id, format: :sequence_file
    output output_path

    mapper ArticleRecommendations::MapperUrlListPerUrl
    reducer ArticleRecommendations::ReducerUrlListPerUrl

    output_key Hadoop::Io::NullWritable
    output_value Hadoop::Io::Text

    enable_compression!
  end
end
