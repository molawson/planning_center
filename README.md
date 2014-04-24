# Planning Center

[![Build Status](https://img.shields.io/travis/molawson/planning_center.svg)](https://travis-ci.org/molawson/planning_center)
[![Code Climate](https://img.shields.io/codeclimate/github/molawson/planning_center.svg)](https://codeclimate.com/github/molawson/planning_center)
[![Code Climate Coverage](https://img.shields.io/codeclimate/coverage/github/molawson/planning_center.svg)](https://codeclimate.com/github/molawson/planning_center)

Ruby wrapper for the Planning Center Online API.

## Installation

Add this line to your application's Gemfile:

    gem 'planning_center'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install planning_center

## Usage

### Configuration

All API requests are made via an OAuth client. You'll have to register an application with Planning Center to get a consumer key and secret. Then, you can follow the normal OAuth procedures for requesting access tokens for your users.

Once you've jumped through all the OAuth hoops, you're ready to configure a client.

```ruby
client = PlanningCenter::Client.new do |c|
  c.consumer_key = 'YOUR_CONSUMER_KEY'
  c.consumer_secret = 'YOUR_CONSUMER_SECRET'
  c.access_token = 'YOUR_ACCESS_TOKEN'
  c.access_token_secret = 'YOUR_ACCESS_SECRET'
end
```

### Organization

All Planning Center API data flows through the user's organization. Since each OAuth client is tied to a user's account, you can access the organization directly from a `Client` object.

```ruby
client = PlanningCenter::Client.new do |c|
  # config details
end

client.organization # => #<PlanningCenter::Organization>
```

### Attributes

The API response body is parsed and stored as a hash in each object. You can get at the hash directly through the `#attrs` method or via a method directly.

```ruby
organization.attrs['name'] # => 'Organization Name'
organization.name # => 'Organization Name'
```

For more details about what attributes and methods are available for various objects, check out the [API docs](http://get.planningcenteronline.com/api).


### Associations

Associations between objects are setup to work seamlessly, regardless of whether the source object contains a full version of the associated object, a partial set of attributes, or only the id of the associated object.

```ruby
# Fully embedded association (no additional API request)
organization.service_types # => [#<PlanningCenter::ServiceType>, #<PlanningCenter::ServiceType>, ...]

# Partially embedded association (no immediate additional API request)
service_type.plans # => [#<PlanningCenter::Plan>, #<PlanningCenter::Plan>, ...]

# Association referenced by id (performs API request)
item.arrangement # => [#<PlanningCenter::Arrangement>, #<PlanningCenter::Arrangement>, ...]
```

### Lazily Loaded Attributes

In a few cases, an object retrieved from the API contains embedded associations that don't have their full set of attributes. For example, the `service_type` API object contains an array of `plans`, but those `plans` only have some of the more "vital" attributes.

For these kinds of associations, we initially create the associated object(s) with the partial set of attributes. That way, if you only need to access one of the attributes that's already been loaded, we won't bother making another API request.

But if you need to get at one of the attributes that isn't already loaded, all you have to do is call that method. The object knows that it can load the desired attribute from the API, so it makes that API call, updates the object's attributes, and returns the result.

```ruby
partial_plan = service_type.plans.first

# No additional API request is made because 'plan_title' was
# already present in the 'service_type' object
partial_plan.plan_title # => 'Plan Title'

# Makes an API request for the entire 'plan' object,
# updates the `attrs`, and returns the desired value
partial_plan.total_length # => 4560
```

## Contributing

1. Fork it ( http://github.com/molawson/planning_center/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
