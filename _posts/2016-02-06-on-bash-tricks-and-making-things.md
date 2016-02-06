---
title: On bash tricks and making things
---

Y'all remember [Hobix](http://hobix.github.io/hobix/)?

It was a neat little static blogging tool written by Ruby's Chief Whimsy Officer
[\_why](https://en.wikipedia.org/wiki/Why_the_lucky_stiff).[^why]  I don't know
where it sits in the [pantheon](http://jekyllrb.com) [of](http://octopress.org)
[static](http://gohugo.io) blog tools, but it was the first one I'd ever seen
and friend was it _cool_.

You did everything from the command line instead of a web interface, as was the
fashion of the time.

Want a new blog post?

      $ hobix post blahhg shortName

Wanna rebuild the world?

      $ hobix upgen blahhg

Like I said: _cooooool_.

I'm using [Jekyll](http://jekyllrb.com) for this here blog, but I still wanted
a little coolness, so I wrote a script for whipping up new posts:

      $ ./scripts/new_post.sh
      Usage: ./scripts/new_post.sh "Brilliant thought piece"
      Please provide a post name.

It's just a little thing:

{% highlight bash %}

  $ cat scripts/new_post.sh
  #!/bin/bash

  POST_NAME=$1

  if [[ -z ${POST_NAME} ]]; then
    echo "Usage: ./scripts/new_post.sh \"Brilliant thought piece\""
    echo "Please provide a post name."
    exit;
  fi

  DATE=$(date +%Y-%m-%d)
  FILENAME=${DATE}-$(echo ${POST_NAME} \
    | tr '[:upper:]' '[:lower:]' \
    | sed s/[[:punct:]]//g \
    | sed s/[[:space:]]/-/g ).md

  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  FULL_PATH=${DIR}/../_posts/${FILENAME}

  cat << NEW_POST > ${FULL_PATH}
  ---
  title: ${POST_NAME}
  ---
  NEW_POST

  $EDITOR ${FULL_PATH}

{% endhighlight %}

It's real simple - it figures out the date for the file name, then takes the
title you give it and does some `tr`ing and some `sed`ing and before you know it
you've got yourself a stew.

Finally, it opens up the new file in your `$EDITOR` of choice and now you're
thoughtleadering.

> OMG bash you're so _old_ why are you so _old_

I know, I know.  It's `bash`, and only old people write bash scripts.  But I've
got a secret to tell you: _i'm awful at writing bash scripts_ (ask my
coworkers).  I started out my career as a `perl` hacker, and `perl` was always
available, so any little scripting I needed I used `perl`.

I just never learned `bash` fundamentals.

Then I started working at [UM](https://unionmetrics.com) and have had the
extreme pleasure of working with [Jerry Chen](http://twitter.com/jcsalterego).
If you'll forgive the use of an over-wrought sports metaphor, Jerry's our very
own [Steph Curry](https://en.wikipedia.org/wiki/Stephen_Curry).  He's elevated
fundamentals to genius levels.

One of the most impressive things about watching Jerry work is the effortlessness
with which he wields his tools.  He doesn't have to think about the tool - it's
an extension of him.  It's a lot like watching
[Steph](http://s1.totalprosports.com/wp-content/uploads/2014/12/stephen-curry-ankle-breaker-george-hill-stephen-curry-gifs.gif)
[Curry](https://uproxx.files.wordpress.com/2015/04/stephsmokescp3.gif?w=650)
[play](http://s1.totalprosports.com/wp-content/uploads/2014/12/curry-slick-moves-vs-spurs-stephen-curry-gifs.gif).
That mastery affords him a freedom to focus on the **_thing_**  rather than
the **_making_**.  It's an art and a fucking pleasure to watch and I'm wicked
grateful every day that I get to work with him.[^jerb]

> Bring it on back, old man

That's why I write little `bash` scripts every chance I get - I gotta get those
fundamentals up and keep them sharp by practicing every day.

Sometimes I run across folks who are new to programming and they ask me
questions like "How do I get that first programming job?" and "What should I be
learning?" and "What the hell are you babbling about old man?" (I get that one
a lot).

To them, I say practice your fundamentals.  Work them everyday until they're
second nature.  Then work them some more.  Keep working them until you don't
even have to think about it - it'll pay off, I promise.

If you wanna be as lucky as me and work with Jerry, send us an email at
[jobs@unionmetrics.com](mailto:jobs@unionmetrics.com).  We're always looking
for funny, humble, creative folks that want to make things the very best way
possible.

[^why]: Whom we all miss terribly and are so very sorry we drove away.  Our
        community is lesser without him and we should all be fucking better.

[^jerb]: There are a million reasons why I love Jerry and this one is like
         #1000000.  He's also gonna disagree with my asseessment of how good
         he is, but don't listen to him.
