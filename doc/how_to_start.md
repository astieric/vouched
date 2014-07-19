How to start
===========================

Take a deep breath :)

1. Install RVM (http://rvm.beginrescueend.com/): 

    gem install rvm

2. Install JRuby in RVM: 

    rvm install jruby
  
3. Switch to JRuby 

    rvm use jruby

4. Install bundler (1.0.0.beta):

    gem install bundler --pre
 
5. Install neo4jr-social

    gem install neo4jr-social
  
6. Get stuff from Git

    git clone <repo>
  
7. Cd to the directory with project, run: 

    bundle install

8. start solr / neo4jr:

    start-neo4jr-social -p8988
    rake sunspot:solr:run
  
9. Run 

    script/rails server