module Css3ProgressBarsHelper
  def progress_bar percentage, *opts
    options = opts.extract_options!

    container_classes = %w(bar_container)
    bar_classes       = %w(progress)
    mortice_classes   = %w(bar_mortice)

    if options[:rounded] && options[:rounded] == true
      container_classes << 'rounded_bar_container'
      bar_classes       << 'rounded'
      mortice_classes   << 'rounded'
    end

    if options[:color] && bar_colors.include?(options[:color])
      container_classes << "#{options[:color]}_container"
      bar_classes       << options[:color]
      mortice_classes   << "#{options[:color]}_mortice"
    end

    if options[:tiny] && options[:tiny] == true
      container_classes << 'container_tiny'
      bar_classes       << 'progress_tiny'
      mortice_classes   << 'mortice_tiny'
    end

    bar_html = bar_div(bar_classes, bar_style(percentage))
    mortice_html = mortice_div(bar_html, mortice_classes)

    content_tag :div, mortice_html, :class => container_classes.join(' ')
  end

  def combo_progress_bar *opts
    options = opts.extract_options!

    container_classes = %w(bar_container)
    bar_classes       = %w(progress)
    mortice_classes   = %w(bar_mortice)

    if options[:rounded] && options[:rounded] == true
      container_classes << 'rounded_bar_container'
      bar_classes       << 'rounded'
      mortice_classes   << 'rounded'
    end

    if options[:tiny] && options[:tiny] == true
      container_classes << 'container_tiny'
      bar_classes       << 'progress_tiny'
      mortice_classes   << 'mortice_tiny'
    end

    bars = ''
    options[:percentages][0..4].each_with_index do |p, i|
      bars += bar_div((bar_classes << bar_colors[i]), bar_style(p))
    end

    mortice_html = mortice_div(bars, mortice_classes)
    content_tag :div, mortice_html, :class => container_classes.join(' ')
  end

  protected
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
