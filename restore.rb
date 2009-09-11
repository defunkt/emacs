# 
# After a fresh clone. For defunkt.
#

File.open('local.el', 'w') do |f|
  f.puts '(load "defunkt")'
end

puts "Don't forget to M-x byte-compile-file js2"
