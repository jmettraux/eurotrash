
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

#pp petties
#p petties.size
w = petties.collect(&:length).max

dd = [ 6, 8 ]

puts "| d#{dd[0]}d#{dd[1]} | petty goods |   |   |"
puts "|-----:|-------------|--:|---|"

dd[0].times do |i|
  dd[1].times do |j|
    xi = "#{i}#{j}".to_i
    xs = "#{i + 1}#{j + 1}"
    print "| %2s | %-#{w}s " % [ xs, petties[xi] ]
    puts '|' if xi.odd?
  end
end

