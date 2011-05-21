# Jenhub

Private Jenkin projects will not let Github hooks trigger a build, since Github is not able to authenticate itself (and for some stupid reason you must be authenticated to use a Jenkins token?). Jenhub sits in between, acting as a middle layer. It receives the Github hook and triggers the Jenkins build for the right project with some `curl` magic.

# Installation

Jenhub requires `ruby` (only tested on 1.9, but should work on 1.8 as well) and `curl`.

`git clone` this. `cd jenhub` and run `bundle` (`gem install bundler` if you don't already have it), this'll install all the gems needed to make genhub run.

    $ git clone https://github.com/firmafon/jenhub.git && cd jenhub && gem install bundler && bundle

Have a look at the configuration file `config.yml`, where you'll specify:

* Jenkins URL
* Username and password of Jenkins user available to trigger builds
* Secret token for starting builds

Run jenhub with `thin` while being in the jenhub directory:

    $ thin start

Github's post-receive URL should then point against (specify this in a Github repository's admin interface -> Service Hooks -> Post-Receive URLs):

    <jenkins url>/job/<jenkins job name>/<specified token>
    mybuilder.com/job/jenhub # example

Which'll make Jenhub issue:

    curl -u "<username>:<password>" <jenkins url>/job/<job>/build
    curl -u "sirupsen:seekrit" mybuilder.com/job/jenhub/build # example

You can easily deploy jenhub on Heroku:

    $ # change config.yml
    $ git commit -am '...'
    $ heroku create <your company>-jenhub
    $ git push heroku master
    $ # done! go put up the hook on github

# Copyright

Copyright (c) 2011 Firmafon ApS. This project is licensed under the MIT license, see LICENSE for details.
