require 'rawr'
require 'rake'

task :post_rawr => "rawr:jar" do
  File.mv('package/jar/GameLaunchpad.jar', 'package/jar/lib/java/GameLaunchpad.jar')
  File.cp('index.html', 'package/jar')
end

desc "Signs jars in-place (in the lib directory)"
task :sign_in_place do
  Dir['lib/java/*.jar'].each { |jar| puts `jarsigner -keystore ./keystore -storepass gamelaunchpad #{jar} GameLaunchpad` }
end

# Keystore generated with: keytool -genkey -alias GameLaunchpad -keystore ./keystore
desc "Deploys signed GameLaunchpad.jar"
task :deploy_main => :post_rawr do
  puts `jarsigner -keystore ./keystore -storepass gamelaunchpad package/jar/lib/java/GameLaunchpad.jar GameLaunchpad`
end

desc "Deploys signed versions of all project jars"
task :deploy => [:sign_in_place, :deploy_main]