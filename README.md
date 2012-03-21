# Guard::Puma
[![Build Status](https://secure.travis-ci.org/jc00ke/guard-puma.png)](http://travis-ci.org/jc00ke/guard-puma)
[![Dependency Status](https://gemnasium.com/jc00ke/guard-puma.png?travis)](https://gemnasium.com/jc00ke/guard-puma)

Restart Puma when some files change

## Installation

Add this line to your application's Gemfile:

    gem 'guard-puma'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guard-puma

## Usage

`guard init puma` or add the following manually to your `Guardfile`

```ruby
guard 'puma', :port => 4000 do
  watch('Gemfile.lock')
  watch(%r{^config|lib|app/.*})
end
```

## Options

* `:port` is the port number to run on (default `4000`)
* `:environment` is the environment to use (default `development`)
* `:start_on_start` will start the server when starting Guard (default `true`)
* `:force_run` kills any process that's holding open the listen port before attempting to (re)start Puma (default `false`).
* `:daemon` runs the server as a daemon, without any output to the terminal that ran `guard` (default `false`).
* `:debugger` runs the server with the debugger enabled (default `false`). Required ruby-debug gem.
* `:timeout` waits this number of seconds when restarting the Puma server before reporting there's a problem (default `20`).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request