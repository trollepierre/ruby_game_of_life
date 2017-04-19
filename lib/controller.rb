require_relative '../lib/file_manager'

class Controller

  def initialize file_manager
    @file_manager = file_manager
  end

  def sayHi
    "Hello, world!"
  end

  def getGrid id
    @file_manager.getNotNullFormattedGridFromReadFile(id)
    id
  end

end