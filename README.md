# Dashous [![CircleCI](https://circleci.com/gh/brettclanton001/Dashous.svg?style=svg)](https://circleci.com/gh/brettclanton001/Dashous)
[Dashous.com](https://dashous.com)

Connect with other members of the Dash community to trade for Dash.

# This Repository
Reading further is not needed if you want to use the dashous service.
Simply go to [Dashous.com](https://dashous.com) to get started.

This repo exists for three main reasons:

1. **Transparency**: I want to support the open source community and operate
   a service without user concerns about how I use their data.
1. **Community Contribution**: I want members of the community to help build
   the features that they desire.
1. **Supporting Altcoins**: This repo can be cloned and used for other
   Altcoins with minimal changes.

# Creating an "Issue"

If you have a feature to request or a bug to report, [create a new issue](https://github.com/brettclanton001/Dashous/issues/new).

Check [some of the issues that I created](https://github.com/brettclanton001/Dashous/issues?utf8=%E2%9C%93&q=is%3Aissue%20author%3Abrettclanton001%20) for a guide in formatting.

# Contributing
It's expected that contributors have a solid understanding of how Ruby
on Rails apps work.

I also use Postgres locally. If you're unfamiliar/rusty with PG setup, I find [GoRails.com](https://gorails.com/setup) to be a high-quality resource for setup steps.

### Configure:

Copy the development config file to enable it.
```
cp config/settings/development.local.yml.example config/settings/development.local.yml
```

Create an account at [mailtrap.io](https://mailtrap.io) and add the
user/pass details that mailtrap provides for your mailbox in the new
development.local.yml file.

config/settings/development.local.yml
```
smtp_config:
  user_name: PROVIDED_USERNAME
  password: PROVIDED_PASSWORD
  address: mailtrap.io
  domain: mailtrap.io
  port: 2525
  authentication: cram_md5
```

[Get a Google Maps Embed API
Key](https://developers.google.com/maps/documentation/javascript/get-api-key#key)
Just register with google, get a key, and enter it in.

config/settings/development.local.yml
```
google_maps_embed:
  key: GOOGLE_EMBED_KEY
```

### Setup App:

1. Install Docker Desktop
1. Set it up `docker-compose build`
1. Run everything `docker-compose up`
1. View local app [localhost:3000](http://localhost:3000)


### Run specs:
[I maintain 100% spec coverage](https://github.com/brettclanton001/Dashous/blob/master/coverage/.last_run.json)
on this app and will not accept PRs that diminish the test coverage.

To run specs:
1. Mount app `docker-compose run app /bin/bash`
1. Run tests `xvfb-run -a bundle exec rspec`

You should see output like this (number of examples will increase over
time):
```
root@902f13892bde:/myapp# xvfb-run -a bundle exec rspec
..............................................................................................................................

Finished in 31.3 seconds (files took 2.25 seconds to load)
126 examples, 0 failures

Coverage report generated for RSpec to /myapp/coverage. 2281 / 2281 LOC (100.0%) covered.
```

### Submit Pull Request:
For right now, I don't have any formality to PRs.  I'll
consider any that are created.  I might add more specific requirements
later.

# Donations

Donation Address: [Donation Page](https://dashous.com/donate)

Donation Instructions: [video](https://www.youtube.com/watch?v=I-BYzaDwNoE)

