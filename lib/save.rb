module Save
  def serialize
    YAML.dump(self)
  end

  def deserialize(yaml)
    YAML.load(yaml)
  end

  def save_file(file_name)
    File.open("/home/justin/chess/saves/#{file_name}", 'w') { |file| file.puts serialize }
  end

  def load_file(file_name)
    file = File.open("/home/justin/chess/saves/#{file_name}", 'r')
    yaml = file.read
    deserialize(yaml)
  end

  def save
    puts 'Save?'
    resp = gets.chomp
    if resp == 'y'
      puts 'What\'s the file name?'
      save_file(gets.chomp)
    end
  end

  def load
    puts 'Load?'
    resp = gets.chomp
    if resp == 'y'
      puts 'What\'s the file name?'
      load_file(gets.chomp)
    end
  end
end