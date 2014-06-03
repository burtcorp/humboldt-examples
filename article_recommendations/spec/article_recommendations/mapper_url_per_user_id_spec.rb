require 'spec_helper'

module ArticleRecommendations
  describe MapperUrlPerUserId do
    let :mapper do
      MapperUrlPerUserId.new
    end
    
    let :standard_input do 
      [
        [ 0, {"user_id" => "UID1", "category" => "cat1", "embed_url" => "http://site.com/cat1/url1", "active_duration" => 123456} ],
        [ 1, {"user_id" => "UID1", "category" => "cat2", "embed_url" => "http://site.com/cat2/url2", "active_duration" => 234567} ]
      ] 
    end

    let :standard_output do 
      [
        [ "UID1", {"user_id" => "UID1", "embed_url" => "http://site.com/cat1/url1", "category" => "cat1", "active_duration" => 123456} ],
        [ "UID1", {"user_id" => "UID1", "embed_url" => "http://site.com/cat2/url2", "category" => "cat2", "active_duration" => 234567} ]
      ] 
    end

    it 'makes sure standard input and output is matched' do
      expect( run_mapper(mapper, *standard_input) ).to eq (standard_output)
    end
    
    it 'makes sure query params and trailing slashes are removed from embed_url' do
      input, output = standard_input, standard_output

      input[0].last.merge!({"embed_url" => "http://site.com/cat1/url3?a=b&c=d"}) 
      input[1].last.merge!({"embed_url" => "http://site.com/cat2/url4/"}) 

      output[0].last.merge!({"embed_url" => "http://site.com/cat1/url3"}) 
      output[1].last.merge!({"embed_url" => "http://site.com/cat2/url4"}) 

      expect( run_mapper(mapper, *input) ).to eq ( output )
    end

    it 'ignores active duration less than 10 seconds, as well as passive duration' do
      input, output = standard_input, standard_output

      input[0].last.merge!({"active_duration" => 9999, "passive_duration" => 111111111})
      input[1].last.merge!({"active_duration" => 10000})

      output[1].last.merge!({"active_duration" => 10000})
      output = output[1..-1] # Remove first element
      
      expect( run_mapper(mapper, *input) ).to eq ( output )
    end

    it 'template test case' do
      input, output = standard_input, standard_output

      input[0].last.merge!({}) 
      output[0].last.merge!({}) 

      expect( run_mapper(mapper, *input) ).to eq ( output )
    end
  end
end
