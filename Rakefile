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

desc "Creates signed jar"
task :sign => :post_rawr do
  Dir['package/jar/lib/java/*.jar'].each { |jar| puts `jarsigner -storepass gamegarden #{jar} GameGarden` }
end