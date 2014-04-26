#!/usr/bin/ruby
def directory_exists?(dir)
  File.exists?(dir)
end

def create_directory(dir)
  puts "Creating directory: #{dir}"
  Dir.mkdir(dir)
  puts "\n"
end

def backup_file(file, dir)
  puts "Backing up ~/.#{file} to #{dir}"
  cmd = "mv ~/.#{file} #{dir}/#{file}"
  `#{cmd}`
end

def symlink_file(file, dir)
  puts "Symlinking ~/.#{file}..."
  cmd = "ln -s #{dir}/#{file} ~/.#{file}"
  `#{cmd}`
end

###
#
# Backup current dotfiles and symlink dotfiles to ~
#
backup_dir   = File.expand_path('~/dotfiles_bak')
dotfiles_dir = File.expand_path('~/dotfiles/')

create_directory(dotfiles_dir) unless directory_exists?(dotfiles_dir)
create_directory(backup_dir) unless directory_exists?(backup_dir)

files = %w{gitconfig gitignore vimrc zshrc}

files.each do |file|
  backup_file(file, backup_dir)
  symlink_file(file, dotfiles_dir)
  puts "\n"
end
