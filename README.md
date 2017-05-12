# WorkflowToHash

A tool to allow a sequence of actions in a state machine to be defined
as an array.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'workflow_to_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workflow_to_hash

## Usage

This tool has been specifically designed to work with
[Piotr Murach's FiniteMachine](https://github.com/piotrmurach/finite_machine)
but is not limited to that environment.

When building state matchines, I regularly find that state needs to move in a sequence of
steps. For example, `:one` to `:two` to `three`. In FiniteMachine, to achieve that you
can do this:

```ruby
class StateMachine < FiniteMachine::Definition
  initial :one

  events {
    event(
      :next,
      :one => :two,
      :two => :three
    )
  }
end

sm = StateMachine.new
sm.state # --> :one
sm.next
sm.state # --> :two
sm.next
sm.state # --> :three
```

That is OK, but gets a little unwieldy as the sequence grows or when you want to swap out
sequences depending on a condition.

WorkflowToHash allow me to create state sequences more easily. For example, to achieve
the above I could:

```ruby
class Workflow < WorkflowToHash::Workflow
  def forward
    [:start, :one, :two, :three]
  end

  def backward
    [:start, :three, :two, :one]
  end
end

class StateMachine < FiniteMachine::Definition
  initial :start

  events {
    event(
      :next,
      Workflow.for(:forward)
    )
  }
end

sm = StateMachine.new
sm.state # --> :start
sm.next
sm.state # --> :one
sm.next
sm.state # --> :two
sm.next
sm.state # --> :three
```

And the it allows me to build more complex state machines succinctly:

```ruby

class StateMachine < FiniteMachine::Definition
  initial :start

  events {
    event(
      :next,
      Workflow.for(:forward).merge(if: -> {target.forward})
    ),
    event(
      :next,
      Workflow.for(:backward).merge(if: -> {!target.forward)
    )
  }
end

require 'ostruct'
forward = OpenStruct.new forward: true
backward = OpenStruct.new forward: false

sm = StateMachine.new
sm.target forward
sm.state # --> :start
sm.next
sm.state # --> :one
sm.next
sm.state # --> :two
sm.next
sm.state # --> :three

sm = StateMachine.new
sm.target backward
sm.state # --> :start
sm.next
sm.state # --> :three
sm.next
sm.state # --> :two
sm.next
sm.state # --> :one
```

## Development

Run `rake test` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/reggieb/workflow_to_hash.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

