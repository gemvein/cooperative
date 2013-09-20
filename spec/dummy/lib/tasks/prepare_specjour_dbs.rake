desc 'Prepare test databases for Specjour'
task :specjour do
  for index in 1..8 do
    ENV['TEST_ENV_NUMBER'] = index.to_s
    Rake::Task['db:create'].invoke
    Rake::Task['db:test:load'].invoke
  end
end