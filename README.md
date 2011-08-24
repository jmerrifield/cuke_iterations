# Cuke Profiles [![Build Status](https://secure.travis-ci.org/jmerrifield/cuke_profiles.png)](http://travis-ci.org/jmerrifield/cuke_profiles)

Multiple invocations of your scenarios, without running Cucumber multiple times.

## Why would I want that?

In order to run different variations of your tests e.g.
* Different browsers/devices (run all my tests in Chrome, Firefox, iPhone simulator etc)
* Different platforms (run all my tests against a Windows installation, Linux, OS X etc)
* Some types of multi-tenant scenarios (run all my tests against the Initrode deployment, the Acme deployment etc)

## Surely there's some way of doing that already?

The only way of 'iterating' over a scenario in Cucumber is to provide it with example rows.  You certainly don't want a table of 'devices' under every single scenario.

## Damn right.  I can just call Cucumber multiple times from a Rake script though!

Absolutely.  It's not without diadvantages though:

* Rake will naturally stop after the first failed command, so you have to code around that fact to have Rake ignore the cucumber failures, and fail at the end if any of the Cucumber runs had failures.
* No aggregation of results - you have to write your own result aggregation code to get an overall view of how all the variations of your tests did.
* When your Cucumber suite gets quite large, it can take a significant chunk of time for Cucumber to run your `env.rb` code, and load up all your support and feature files.  That overhead, multiplied by the number of variations, can really add up.

## So how does this gem work?

It's very simple.  Cucumber can accept a file specifying a list of exact scenarios to run, in the format `filename:line_number`.  This is used to re-run failed scenarios, usually in conjunction with the RerunFormatter.  This gem takes advantage of that, to send Cucumber a long list of all your scenarios, repeated for each profile.

## How do I use it?

First, install the gem: `gem install cuke_profiles`

### Configuration - profiles.yml

### Running it

### Pass the generated file to Cucumber

### Use the profiles inside your scenarios
