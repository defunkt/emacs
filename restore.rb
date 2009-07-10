# 
# After a fresh clone. For defunkt.
#

File.open('local.el', 'w') do |f|
  f.puts '(load "defunkt")'
end

`git submodule update --init`
`cd vendor/rinar && git submodule update --init`
