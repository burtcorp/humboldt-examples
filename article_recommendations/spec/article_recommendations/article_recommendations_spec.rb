# encoding: utf-8

require 'spec_helper'

describe 'Check output' do
  ROOT_DIR = File.expand_path('../../..', __FILE__)
  DATA_DIR = File.join(ROOT_DIR, 'spec/data')
  INPUT_DIR = 'input' # relates to DATA_DIR by Hadoop
  OUTPUT_DIR = File.join(DATA_DIR, 'output')
  INTERMEDIATE_DIR = File.join(ROOT_DIR, 'data/intermediate/url_list_per_user_id')


  before :all do
    FileUtils.rm_rf OUTPUT_DIR
    FileUtils.rm_rf INTERMEDIATE_DIR

    Dir.chdir(ROOT_DIR) do
      cmd = %[bundle exec humboldt run-local --cleanup-before --data-path=#{DATA_DIR} --input=#{INPUT_DIR} --output=#{OUTPUT_DIR}]
      success = system cmd
      raise "cmd failed: #{cmd}" unless success
    end
  end

  describe 'url list per url' do
    let :url_list_per_url do
      files = Dir.chdir(OUTPUT_DIR) do
        Dir['part*']
      end
      files.sort.map { |f| File.readlines(File.join(OUTPUT_DIR, f)).map { |line| JSON.parse(line) } }
    end
  end
end

