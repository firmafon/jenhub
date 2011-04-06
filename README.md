# Jenhub

Private Jenkin projects will not let Github hooks trigger a build, since Github is not able to authenticate itself (and for some stupid reason you must be authenticated to use a Jenkins token?). Jenhub sits in between, acting as a middle layer. It receives the Github hook and triggers the Jenkins build for the right project with some `curl` magic.

# Installation

Jenhub requires Ruby 1.9.2.

Git clone this. `cd` in and run `bundle` (`gem install bundler` if you don't already have it), this'll install all the gems needed to make genhub run.

Have a look at the configuration file `config.yml`, where you'll specify:

* Jenkins URL
* Username and password of Jenkins user available to read and trigger builds

Run genhub with `thin` while being in the directory:

`thin start`

Github's post-receive URL should then point against:

    <jenkins url>/job/<jenkins job name>
    mybuilder.com/job/jenhub # example

Which'll basically just make Jenhub issue:

    curl -u "<username>:<password>" <jenkins url>/job/<job>
    curl -u "sirupsen:seekrit" mybuilder.com/job/jenhub/build # example
