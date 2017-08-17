# frozen_string_literal: true
require 'csv'
require 'date'

def header(row)
  labels = row.collect do |label|
    next if label =~ /^file/
    label.to_sym
  end
  labels.delete(nil)
  labels + [:files]
end

def work(keys, row)
  work = {}

  keys.each do |key|
    break if key == :files
    work[key] = row.delete_at(0)
    work[key] = work[key].split("|") if work[key] =~ /\|/
  end

  work[:files] = []
  row.each_slice(6) do |path, title, visibility, embargo_date, pid, uri|
    break if path.nil?
    path = File.join(ENV["PATH_TO_WORKS"], path)
    work[:files] +=
      [{
        shell_path:   Shellwords.escape(path),
        path:         path,
        title:        title,
        visibility:   visibility,
        embargo_date: embargo_date,
        pid:          pid,
        uri:          uri
      }]
  end

  work
end

def transfer_files(files)
  files.each { |file| rsync_to_tmp(file[:shell_path]) }
  files.collect do |file|
    file.merge(path: tmp(file[:path]))
  end
end

def rsync_to_tmp(path)
  system("rsync #{path} #{tmp(path)}")
end

def isolate_file_name(path)
  path.match(/^(.+)\/([^\/]+)$/)[-1]
end

def tmp(path)
  "/tmp/" + isolate_file_name(path)
end

def timestamp
  @timestamp ||= Time.zone.now.strftime('%s')
end

def new_work_upload_log
  location = Rails.root.join('tmp', "#{timestamp}-work_upload_log.csv")
  system("touch #{location}")
  CSV.open(location, "wb") << ["Id", "Scholar Owner"]
end

def new_file_upload_log
  location = Rails.root.join('tmp', "#{timestamp}-file_upload_log.csv")
  system("touch #{location}")
  CSV.open(location, "wb") << ["Id", "Work Id", "Old file URI"]
end

def close_csv(csv)
  csv.close
end

def remove_tmp_files(files)
  files.each { |file| system("rm -f #{file[:path]}") }
end

namespace :batch do
  # rake batch:load CSV_LOCATION="/Users/vanmiljf/Downloads/sample_batch_metadata.txt" PATH_TO_WORKS="/home/james/batch"
  desc 'Load multiple works from a tab delimited text file'
  task load: :environment do
    work_log = new_work_upload_log
    file_log = new_file_upload_log

    sheet = CSV.read(ENV["CSV_LOCATION"], col_sep: "\t", quote_char: "\x00")
    keys = header(sheet.delete_at(0))
    works = sheet.map { |row| work(keys, row) }

    works.each do |work|
      work[:files] = transfer_files(work[:files])

      wl = WorkLoader.new(work.dup)
      if wl.create
        puts "Created: #{wl.work_log}"
        wl.file_log.each do |line|
          puts "Created: #{line}"
        end
        # wl.set_collections
      else
        puts "Failed to create: #{wl.work_log}"
      end
      remove_tmp_files(work[:files])
    end

    close_csv work_log
    close_csv file_log
  end
end
