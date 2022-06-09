
# lib/make_creatures.rb

CREATURES_PER_PAGE = 4


def make_creatures

  File.open('src/caa__creatures.md', 'wb') do |f|

    c = 0

    File.readlines('src/_creatures.md').each_with_index do |l, i|

      if l.match?(/^## /)

        f.puts("\n<!-- </div> -->") if c > 0

        if c % CREATURES_PER_PAGE == 0
          f.puts('<!-- PAGE BREAK creatures -->') if c > 0
          f.puts('<!-- .margin.compass -->')
          f.puts('* _Creatures_')
          f.puts
        end

        c = c + 1

        f.puts("\n<!-- <div.creature> -->")
      end
      f.write(l)
    end

    f.puts("\n<!-- </div> -->")

    f.puts
    f.write(File.read('src/_creatures.html'))

    puts "-" * 80
    puts "#{c} creatures"
    puts "-" * 80
  end
end

