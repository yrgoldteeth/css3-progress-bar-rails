## CSS3 Progress Bars for Rails

[![Travis CI Build Status](http://travis-ci.org/yrgoldteeth/css3-progress-bar-rails.png)](http://travis-ci.org/yrgoldteeth/css3-progress-bar-rails)

### Inspiration

[Josh Sullivan][js] made some very pretty [progress bars][blog] in CSS3.

[I][vanity] wrote some helper methods for Rails to generate the HTML for the progress bars.

Thought it might be useful.

### Instruction

This gem assumes you're using Rails 3.1+, including the asset pipeline.

Into the Gemfile:  
    
    gem 'css3-progress-bar-rails'

Into the application.css header:

    *= require 'css3-progress-bar'

In a view:

    <%= progress_bar(33, :color => 'blue', :rounded => true) %>  

Also, I have added support for the upcoming [Twitter Bootstrap 2][tweetin]
progress bar styling as well.  To use:

    <%= bootstrap_progress_bar(33, :color => 'info', :striped => true) %>  

[View Examples Here][examples]

### Indication

Except where indicated:  
Copyright (c) 2012 [Nicholas Fine][vanity], released under the MIT license. 

[js]: http://dipperstove.com/index.html
[blog]: http://dipperstove.com/design/css3-progress-bars.html
[vanity]: http://ndfine.com
[examples]: http://ndfine.com/2012/01/03/css3-progress-bars-for-rails.html
[tweetin]: http://markdotto.com/bs2/docs/components.html#progress
