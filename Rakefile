require 'rawr'
require 'rake'

task :post_rawr => "rawr:jar" do
  File.mv('package/jar/GameLoader.jar', 'package/jar/lib/java/GameLoader.jar')
  File.cp('index.html', 'package/jar')
end

desc "Signs jars in-place (in the lib directory)"
task :sign_in_place do
  Dir['lib/java/*.jar'].each { |jar| puts `jarsigner -storepass gamegarden #{jar} GameGarden` }
end

desc "Deploys signed GameLoader.jar"
task :deploy_main => :post_rawr do
  puts `jarsigner -storepass gamegarden package/jar/lib/java/GameLoader.jar GameGarden`
end

desc "Deploys signed versions of all project jars"
task :deploy => [:sign_in_place, :deploy_main]