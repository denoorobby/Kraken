module Kraken

require 'folders.rb'


describe 'create folder' do

  before(:each) { 
    @current_dir = File.dirname(__FILE__)

    testFolder = File.join(@current_dir, "TestFolder1")
    if File.exists? testFolder
      FileUtils.rm_rf(testFolder)
    end
    testFolder = File.join(@current_dir, "TestFolder2")
    if File.exists? testFolder
      FileUtils.rm_rf(testFolder)
    end
    testFolder = File.join(@current_dir, "TestFolder3")
    if File.exists? testFolder
      FileUtils.rm_rf(testFolder)
    end
  }

  after(:each) {
  }

  it 'given json hash, it should create a folder' do
    settings = {}
    createFolders(@current_dir, '{"TestFolder1":""}', settings)
    File.exists? 'TestFolder1'
  end

  it 'given a hash, it should create a folder' do
    settings = {}
    folders = { "TestFolder1" => "" }
    createFolders(@current_dir, folders, settings) 
    File.exists? 'TestFolder1'
  end

  it 'given json array, it should create a folder' do
    settings = {}
    createFolders(@current_dir, '["TestFolder1", "TestFolder2"]', settings)
    File.exists? 'TestFolder1'
    File.exists? 'TestFolder2'
  end

  it 'given an array, it should create a folder' do
    settings = {}
    array = [ "TestFolder1", "TestFolder2"]
    createFolders(@current_dir, array, settings)
    File.exists? 'TestFolder1'
    File.exists? 'TestFolder2'
  end
  
end


end

