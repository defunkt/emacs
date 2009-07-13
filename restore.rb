# 
# After a fresh clone. For defunkt.
#

File.open('local.el', 'w') do |f|
  f.puts '(load "defunkt")'
end

`git submodule update --init`
`cd vendor/rinari && git submodule update --init`
puts "Don't forget to M-x byte-compile-file js2"
