
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "1.0.0"

define_target "zlib-ng" do |target|
	target.build do
		source_files = Files::Directory.join(target.package.path, "zlib-ng")
		cache_prefix = environment[:build_prefix] / environment.checksum + "zlib-ng"
		package_files = environment[:install_prefix] / "lib/libz.a"
		
		cmake source: source_files, build_prefix: cache_prefix, arguments: [
			"-DBUILD_SHARED_LIBS=OFF",
		]
		
		make prefix: cache_prefix, package_files: package_files
	end
	
	target.priority = 80
	
	target.depends :platform
	
	target.depends "Build/Make"
	target.depends "Build/CMake"
	
	target.provides "Library/z" do
		append linkflags {install_prefix + "lib/libz.a"}
	end
end

define_configuration "zlib-ng" do |configuration|
	configuration[:source] = "https://github.com/kurocha/"
	
	configuration.require "platforms"
	
	configuration.require "build-make"
	configuration.require "build-cmake"
end
