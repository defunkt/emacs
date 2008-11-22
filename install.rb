# this is not the ruby you're looking for
require 'fileutils'

alias :V :lambda

Joiner = V do |base|
  V do |*others|
    File.join(base, *others)
  end
end

Dir  = File.dirname( __FILE__ )
Home = Joiner[ File.expand_path( '~' ) ]
Cwd  = Joiner[ Dir ]

Link = V do |target, new|
  FileUtils.ln_s Cwd[ target ], Home[ new ] rescue puts("~/#{new} exists.")
end

Link[ 'emacs.el', '.emacs' ]
Link[ '.',  '.emacs.d' ]

Git = V do |command|
  `git --git-dir=#{Dir}/.git #{command}`
end

Git[ 'submodule init' ]
Git[ 'submodule update' ]
