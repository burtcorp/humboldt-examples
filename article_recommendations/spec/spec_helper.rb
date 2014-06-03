# encoding: utf-8

IO.foreach(File.expand_path('../../.classpath', __FILE__)) { |path| Dir[path.chomp].each { |p| $CLASSPATH << p } }

HADOOP_BIN = File.expand_path("../../tmp/hadoop-current/bin", __FILE__)

require 'json'
require 'tmpdir'
require 'humboldt/rspec'
require 'article_recommendations'
