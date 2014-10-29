
task :spec do
  ENV['RAILS_ENV'] = 'test'
  Rails.env = 'test'
  Rake::Task["db:migrate"].invoke
  Rake::Task['rspec'].invoke
end

desc "Run specs"
RSpec::Core::RakeTask.new(:rspec) do |t|
  t.pattern = './spec/**/*_spec.rb'
end

desc 'Run specs on travis'
task :ci do
  ENV['RAILS_ENV'] = 'test'
  Rails.env = 'test'

  Jettywrapper.unzip
  jetty_params = Jettywrapper.load_config
  error = Jettywrapper.wrap(jetty_params) do
    Rake::Task['spec'].invoke
  end
  raise "test failures: #{error}" if error
end
