
def render(column_count, dice)

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
p stats

  stats.each do |k, v|
    puts "| %2d | %5s%% | %s |" % [ k, v, '' ]
  end
end

render(2, [ 3, 6 ])

