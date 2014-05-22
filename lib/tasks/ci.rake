require 'rspec/core'
require 'rspec/core/rake_task'
APP_ROOT = '.'
require 'jettywrapper'
JETTY_ZIP_BASENAME = 'master'
Jettywrapper.url = "https://github.com/projecthydra/hydra-jetty/archive/#{JETTY_ZIP_BASENAME}.zip"

def system_with_command_output(command, options = {})
  pretty_command = "\n$\t#{command}"
  $stdout.puts(pretty_command)
  if !system(command)
    banner = "\n\n" + "*" * 80 + "\n\n"
    $stderr.puts banner
    $stderr.puts "Unable to run the following command:"
    $stderr.puts "#{pretty_command}"
    $stderr.puts banner
    exit!(-1) unless options.fetch(:rescue) { false }
  end
end

desc 'Run specs on travis'
task :ci do
  ENV['RAILS_ENV'] = 'test'
  ENV['TRAVIS'] = '1'
  Jettywrapper.unzip
  jetty_params = Jettywrapper.load_config
  error = Jettywrapper.wrap(jetty_params) do
    Rake::Task['spec'].invoke
  end
  raise "test failures: #{error}" if error
end
