
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
  leather satchel
  little silver mirror
  small fine-quality seax
  small knife
  jug of vinegar
  cheap brooch
  carved roman statuette
  glass goblet
  fishing line and hook
  embroidered cloak
  satchel of spices
  wool blanket
  brightly-dyed shirt
  flask of perfumed oil
  ass-wiping moss
  jug of good mead
  cobweb bundle
  plain and sturdy cloak
  silver brooch
  some dried meat
  pot of honey
  piece of cheese
  silver bracelet
  a few coins
  silver tweezers, nail-picks
  carved wooden cup
  knife blade
  jewel-hilted belt knife
  bone hair comb
  piece of fine linen
  unset gemstone
  good whetstone
  pouch of salt
  small carved religious symbol
  bundle of seasoning herbs
  cheap bracelet
  small wrought religious symbol
  loaf of bread
  wolf tooth necklace
  tooled leather belt
  hatchet
  tooled leather boots
  jug of wine
  loose spearhead
  well-made hand harp

  #(nothing)
  #(nothing)
  #(nothing)
}
render(2, [ 6, 8 ], 'Petty Goods', entries)

# :43,88!sort -R
  # to shuffle the entries

# CTRL-V selection then hit "!" to go into :'<,'>! mode... sort -R
  # to shuffle the entries

