
def main(args)
  filename = args.first
  file = File.open(filename, 'rb')
  content = file.read
  p content
end

main(ARGV)