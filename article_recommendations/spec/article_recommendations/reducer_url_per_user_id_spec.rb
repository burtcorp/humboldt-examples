require 'spec_helper'

module ArticleRecommendations
  describe ReducerUrlPerUserId do
    let :reducer do
      ReducerUrlPerUserId.new
    end
    
    let :standard_input do 
      [
        [ 
          "UID1", [ 
            { "user_id" => "UID1", "embed_url" => "http://site.com/cat1/url1", "category" => "cat1", "active_duration" => 123456 },
            { "user_id" => "UID1", "embed_url" => "http://site.com/cat1/url1", "category" => "cat1", "active_duration" => 123456 },
            { "user_id" => "UID1", "embed_url" => "http://site.com/cat2/url2", "category" => "cat2", "active_duration" => 234567 } 
          ]
        ],
        [
          "UID2", [
            { "user_id" => "UID2", "embed_url" => "http://site.com/cat1/url1", "category" => "cat1", "active_duration" => 123456 },
          ]
        ]
      ] 
    end

    let :standard_output do 
      [
        [
          "UID1", { 
            "user_id" => "UID1", 
            "embed_url_list" => [
              { "embed_url" => "http://site.com/cat1/url1", "category" => "cat1" },
              { "embed_url" => "http://site.com/cat1/url1", "category" => "cat1" },
              { "embed_url" => "http://site.com/cat2/url2", "category" => "cat2" }
            ] 
          }
        ],
        [
          "UID2", { 
            "user_id" => "UID2", 
            "embed_url_list" => [
              { "embed_url" => "http://site.com/cat1/url1", "category" => "cat1" }
            ] 
          }
        ]
      ]
    end
    
    it 'makes sure standard input and output is matched' do
      expect( run_reducer(reducer, *standard_input) ).to eq (standard_output)
    end
    
    it 'handles junk input' do
      input, output = standard_input, standard_output

      input[0].last.first.merge!({"random_junk" => "doobidoo"}) 

      expect( run_reducer(reducer, *input) ).to eq ( output )
    end

  end
end
