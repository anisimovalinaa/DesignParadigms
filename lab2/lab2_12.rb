def read_str
	list_str = []
	File.open('file.txt') { |io| list_str = io.readlines() }
	list_str
end

def task12 list_str
	list_str.sort { |a, b| a.size <=> b.size }.reverse
end

def task13 list_str
	list_str.sort { |a, b| a.split.size <=> b.split.size }
end

def task14 list_str
	list_str.sort { |a, b| a.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size <=> b.scan(/(?:[\d]) (?:[A-Za-zА-Яа-яЁё]+)/).size }
end

#номер 15
def mean_count_letters(str, letters)
	list_words = str.split()
	count = 0
	letters == 'vowel' ?
		list_words.each { |word| count += word.scan(/a|e|i|o|u|y/).size } :
		list_words.each { |word| count += word.scan(/b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|z/).size }
	count.to_f/list_words.size.to_f
end

def difference str
	(mean_count_letters(str, 'consonant') - mean_count_letters(str, 'vowel')).abs
end

def task1 list_str
	list_str.sort { |a, b| difference(a) <=> difference(b) }
end

list_str = read_str

puts "#{task1 list_str}"