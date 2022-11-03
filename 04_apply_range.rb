#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'nokogiri'

FileUtils.mkdir_p('range')

range_list_arr = File.read('range_list.txt').split("\n")
range_list_arr.map! do |line|
  line.split(',').map do |s|
    s = s.strip.sub('U+', '')
    if s.include?('-')
      from, to = s.split('-').map {|e| e.to_i(16)}
      (from..to)
    else
      code = s.to_i(16)
      (code..code)
    end
  end
end

Dir.glob('cmap/*.ttx') do |file|
  ttx = Nokogiri.XML(File.read(file))
  codes = ttx.xpath('/ttFont/cmap/*[@platformID="0"]/map').map do |e|
    e.attributes['code'].value.sub('0x', '').to_i(16)
  end
  codes.uniq!
  codes.sort!

  apply_list = range_list_arr.map do |range_list|
    range_list.flat_map {|range| range.filter_map {|c| c if codes.include?(c)}}
  end

  remaining_codes = codes - apply_list.flatten
  remaining_codes_map = {}
  remaining_codes.each do |e|
    remaining_codes_map[e / 0x1000] ||= []
    remaining_codes_map[e / 0x1000] << e
  end

  apply_list += remaining_codes_map.values
  apply_list.reject!(&:empty?)
  apply_list.each(&:sort!)

  apply_list.map! do |codes|
    codes.each_with_object([]) do |e, a|
      case a[-1]
      when nil
        a << e
      when Range
        if a[-1].last + 1 == e
          a[-1] = (a[-1].first)..e
        else
          a << e
        end
      else
        if a[-1] + 1 == e
          a[-1] = a[-1]..e
        else
          a << e
        end
      end
    end
  end

  apply_list.map! do |codes|
    codes.map! {|e| e.is_a?(Range) ? format('U+%04x-%04x', e.first, e.last) : format('U+%04x', e)}
    codes.join(', ')
  end

  File.open("range/#{File.basename(file, '.*')}.txt", 'w') do |f|
    apply_list.each {|e| f.puts(e)}
  end
end
