require 'folders.rb'


describe 'create folder' do
  it 'given json , it should create a folder' do

    current_dir = File.dirname(__FILE__)
    settings = {}
    createFolders(current_dir, '{"Folder1":""}', settings)
    File.exists? 'Folder1'
  end
end




