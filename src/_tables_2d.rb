
def render(col_count, dice, title, entries)

  a0 = entries.split("\n")
    .collect(&:strip)
    .select { |e| e.length > 0 && e[0, 1] != '#' }

  # reorder, top in the middle

  a = []; j = 0; k = a0.length - 1
    #
  a0.length.times do |i|
    if i.even?
      a[j] = a0.pop
      j = j + 1
    else
      a[k] = a0.pop
      k = k - 1
    end
  end

  range = dice[1].times.collect { |i| i + 1 }

  rolls = range
  (dice[0] - 1).times { rolls = rolls.product(range) }

  count = rolls.count

  stats = rolls
    .inject({}) { |h, r|
      s = r.flatten.reduce(&:+)
      h[s] = (h[s] || 0) + 1
      h }
    .inject({}) { |h, (k, v)|
      h[k] = '%0.2f' % (v.to_f / count * 100)
      h }

  slice_length = (stats.length.to_f / col_count).ceil

  a = a.each_slice(slice_length).to_a
  cws = a.collect { |ss| ss.collect(&:length).max }
  ss = stats.to_a.each_slice(slice_length).to_a

  (col_count * 3).times do |i|
    s =
      i == 0 ? "#{dice[0]}d#{dice[1]}" :
      i == 1 ? title :
      ' '
    print "| #{s} "
    puts '|' if (i % (3 * col_count)) == (3 * col_count - 1)
  end
  (col_count * 3).times do |i|
    print "|--" + (((i % 3) === 0 || (i % 3) === 1) ? ':' : '-')
    puts '|' if (i % (3 * col_count)) == (3 * col_count - 1)
  end

  ss[0].each_with_index do |_, j|
    col_count.times do |i|
      print "| %s | %s | %-#{cws[i]}s " % [
        (('%2d' % ss[i][j][0]) rescue '  '),
        (('%5s%%' % ss[i][j][1]) rescue '      '),
        (a[i][j] rescue '') ]
      puts "|" if i == col_count - 1
    end
  end
end

render(2, [ 3, 6 ], 'weapons', %{
  spear, shield, seax
  spear, shield, axe
  axe
  short bow, seax
  short bow, axe
  seax
  knife
  quarterstaff, sling, seax
  quarterstaff, sling, knife
  quarterstaff, knife
  club, knife
  short bow, shield, sword
  javelins, seax
  spear, shield, sword
  sword, shield
  crossbow, seax
})

