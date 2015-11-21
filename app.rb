
def main(args)
  filename = args.first
  file = File.open(filename, 'rb')
  content = file.read
  [1, 2, 3].each do |n|
    blocks = []
    size = content.size
    regex = '.' * n
    p "block size is: #{n}"
    content.scan(Regexp.new(regex)) do |b|
      blocks << {block: b,
                 count: content.chars.each_cons(b.size).map(&:join).count(b),
                 x: content.chars.each_cons(b.size).map(&:join).count(b).to_f / size}
      p b
      p "count: #{blocks.last[:count]} / #{size}"
      p "x: #{blocks.last[:count]}"
    end
  end
end

main(ARGV)