#!/usr/bin/env ruby

require "csv"

def run
  if ARGV.size == 3
    summary_file = ARGV.shift
    people_file  = ARGV.shift
    output_file  = ARGV.shift
    begin
      summary = read_summary(summary_file)
      people = read_people(people_file)
      working_times = people_working_times(people, summary)
      write_result(output_file, working_times)
    rescue => e
      puts e.message
    end
  else
    exe_file = File.basename($PROGRAM_NAME)
    puts "Usage:
    #{exe_file} summary_file people_file output_file"
  end
end

def read_summary(file_path)
  raise StandardError, "File #{file_path} not exists." unless File.exists?(file_path)
  result = []
  CSV.foreach(file_path, headers: true, col_sep: ",") do |row|
    result << [row[0].strip, row[1].strip]
  end
  result
end

def read_people(file_path)
  raise StandardError, "File #{file_path} not exists." unless File.exists?(file_path)
  people = []
  File.open(file_path) do |file|
    file.each do |line|
      last_name, first_name = line.strip.split(" ")
      people << "#{first_name} #{last_name}"
    end
  end
  people
end

def write_result(file_path, working_times)
  raise StandardError, "File #{file_path} already exists." if File.exists?(file_path)
  File.open(file_path, 'w') do |file|
    working_times.each do |wt|
      file.puts wt
    end
  end
end

def people_working_times(people, summary)
  result = []
  people.each do |person|
    person_data = find_person_data(person, summary)
    result << person_data and next if person_data.is_a?(String)
    time_string = person_data[1]
    result << (time_string_to_number(time_string) rescue "Time conversion error.")
  end
  result
end

def find_person_data(person_name, people_summary)
  person_data = people_summary.find {|person_summ| person_summ[0] == person_name }
  return "#{person_name} data not found." unless person_data
  person_data
end

def time_string_to_number(time_string)
  hours, minutes = time_string.split(":")
  Float(hours) + (Float(minutes) / 60).round(2)
end

run if __FILE__ == $0
