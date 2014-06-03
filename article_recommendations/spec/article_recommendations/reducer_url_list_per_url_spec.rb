require 'spec_helper'

module ArticleRecommendations
  describe ReducerUrlListPerUrl do
    let :reducer do
      ReducerUrlListPerUrl.new
    end
    
    let :standard_input do 
      [
        [
          "http://site.com/cat1/url1", [
            {
              "embed_url" => "http://site.com/cat1/url1",
              "category" => "cat1",
              "other_embed_url_list" => [
                "http://site.com/cat1/url2"
              ] 
            },
            {
              "embed_url" => "http://site.com/cat1/url1", 
              "category" => "cat1", 
              "other_embed_url_list" => [
                "http://site.com/cat1/url2",
                "http://site.com/cat1/url3"
              ] 
            } 
          ]
        ],
        [ 
          "http://site.com/cat2/url2", [
            "embed_url" => "http://site.com/cat2/url2",
            "category" => "cat2",
            "other_embed_url_list" => [
              "http://site.com/cat2/url1",
              "http://site.com/cat2/url1",
              "http://site.com/cat2/url3"
            ] 
          ]
        ]
      ] 
    end

    let :standard_output do 
      [
        [
          nil, {
            "embed_url" => "http://site.com/cat1/url1",
            "category" => "cat1",
            "other_embed_url_list" => {
              "http://site.com/cat1/url2" => 2,
              "http://site.com/cat1/url3" => 1
            }
          }
        ],
        [
          nil, {
            "embed_url" => "http://site.com/cat2/url2",
            "category" => "cat2",
            "other_embed_url_list" => {
              "http://site.com/cat2/url1" => 2,
              "http://site.com/cat2/url3" => 1
            }
          }
        ]
      ]
    end
    
    it 'makes sure standard input and output is matched' do
      expect( run_reducer(reducer, *standard_input) ).to eq (standard_output)
    end
  end
end
