module Kraken

def createFiles(root, obj, settings, &filter)

    if obj.is_a? Hash
      puts obj.inspect
    else
      raise "unexpected object type " + obj.inspect  
    end
end

end

