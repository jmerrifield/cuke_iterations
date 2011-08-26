# Cuke Profiles [![Build Status](https://secure.travis-ci.org/jmerrifield/cuke_profiles.png)](http://travis-ci.org/jmerrifield/cuke_profiles)

Multiple invocations of your scenarios, without running Cucumber multiple times.

## Why would I want that?

In order to run different variations of your tests e.g.

* Different browsers/devices (run all my tests in Chrome, Firefox, iPhone simulator etc)
* Different platforms (run all my tests against a Windows installation, Linux, OS X etc)
* Some types of multi-tenant scenarios (run all my tests against the Initrode deployment, the Acme deployment etc)
* Systems which have different, configurable, modes of operation (but behave the same externally) - got a system that can optionally use MySQL, Sqlite or Oracle as the data store?

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

In your `features` folder, create a YAML file to contain your profiles.  Each one must have a set of included and excluded tags, e.g:

```yaml
iphone:
  :include_tags:
  - ! '@mobile'
  - ! '@iphone_only'
  :exclude_tags: []
android:
  :include_tags:
  - ! '@mobile'
  :exclude_tags:
  - ! '@iphone_only'
```

At present, you *must* specify all tags that are to be included.  Excluded tags have priority over included ones (e.g. an `@iphone_only` scenario would not be included in the `android` profile, even if it had the `@mobile` tag.

### Running it

`cd features`

With defaults:
`cuke_profiles`

To see other options:
`cuke_profiles -h`

### What did it do?

First, it created a set of empty directories under the `profiles` folder - one for each profile that you defined.  You should add this folder to your source-control ignore list (unless you're using Git which doesn't track empty folders).

Next, it created a run file for Cucumber.  If you didn't specify a filename it will be called `run.txt`.  Definitely add this to your source-control ignore list.

### Run Cucumber with the run file instead of a features folder

`cucumber @run.txt`

Note we haven't told Cucumber about our `features` folder like we normally would.  This also means it doesn't know about your `support` or `step_definitions` folders, so make sure to add those to the command-line as well.

### Use the profiles inside your scenarios

In `env.rb`:

```ruby
require 'cuke_profiles'
World(CukeProfiles::CucumberHelper)
```

Create a 'Before' hook:

```ruby
Before do |scenario|
  profile = current_profile(scenario)
  puts "I'm running under the '#{profile}' profile!"
end
```

### What should I do now I know which profile the scenario is running under?

You should `puts` the profile name to distinguish between instances of the scenario in the Cucumber output.

Depending upon the nature of your profiles, you might like to:

* Switch the browser driver to a device-specific one
* Change the URL you're running tests against
* Change the configuration of the system under test