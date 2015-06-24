##
# This is a SHAME file.
# If you don't know where to put your function, you put it here and clear it up next time.
#
# This file should be empty most of the time

def ensureDir(dir)
	dir = File.expand_path(dir)
	if !File.directory? dir
		FileUtils::mkpath(dir)
	end
	return dir
end
