require 'minitest/autorun'
require 'nokogiri'
require 'action_view'
require './app/helpers/css3_progress_bars_helper'
include ActionView::Helpers
include Css3ProgressBarsHelper

describe Css3ProgressBarsHelper do
  describe '#progress_bar' do
    describe 'given a percentage value' do
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
          Nokogiri::HTML(progress_bar(3)).search('div').count.must_be :==, 3
        end

        it 'sets the correct style in the progress div' do
          Nokogiri::HTML(progress_bar(44)).search('div.progress').first.attributes["style"].value.must_be :==, "width: 44%;"
          Nokogiri::HTML(progress_bar(88)).search('div.progress').first.attributes["style"].value.must_be :==, "width: 88%;"
        end
      end
    end
  end
end

