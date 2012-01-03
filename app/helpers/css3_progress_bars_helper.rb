# Rails Helper that generates the HTML for displaying a CSS3 progress bar using
# Josh Sullivan's CSS3-Progress-bars (https://github.com/jsullivan/CSS3-Progress-bars).
module Css3ProgressBarsHelper

  # Accepts a value between 0 and 100 that represents the percentage amount displayed
  # as filled on the progress bar's div style.
  #
  # An options hash may also be passed to the method, with boolean options for
  # :rounded and :tiny.  Pass a string in the :color option from the available
  # choices of 'green', 'orange', 'pink', 'blue', and 'purple'.
  def progress_bar percentage, *opts
    validate_percentage(percentage)
    options = opts.extract_options!

    html_classes = setup_default_container_classes

    if options[:rounded] && options[:rounded] == true
      handle_rounded_classes(html_classes)
    end
    
    if options[:tiny] && options[:tiny] == true
      handle_tiny_classes(html_classes)
    end

    if options[:color] && bar_colors.include?(options[:color])
      handle_color_classes(html_classes, options[:color])
    end

    bar_html = bar_div(html_classes[:bar_classes], bar_style(percentage))
    mortice_html = mortice_div(bar_html, html_classes[:mortice_classes])

    content_tag :div, mortice_html, :class => html_classes[:container_classes].join(' ')
  end

  # Accepts an array of values between 0 and 100 to represent the combo progress
  # values.  As there is a limit to the number of colors, only the first five
  # elements of the array will be used.
  #
  # An options hash may also be passed to the method, with a boolean option available for :tiny
  def combo_progress_bar percentages, *opts
    validate_percentages(percentages[0..4])
    options = opts.extract_options!
    html_classes = setup_default_container_classes
    
    if options[:tiny] && options[:tiny] == true
      handle_tiny_classes(html_classes)
    end

    mortice_html = content_tag(:div, :class => html_classes[:mortice_classes].join(' ')) do
      percentages[0..4].each_with_index do |p, i|
        concat(bar_div((html_classes[:bar_classes] + [bar_colors[i]]), bar_style(p)))
      end
    end

    content_tag :div, mortice_html, :class => html_classes[:container_classes].join(' ')
  end

  protected

  # Yeah, if you pass a string that non-numeric, it'll validate because 'string'.to_i returns 0.
  # I can live with it.
  def validate_percentage percentage
    (0..100).to_a.include?(percentage.to_i) ? true : (raise ArgumentError, "Invalid Percentage Value")
  end

  def validate_percentages percentages
    percentages.each{|p|validate_percentage(p)}
  end

  def setup_default_container_classes
    {
      :container_classes => %w(bar_container),
      :bar_classes       => %w(progress),
      :mortice_classes   => %w(bar_mortice)
    }
  end

  def handle_color_classes html_classes, color
    html_classes[:container_classes] << "#{color}_container"
    html_classes[:bar_classes]       << color
    html_classes[:mortice_classes]   << "#{color}_mortice"
  end

  def handle_tiny_classes html_classes
    html_classes[:container_classes] << 'container_tiny'
    html_classes[:bar_classes]       << 'progress_tiny'
    html_classes[:mortice_classes]   << 'mortice_tiny'
  end

  def handle_rounded_classes html_classes
    html_classes[:container_classes] << 'rounded_bar_container'
    html_classes[:bar_classes]       << 'rounded'
    html_classes[:mortice_classes]   << 'rounded'
  end

  def bar_colors
    %w(green orange pink blue purple)
  end

  def bar_style percentage
    "width: #{percentage}%;"
  end

  def bar_div classes, style
    content_tag :div, '', :style => style, :class => classes.join(' ')
  end

  def mortice_div bar_html, classes
    content_tag :div, bar_html, :class => classes.join(' ')
  end
end
