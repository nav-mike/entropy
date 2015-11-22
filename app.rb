
def main(args)
  filename = args.first
  file = File.open(filename, 'rb')
  content = file.read
  ns = [1, 2, 3]
  file = File.open('result.txt', 'w')
  ns.each do |n|
    blocks = []
    string_blocks = []
    size = content.size
    regex = '[a-zA-Z0-9]' * n
    file.write "block size is: #{n}\n"
    index = 0
    bsize = content.scan(Regexp.new(regex)).count
    content.scan(Regexp.new(regex)) do |b|
      unless string_blocks.include? b
        block = {block: b,
                   count: content.chars.each_cons(b.size).map(&:join).count(b),
                   x: content.chars.each_cons(b.size).map(&:join).count(b).to_f / size}

        # calculate fields
        block[:p] = block[:x].to_f / (size - n + 1)

        blocks << block
        string_blocks << b
        # print
        file.write "index: #{index += 1}/#{bsize}\n"
        file.write "#{b}\n"
        file.write "count: #{block[:count]} / #{size}\n"
        file.write "x: #{block[:count]}\n"
        file.write "p: #{block[:p]}\n"
        file.write "=================================\n"
      end
    end

    sum = 0.0
    blocks.each do |b|
      sum += b[:p] * Math::log(b[:p], 2)
    end
    sum = (-1 * sum) / n
    file.write "++++++++++++++++++++++++++++++++++\n"
    p "sum: #{sum}"
    file.write "sum: #{sum}\n"
    file.write "##################################\n"
  end
end

main(ARGV)