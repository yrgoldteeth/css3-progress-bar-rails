## CSS3 Progress Bars for Rails

### Instruction

This gem assumes you're using Rails 3.1+, including the asset pipeline.

Into the Gemfile:

    gem 'css3-progress-bar-rails'

Into the application.css header:

    *= require 'css3-progress-bar'

In a view:

    <%= progress_bar(33, :color => 'blue', :rounded => true) %>

Twitter Bootstrap Flavored (may not fully work with current version)

    <%= bootstrap_progress_bar(33, :color => 'info', :striped => true) %>

### Indication

Except where indicated:
Copyright (c) 2017 [Nicholas Fine][vanity], released under the MIT license.

[vanity]: https://twitter.com/yrgoldteeth
