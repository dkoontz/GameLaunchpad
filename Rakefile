require 'rawr'
require 'rake'
require 'spec/rake/spectask'

task :post_rawr => "rawr:jar" do
  File.mv('package/jar/GameLaunchpad.jar', 'package/jar/lib/java/GameLaunchpad.jar')
  File.cp('index.html', 'package/jar')
end

desc "Signs jars in-place (in the lib directory)"
task :sign_in_place do
  Dir['lib/java/*.jar'].each { |jar| puts `jarsigner -keystore ./keystore -storepass gamelaunchpad #{jar} GameLaunchpad` }
end

# Keystore generated with "keytool -genkey -alias GameLaunchpad -keystore ./keystore"
desc "Deploys signed GameLaunchpad.jar"
task :deploy_main => :post_rawr do
  puts `jarsigner -keystore ./keystore -storepass gamelaunchpad package/jar/lib/java/GameLaunchpad.jar GameLaunchpad`
end

desc "Deploys signed versions of all project jars"
task :deploy => [:sign_in_place, :deploy_main]

desc "Run all unit specs"
Spec::Rake::SpecTask.new do |t|
  t.libs << File.expand_path(File.dirname(__FILE__) + "/src/ruby")
  t.libs << File.expand_path(File.dirname(__FILE__) + "/test/unit")
  t.spec_files = FileList['test/unit/**/*_spec.rb']
  t.ruby_opts = ['-rtime']
  t.spec_opts = ['--color']
end