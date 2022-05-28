
<!-- .margin.compass -->
* _Creatures_
* aaa
* bbb
* ccc


<!-- <div.creature> -->

## Bandit

| key    | val                                 |
|--------|-------------------------------------|
| HD     | 1                                   |
| Ini    |                                     |
| AC     | 11                                  |
| Attack | +0 Seax 1d6                         |
| Save   |                                     |
| Morale | 8                                   |
| Move   | 30ft 9m 6sq t                       |
| DCs    | str11 con11 dex11 int10 wis10 cha10 |

_Leader_ A NPC of level 2 or better.

<!-- </div> -->

<!-- <div.creature> -->

## Bear

| key    | val                                 |
|--------|-------------------------------------|
| HD     | 4 Large                             |
| Ini    |                                     |
| AC     | 13                                  |
| Attack | +3, 2 x Claws (1d3), 1 x Bite (1d6) |
| Save   |                                     |
| Morale | 7                                   |
| Move   | 40ft 12m 8sq F                      |
| DCs    | str19 con16 dex10 int02 wis13 cha07 |

_Bear Hug_ If the bear hits the same victim twice with its Claws in the same round, it hugs and an extra 2d8 of damage are dealt.

<!-- </div> -->

<!-- <div.creature> -->

## Wolf

| key    | val                                 |
|--------|-------------------------------------|
| HD     | 3                                   |
| Ini    |                                     |
| AC     | 12                                  |
| Attack | +2, 1 x Bite (1d6)                  |
| Save   |                                     |
| Morale | 6 (8 when in pack)                  |
| Move   | 40ft 12m 8sq F                      |
| DCs    | str12 con12 dex15 int03 wis12 cha06 |

_Scent_ +1 on _Hunt_, _Scout_, and _Spy_ checks.

<!-- </div> -->


<script>

  var mean = function() {
    return Math.ceil(
      Array.from(arguments).reduce(function(s, e) { return s + e; }) /
      arguments.length);
  };
  var invert = function(h) {
    return Object.keys(h).reduce(
      function(hh, k) { hh[k] = 21 - h[k]; return hh; },
      {});
  };

  var findKey = function(e, k) {
    return elts(e, 'td')
      .find(function(tde) { return tde.textContent.trim() === k; });
  };
  var findValue = function(e, k) {
    return findKey(e, k)
      .nextElementSibling.textContent.trim();
  };
  var setValue = function(e, k, v) {
    var ke = findKey(e, k);
    var ve = ke.nextElementSibling;
    ve.innerHTML = '';
    if (typeof v === 'string') { ve.textContent = '' + v; }
    else { ve.appendChild(v); }
  };

  var htos = function(h) {
    return Object.keys(h)
      .map(function(k) { return k.toUpperCase() + h[k]; })
      .join(' ');
  };

  onDocumentReady(function() {

    elts('.creature').forEach(function(e) {

      var hdt = findValue(e, 'HD');
      var hd = parseInt(hdt, 10);
      var hd2 = Math.floor(hd / 2);
      var hp = Math.floor(hd * 4.5);
      setValue(e, 'HD', `${hdt} (HP ${hp})`);

      var ke = findKey(e, 'DCs');
      var ve = ke.nextElementSibling;
      var t = ve.textContent;
      ve.textContent = '';

      var dch = t.split(' ').reduce(
        function(h, ss) {
          var k = ss.slice(0, 3);
          var v = parseInt(ss.slice(3), 10);
          h[k] = v;
          return h; },
        {});
clog(dch);
      var tch = invert(dch);
clog(tch);
      var tc2h = {};
      tc2h.bod = mean(tch.str, tch.con, tch.dex);
      tc2h.sou = mean(tch.int, tch.wis, tch.cha);
      tc2h.phy = mean(tch.str, tch.con);
      tc2h.eva = mean(tch.dex, tch.int);
      tc2h.men = mean(tch.wis, tch.cha);
      tc2h.lea = mean(tch.int, tch.wis);
      tc2h.imp = mean(tch.dex, tch.wis);
      tc2h.all = mean(tch.str, tch.con, tch.dex, tch.int, tch.wis, tch.cha);
clog(tc2h);
      var dc2h = invert(tc2h);
clog(dc2h);
clog('---');

      // DCs

      ve.appendChild(c('div.dcs', htos(dch)));

      // Initiative

      setValue(e, 'Ini', '1d20 + ' + dc2h.imp);

      // Save

      var savh = { phy: tc2h.phy, eva: tc2h.eva, men: tc2h.men };
      setValue(e, 'Save', c('div.dcs', `1d20 + ${hd2} ≥ ${htos(savh)}`));

      // Morale

      var mor = findValue(e, 'Morale');
      setValue(e, 'Morale', `2d6 ≤ ${mor}`);
    });
  });
</script>

