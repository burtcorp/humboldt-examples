# encoding: utf-8

module WordCount
  class Mapper < Humboldt::Mapper
    input :long, :text
    output :text, :long

    map do |key, value|
      value.downcase.split.each do |word|
        word.gsub!(/\W/, '')
        emit(word, 1) unless word.empty?
      end
    end
  end
end
