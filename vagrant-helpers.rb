require 'json'

# Read a file, returning nil if it doesn't exist
def readfile(filename)
	filename = File.expand_path(filename, File.dirname(__FILE__))
	File.read(filename)
rescue
	nil
end

def getInput(prompt, config, key, default=nil)
	prompt = "#{prompt} [#{default}]" if default
	print "#{prompt}: "
	input = STDIN.gets.strip
	if input.empty? and default
		input = default
	elsif input.empty?
		raise "Field is required, try again"
	end
	config[key] = input
end

def getYesNo(prompt, config, key)
	yesNo = nil
	while yesNo.nil?
		print "#{prompt} [y/n]: "
		response = STDIN.gets
		if response.strip == 'y'
			yesNo = true
		elsif response.strip == 'n'
			yesNo = false
		else
			print "\nPlease Enter y or n\n"
		end
	end
	config[key] = yesNo
end


def getConfig
	@localConfig ||= begin
		fileName = 'VagrantConfig'
		JSON.parse(readfile(fileName), :symbolize_names => true)
	rescue
		localConfig = Hash.new
		localConfig[:git_checkout] = 0

		getInput("How many cores?", localConfig, :cores, 1)
		getInput("How much memory?", localConfig, :memory, 512)
		getInput("Use (r)sa or (d)sa SSH key?", localConfig, :keyType, "r")
		getInput("Set the codebase location", localConfig, :code_dashboard, "~/workspace/dashboard")
		getInput("Set the codebase location", localConfig, :code_hack, "~/workspace/remote-dashing")
		getYesNo("Do you want to checkout master branch?", localConfig, :git_checkout)
		getYesNo("Do you want to copy ~/.gitconfig?", localConfig, :git_config)

		file = File.open(fileName,'w')
		file.write(JSON.dump(localConfig))
		file.close

		localConfig
	end
end

##
# return full path for 
def location(key, default)
	localConfig = getConfig
	dir = localConfig[key] || default
	dir = File.expand_path(dir)
	if !File.directory? dir
		FileUtils::mkpath(dir)
	end
	return dir
end