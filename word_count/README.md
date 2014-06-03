# Word Count

Counts the frequencies of words in a text. Based on the
[Rubydoop example project](https://github.com/iconara/rubydoop/tree/master/examples/word_count/lib/word_count).

## Setup

* Clone this repo
* Enter this directory
* Run `bundle`
* Run `rake setup`

## Run it

Run `humboldt run-local --data-path=data --input=input/lorem.txt`.
Once Hadoop has finished, see the results using `cat
data/output/part-r-00000`.
