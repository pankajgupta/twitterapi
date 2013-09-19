twitterapi
==========

A simple ruby script to programmatically use Twitter API (version 1.1) using simple oauth. At this time, only one API method is present (to lookup users by their ids), but more API methods are coming.

## Set up

First, you need to set up your oauth credentials. My ~/oauth_credentials.yml file looks like this.

```
:consumer_key: .......
:consumer_secret: .........
:token: ........
:token_secret: ...................
```

You can get the consumer_key and consumer_secret from following instructions on the [Twiter dev site](https://dev.twitter.com/docs/auth/tokens-devtwittercom). If you don't have any application already, you will need to create a new dummy app in order to get consumer key and secret.

Then do ```bundle install``` to install the required gems. If you don't have bundler, simply install using ```gem install bundler```. Look at the [bundler site](http://bundler.io/) for more details.

## Usage

Examples:
```
bundle exec twitterapi.rb -c lookup_ids -u 12,20
bundle exec twitterapi.rb -c lookup_ids -u 13
```
etc.

## References
1. [Twitter API v1.1](https://dev.twitter.com/docs/api/1.1)
2. [Twitter API Authentication](https://dev.twitter.com/docs/auth/tokens-devtwittercom)
3. [Bundler](http://bundler.io/)

