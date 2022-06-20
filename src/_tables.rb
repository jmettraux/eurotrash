
def render(col_count, dice, title, entries)

  a = entries.split("\n")
    .collect(&:strip)
    .select { |e| e.length > 0 && e[0, 1] != '#' }

  (col_count * 2).times do |i|
    s =
      i == 0 ? "d#{dice[0]}d#{dice[1]}" :
      i == 1 ? title :
      ' '
    print "| #{s} "
    puts '|' if (i % (2 * col_count)) == (2 * col_count - 1)
  end
  (col_count * 2).times do |i|
    print "|--" + ((i % 2) === 0 ? ':' : '-')
    puts '|' if (i % (2 * col_count)) == (2 * col_count - 1)
  end

  keys = []
  dice[0].times do |i|
    dice[1].times do |j|
      keys << "#{i + 1}#{j + 1}"
    end
  end
  kl = keys.length
  keys = keys.each_slice(kl / col_count).to_a
  a = a.each_slice(kl / col_count).to_a
  cws = a.collect { |ss| ss.collect(&:length).max }

  keys[0].each_with_index do |_, j|
    col_count.times do |i|
      print "| %s | %-#{cws[i]}s " % [ keys[i][j], a[i][j] ]
      puts "|" if i == col_count - 1
    end
  end
end


#
# petty goods

entries = %{
  pot of honey
  embroidered cloak
  1d6 spare arrow-heads
  wrought religious symbol
  cheap brooch
  piece of fine linen
  carved wooden cup
  well-made hand harp
  satchel of spices
  hatchet
  leather satchel
  ass-wiping moss
  brightly-dyed shirt
  tooled leather belt
  knife blade
  glass goblet
  carved religious symbol
  flask of perfumed oil
  a few coins
  fine-quality seax
  jug of vinegar
  jug of wine
  little silver mirror
  cheap bracelet
  cobweb bundle
  sewing kit
  wolf tooth necklace
  silver bracelet
  good whetstone
  plain and sturdy cloak
  pouch of salt
  bone hair comb
  jewel-hilted belt knife
  loose spearhead
  unset gemstone
  silver tweezers, nail-picks
  small knife
  silver brooch
  loaf of bread
  wool blanket
  some dried meat
  piece of cheese
  seasoning herbs
  fishing line and hook
  tooled leather boots
  silver necklace
  carved statuette
  jug of good mead
}
render(3, [ 6, 8 ], 'Petty Goods', entries)

# :43,88!sort -R
  # to shuffle the entries

# CTRL-V selection then hit "!" to go into :'<,'>! mode... sort -R
  # to shuffle the entries

