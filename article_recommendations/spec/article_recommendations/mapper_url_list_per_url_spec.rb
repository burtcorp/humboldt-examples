require 'spec_helper'

module ArticleRecommendations
  describe MapperUrlListPerUrl do
    let :mapper do
      MapperUrlListPerUrl.new
    end
    
    let :standard_input do 
      [
        [
          "UID1", { 
            "user_id" => "UID1", 
            "embed_url_list" => [
              { "embed_url" => "http://site.com/cat1/url1", "category" => "cat1" },
              { "embed_url" => "http://site.com/cat1/url1", "category" => "cat1" },
              { "embed_url" => "http://site.com/cat1/url2", "category" => "cat1" },
              { "embed_url" => "http://site.com/cat3/url3", "category" => "cat3" }
            ] 
          }
        ],
        [
          "UID2", { 
            "user_id" => "UID2", 
            "embed_url_list" => [
              { "embed_url" => "http://site.com/cat3/url3", "category" => "cat3" },
              { "embed_url" => "http://site.com/cat3/url4", "category" => "cat3" }
            ] 
          }
        ]
      ]
    end

    let :standard_output do 
      [
        [ 
          "http://site.com/cat1/url1", {
            "embed_url" => "http://site.com/cat1/url1",
            "category" => "cat1", 
            "other_embed_url_list" => [
              "http://site.com/cat1/url2"
            ] 
          } 
        ],
        [ 
          "http://site.com/cat1/url2", {
            "embed_url" => "http://site.com/cat1/url2",
            "category" => "cat1",
            "other_embed_url_list" => [
              "http://site.com/cat1/url1",
              "http://site.com/cat1/url1"
            ] 
          } 
        ],
        [ 
          "http://site.com/cat3/url3", {
            "embed_url" => "http://site.com/cat3/url3",
            "category" => "cat3", 
            "other_embed_url_list" => [
              "http://site.com/cat3/url4"
            ] 
          } 
        ],
        [ 
          "http://site.com/cat3/url4", {
            "embed_url" => "http://site.com/cat3/url4",
            "category" => "cat3", 
            "other_embed_url_list" => [
              "http://site.com/cat3/url3"
            ] 
          } 
        ]
      ] 
    end

    it 'makes sure standard input and output is matched' do
      expect( run_mapper(mapper, *standard_input) ).to eq (standard_output)
    end
  end
end
