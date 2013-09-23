require 'minitest/autorun'
require 'nokogiri'
require 'action_view'
require './app/helpers/css3_progress_bars_helper'
include ActionView::Helpers
include ActionView::Context
include Css3ProgressBarsHelper

describe Css3ProgressBarsHelper do
  describe '#bootstrap_progress_bar' do
    describe 'with the color option' do
      describe 'using an invalid color option' do
        it 'does not set a color class in container div' do
          Nokogiri::HTML(bootstrap_progress_bar(33, color: 'foo')).search('div.progress').first.attributes["class"].wont_match /progress-foo/
        end
      end

      describe 'using a valid color option' do
        it 'sets the correct class in container div' do
          Nokogiri::HTML(bootstrap_progress_bar(33, color: 'info')).search('div.progress-bar').first.attributes["class"].must_match /progress-bar-info/
        end
      end

      describe 'using a valid color with option and twitter bootstrap 2' do
        it 'sets the correct class in container div using twitter bootstrap 2' do
          Nokogiri::HTML(bootstrap_progress_bar(33, bootstrap: 2, color: 'info')).search('div.progress').first.attributes["class"].must_match /progress-info/
        end
      end
    end

    describe 'with the striped option' do
      it 'sets the correct class in container div' do
        Nokogiri::HTML(bootstrap_progress_bar(33, striped: true)).search('div.progress').first.attributes["class"].must_match /progress-striped/
      end
    end

    describe 'with the striped option using twitter bootstrap 2' do
      it 'sets the correct class in container div using twitter bootstrap 2' do
        Nokogiri::HTML(bootstrap_progress_bar(33, bootstrap: 2, striped: true)).search('div.progress').first.attributes["class"].must_match /progress-striped/
      end
    end

    describe 'with the active option' do
      it 'sets the correct class in container div' do
        Nokogiri::HTML(bootstrap_progress_bar(12, active: true)).search('div.progress').first.attributes["class"].must_match /active/
      end
    end

    describe 'with the active option using twitter bootstrap 2' do
      it 'sets the correct class in container div using twitter bootstrap 2' do
        Nokogiri::HTML(bootstrap_progress_bar(12, bootstrap: 2, active: true)).search('div.progress').first.attributes["class"].must_match /active/
      end
    end
  end

  describe '#combo_progress_bar' do
    describe 'given a collection that contains an invalid percentage value' do
      it 'raises an ArgumentError' do
        proc {combo_progress_bar([1,2,888])}.must_raise Css3ProgressBars::ComboBarError
        proc {combo_progress_bar([1,2,'99999',4,5])}.must_raise Css3ProgressBars::ComboBarError
      end
    end
    describe 'given a collection of valid percentage values' do
      describe 'with the tiny option' do
        it 'sets the correct tiny classes in the divs' do
          doc = Nokogiri::HTML(combo_progress_bar([1,2,3,4], :tiny => true))
          doc.search('div.bar_container').first.attributes["class"].value.must_match /container_tiny/
          doc.search('div.bar_mortice').first.attributes["class"].value.must_match /mortice_tiny/
          doc.search('div.progress').first.attributes["class"].value.must_match /progress_tiny/
        end
      end

      it 'ignores any values not in the first five members of the collection' do
        Nokogiri::HTML(combo_progress_bar([1,2,3,4,5,6,7])).search('div').count.must_equal 7
      end

      it 'returns the correct number of divs' do
        Nokogiri::HTML(combo_progress_bar([1,2,3,4,5])).search('div').count.must_equal 7
        Nokogiri::HTML(combo_progress_bar([1,2,3,4])).search('div').count.must_equal 6
      end
    end
  end

  describe '#progress_bar' do
    describe 'given an invalid percentage value' do
      describe 'greater than 100' do
        it 'sets the progress div width to 100' do
          Nokogiri::HTML(progress_bar(101)).search('div.progress').first.attributes["style"].value.must_equal "width: 100%;"
          Nokogiri::HTML(progress_bar(10100)).search('div.progress').first.attributes["style"].value.must_equal "width: 100%;"
        end
      end

      describe 'less than 0' do
        it 'sets the progress div width to 0' do
          Nokogiri::HTML(progress_bar(-203)).search('div.progress').first.attributes["style"].value.must_equal "width: 0%;"
        end
      end
    end
    describe 'given a valid percentage value' do
      describe 'with the color option' do
        describe 'set to an invalid color' do
          it 'sets no color classes in the divs' do
            doc = Nokogiri::HTML(progress_bar(55, :color => 'mauve'))
            doc.search('div.bar_container').first.attributes["class"].value.wont_match /mauve_container/
            doc.search('div.bar_mortice').first.attributes["class"].value.wont_match /mauve_mortice/
            doc.search('div.progress').first.attributes["class"].value.wont_match /mauve/
          end
        end

        describe 'set to a valid color' do
          it 'sets the correct color classes in the divs' do
            doc = Nokogiri::HTML(progress_bar(55, :color => 'blue'))
            doc.search('div.bar_container').first.attributes["class"].value.must_match /blue_container/
            doc.search('div.bar_mortice').first.attributes["class"].value.must_match /blue_mortice/
            doc.search('div.progress').first.attributes["class"].value.must_match /blue/
          end
        end
      end

      describe 'with the rounded option' do
        it 'sets the correct rounded classes in the divs' do
          doc = Nokogiri::HTML(progress_bar(55, :rounded => true))
          doc.search('div.bar_container').first.attributes["class"].value.must_match /rounded_bar_container/
          doc.search('div.bar_mortice').first.attributes["class"].value.must_match /rounded/
          doc.search('div.progress').first.attributes["class"].value.must_match /rounded/
        end
      end

      describe 'with the tiny option' do
        it 'sets the correct tiny classes in the divs' do
          doc = Nokogiri::HTML(progress_bar(55, :tiny => true))
          doc.search('div.bar_container').first.attributes["class"].value.must_match /container_tiny/
          doc.search('div.bar_mortice').first.attributes["class"].value.must_match /mortice_tiny/
          doc.search('div.progress').first.attributes["class"].value.must_match /progress_tiny/
        end
      end

      describe 'with no options' do
        it 'returns the correct number of divs' do
          Nokogiri::HTML(progress_bar(3)).search('div').count.must_equal 3
        end

        it 'sets the correct style in the progress div' do
          Nokogiri::HTML(progress_bar(44)).search('div.progress').first.attributes["style"].value.must_equal "width: 44%;"
          Nokogiri::HTML(progress_bar(88)).search('div.progress').first.attributes["style"].value.must_equal "width: 88%;"
        end
      end
    end
  end
end

