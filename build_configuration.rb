configuration do |c|
  c.project_name = 'GameLaunchpad'
  c.output_dir = 'package'
  c.main_ruby_file = 'main'
  c.main_java_file = 'com.gamelaunchpad.GameLoader'

  # Compile all Ruby and Java files recursively
  # Copy all other files taking into account exclusion filter
  c.source_dirs = ['src/java', 'src/ruby', 'lib/ruby']
  c.source_exclude_filter = []

  c.compile_ruby_files = false
  #c.java_lib_files = []  
  c.java_lib_dirs = ['lib/java']
  #c.files_to_copy = []

  c.target_jvm_version = 1.5
  #c.jars[:data] = { :directory => 'data/images', :location_in_jar => 'images', :exclude => /bak/}
  #c.jvm_arguments = ""

  # Bundler options
  # c.do_not_generate_plist = false
end
