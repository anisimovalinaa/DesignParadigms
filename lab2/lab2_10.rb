def read_str
	str = ''
	File.open('file.txt') { |io| str = io.read().chomp }
	str
end

def task str
	str.scan(/\s(?:[0-3]?[\d]) (?:декабря|января|февраля|марта|апреля|мая|июня|июля|августа|сентября|октября|ноября) (?:[\d]{1,4}\s?)/)
end

str = read_str

puts "#{task str}"