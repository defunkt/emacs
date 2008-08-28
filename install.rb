# this is not the ruby you're looking for
require 'fileutils'

Joiner = lambda do |base|
  lambda do |*others|
    File.join(base, *others)
  end
end

Dir  = File.dirname( __FILE__ )
Home = Joiner[ File.expand_path( '~' ) ]
Cwd  = Joiner[ Dir ]

Link = lambda do |target, new|
  FileUtils.ln_s Cwd[ target ], Home[ new ] rescue puts("~/#{new} exists.")
end

Link[ 'emacs.el', '.emacs' ]
Link[ 'emacs.d',  '.emacs.d' ]

Git = lambda do |command|
  `git --git-dir=#{Dir}/.git #{command}`
end

Git[ 'submodule init' ]
Git[ 'submodule update' ]
