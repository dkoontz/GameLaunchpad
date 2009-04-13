require 'rawr'
require 'rake'

task :post_rawr => "rawr:jar" do
  File.mv('package/jar/GLPLoader.jar', 'package/jar/lib/java/GLPLoader.jar')
  File.cp('index.html', 'package/jar')
end

desc "Signs jars in-place (in the lib directory)"
task :sign_in_place do
  Dir['lib/java/*.jar'].each { |jar| puts `jarsigner -storepass gamegarden #{jar} GameGarden` }
end

desc "Deploys signed GLPLoader.jar"
task :deploy_main => :post_rawr do
  puts `jarsigner -storepass gamegarden package/jar/lib/java/GLPLoader.jar GameGarden`
end

desc "Deploys signed versions of all project jars"
task :deploy => [:sign_in_place, :deploy_main]