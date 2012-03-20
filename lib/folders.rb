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

    array.each { |value|
      createFolders(root, value, settings, &filter)
    }
end

def createFolders(root, obj, settings, &filter)

    if obj.is_a? Array
      createFoldersFromArray(root, obj, settings, &filter)
    elsif obj.is_a? Hash
      createFoldersFromHash(root, obj, settings, &filter)
    elsif obj.is_a? String
      data = obj.strip
      unless data.empty?
        begin
          createFolders(root, JSON.parse(data), settings, &filter)
        rescue Exception => e
          raise e
        end
      end
    else
      raise "unexpected object type " + obj.inspect  
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


