configuration do |c|
  c.project_name = 'MyGame'
  c.output_dir = 'package'
  c.main_ruby_file = ''
  c.main_java_file = ''

  # Compile all Ruby and Java files recursively
  # Copy all other files taking into account exclusion filter
  c.source_dirs = ['src']
  c.source_exclude_filter = []

  c.compile_ruby_files = false
  #c.java_lib_files = []
#  c.java_lib_dirs = []
  #c.files_to_copy = []

  c.target_jvm_version = 1.5
  c.jars[:assets] = { :directory => 'assets' }
  #c.jvm_arguments = ""

  # Bundler options
  # c.do_not_generate_plist = false
end