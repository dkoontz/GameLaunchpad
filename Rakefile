require 'rawr'
#require '../../general/rawr/lib/rawr'
require 'rake'

task :post_rawr => "rawr:jar" do
  File.mv('package/jar/GameGardenLoader.jar', 'package/jar/lib/java/GameGardenLoader.jar')
#  Dir['lib/java/*.lzma'].each do |lzma_file|
#    File.cp lzma_file, "package/jar/lib/java/#{lzma_file.gsub('lib/java/', '')}"
#  end
  File.cp('index.html', 'package/jar')
end

desc "Signs jars in-place (in the lib directory)"
task :sign_in_place do
  Dir['lib/java/*.jar'].each { |jar| puts `jarsigner -storepass gamegarden #{jar} GameGarden` }
end

desc "Deploys signed GameGardenLoader.jar"
task :deploy_main => :post_rawr do
  puts `jarsigner -storepass gamegarden package/jar/lib/java/GameGardenLoader.jar GameGarden`
end

desc "Deploys signed versions of all project jars"
task :deploy => [:sign_in_place, :sign_main]