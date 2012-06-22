require 'json'

def createFoldersFromHash(root, hash, settings, &filter)

    raise 'expected arg to be a hash' unless hash.is_a? Hash
  
    hash.each { |key,value|
      #puts "#{key} is #{value}"
      
      path_name = File.join(root, key)

      #each key is created as a folder
      if createFolder(path_name, settings, &filter)
          #each value is created according to its type
          createFolders(path_name, value, settings, &filter)
      end
    }
end

def createFoldersFromArray(root, array, settings, &filter)

    raise 'expected arg to be an array' unless array.is_a? Array
    array.each {|x| createFolders(root, x, settings, &filter) }
end

def createFolders(root, obj, settings, &filter)

    puts "createFolders: #{obj.inspect}:#{obj.class}"
    data = obj
    if data.is_a? Array
      createFoldersFromArray(root, data, settings, &filter)
    elsif data.is_a? Hash
      createFoldersFromHash(root, data, settings, &filter)
    elsif data.is_a? String
      data = data.strip.gsub('\"', '"')
      unless data.empty?
        begin
            puts "going to parse: #{data}"
            data = JSON.parse(data)
            unless data.nil? || data.empty?
              return createFolders(root, data, settings, &filter)
            end
        rescue => e
          #if it doesn't parse as json, treat it like a string below
          createFolder(File.join(root, data), settings, &filter)
        end
      end
    else
      raise "unexpected object type " + data.inspect  
    end
end

def createFolder(path_name, settings, &filter)
  
    if filter
      path_name = filter.call(path_name)
    end
    
    return false if path_name.empty?

    if File.exists? path_name
      raise "Can't create #{path_name} -- it already exists" unless settings[:force]
    end

    puts 'create ' + path_name
    FileUtils.mkdir_p path_name unless settings[:dryrun]

    true
end


