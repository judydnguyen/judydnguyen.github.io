#!/bin/bash

CONFIG_FILE=_config.yml 

cd /srv/jekyll
rm -f Gemfile.lock
bundle install > /dev/null 2>&1

/bin/bash -c "cd /srv/jekyll && exec bundle exec jekyll serve --watch --port=8080 --host=0.0.0.0 --livereload --verbose --trace --force_polling"&

while true; do

  inotifywait -q -e modify,move,create,delete $CONFIG_FILE

  if [ $? -eq 0 ]; then
 
    echo "Change detected to $CONFIG_FILE, restarting Jekyll"

    jekyll_pid=$(pgrep -f jekyll)
    if [ ! -z "$jekyll_pid" ]; then
      kill -KILL $jekyll_pid
    fi

    /bin/bash -c "cd /srv/jekyll && exec bundle exec jekyll serve --watch --port=8080 --host=0.0.0.0 --livereload --verbose --trace --force_polling"&

  fi

done
