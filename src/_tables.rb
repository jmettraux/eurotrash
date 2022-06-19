
petties = %{

  good pair of boots
  small knife
  cheap bracelet
  cheap brooch
  sturdy cloak
  piece of cheese
  loaf of bread
  leather satchel
  ass-wiping moss
  small carved religious symbol
  bundle of seasoning herbs
  loose spearhead
  bone hair comb
  handful of dried meat (1d)
  good whetstone
  pouch of salt
  hatchet
  wolf tooth necklace
  wool blanket
  carved wooden cup
  fishing line and hook

  silver brooch
  silver bracelet
  embroidered cloak
  jewel-hilted belt knife
  satchel of spices
  unset gemstone
  small wrought religious symbol
  glass goblet
  flask of perfumed oil
  jug of good mead
  jug of wine
  tooled leather belt
  tooled leather boots
  small fine-quality seax
  little silver mirror
  carved roman statuette
  a few coins
  well-made hand harp
  brightly-dyed shirt
  piece of fine folded linen
  silver tweezers and nail-picks

  nothing
  nothing
}.split("\n").collect(&:strip).select { |e| e.length > 0 }.shuffle


cs = 3
dd = [ 6, 8 ]
title = "Petty Goods"

(cs * 2).times do |i|
  s =
    i == 0 ? "d#{dd[0]}d#{dd[1]}" :
    i == 1 ? title :
    ' '
  print "| #{s} "
  puts '|' if (i % (2 * cs)) == (2 * cs - 1)
end
(cs * 2).times do |i|
  print "|--" + ((i % 2) === 0 ? ':' : '-')
  puts '|' if (i % (2 * cs)) == (2 * cs - 1)
end

keys = []
dd[0].times do |i|
  dd[1].times do |j|
    keys << "#{i + 1}#{j + 1}"
  end
end
kl = keys.length
keys = keys.each_slice(kl / cs).to_a
a = petties.each_slice(kl / cs).to_a
cws = a.collect { |ss| ss.collect(&:length).max }

keys[0].each_with_index do |_, j|
  cs.times do |i|
    print "| %s | %-#{cws[i]}s " % [ keys[i][j], a[i][j] ]
    puts "|" if i == cs - 1
  end
end

