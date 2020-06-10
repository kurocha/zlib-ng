
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "3.0"

define_target "zlib-ng" do |target|
	target.priority = 80
	
	target.depends :platform
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/z" do
		source_files = target.package.path + "zlib-ng"
		cache_prefix = environment[:build_prefix] / environment.checksum + "zlib-ng"
		package_files = cache_prefix / "lib/libzlib.a"
		
		cmake source: source_files, install_prefix: cache_prefix, arguments: [
			"-DBUILD_SHARED_LIBS=OFF",
			"-DZLIB_COMPAT=ON"
		], package_files: package_files
		
		append linkflags package_files
		append header_search_paths cache_prefix + "include"
	end
end

define_configuration "zlib-ng" do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
