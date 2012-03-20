require 'folders.rb'


describe 'create folder' do

  before(:each) { 
    puts 'before'
  }

  after(:each) {
    puts 'after'
  }

  it 'given json , it should create a folder' do

    current_dir = File.dirname(__FILE__)
    settings = {}
    createFolders(current_dir, '{"TestFolder":""}', settings)
    File.exists? 'TestFolder'
  end

  it 'given a hash, it should create a folder' do
    current_dir = File.dirname(__FILE__)
    settings = {}
    folders = { "TestFolder" => "" }
    createFolders(current_dir, folders, settings) 
    File.exists? 'TestFolder'
  end
end




