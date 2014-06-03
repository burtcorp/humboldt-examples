# encoding: utf-8

module WordCount
  class Reducer < Humboldt::Reducer
    input :text, :long
    output :text, :long

    reduce do |key, values|
      total_sum = values.reduce(0) do |sum, value|
        sum + value
      end
      emit(key, total_sum)
    end
  end
end
