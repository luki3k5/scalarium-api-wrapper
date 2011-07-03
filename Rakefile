namespace :test do

  desc "run spec/unit tests"
  task :spec do
    print %x[rspec spec/*_spec.rb]
  end
  
  desc "run functional tests"
  task :functional do
    print %x[rspec spec/functional/*_spec.rb]
  end
  
  desc "run all the tests"
  task :all => [:spec, :functional] do
  end
  
end

require 'bundler/gem_tasks'

