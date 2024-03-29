= ruby-debug-base for JRuby

== Overview

(j)ruby-debug-base provides the fast debugger extension for JRuby interpreter.
It is the same as ruby-debug-base native C extension from ruby-debug project
(http://rubyforge.org/projects/ruby-debug/), but for JRuby.

== Install

(j)ruby-debug-base is available as a RubyGem. Unfortunately it is still not
installable remotely. But installation is easy enough:

- manually download the ruby-debug-base-0.10.3-java.gem to local directory from
  here: http://rubyforge.org/frs/?group_id=3085 

- install the Gem into your JRuby Gem repository:

   jruby -S gem install ruby-debug-base-0.10.3-java.gem

- now install ruby-debug with:

   jruby -S gem install --ignore-dependencies ruby-debug 

See also: http://wiki.jruby.org/wiki/Using_the_JRuby_Debugger

== Installation of trunk version

Handy for developers or users living on the cutting-edge.

$ cd ~/tmp
$ svn co svn://rubyforge.org/var/svn/debug-commons/jruby-debug/trunk jruby-debug
$ cd jruby-debug
$ rake gem
$ jruby -S gem install -l pkg/ruby-debug-base-0.10.3-java.gem 
$ jruby -S gem install columnize
$ jruby -S gem install -r ruby-debug -v 0.10.3 --ignore-dependencies

== Usage

The usage is then the same as with native ruby-debugger, but you might need to
force JRuby which has to run in interpreted mode. Simplest usage is:

  $ jruby --debug -S rdebug <your-script>

Or easier, you might create 'jruby-dm' ('dm' for 'debugger-mode'):

  $ cat ~/bin/jruby-dm
  #!/bin/bash
  jruby --debug "$@"

Then you may run just as you used to:

  $ jruby-dm -S rdebug <your-script>

For more information see: http://bashdb.sourceforge.net/ruby-debug.html

== License

See MIT-LICENSE for license information.
