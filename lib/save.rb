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
    puts 'Save?(y/n)'
    resp = gets.chomp until %w[y n].include?(resp)
    return unless resp == 'y'

    puts 'What\'s the file name?'
    save_file(gets.chomp)
  end

  def load
    puts 'Load?(y/n)'
    resp = gets.chomp until %w[y n].include?(resp)
    return unless resp == 'y'

    puts 'SAVED FILES'
    display_saves
    puts 'What\'s the file name?'
    file_name = gets.chomp until saved_file_list.include?(file_name)
    load_file(file_name)
  end

  def saved_file_list
    Dir.entries('/home/justin/chess/saves')
  end

  def display_saves
    names = saved_file_list
    names.each do |name|
      puts name unless %w[. ..].include?(name)
    end
  end
end
