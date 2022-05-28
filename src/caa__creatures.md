
<!-- .margin.compass -->
* _Creatures_
* aaa
* bbb
* ccc


<!-- <div.creature> -->

## Bandit

| key    | val                                 |
|--------|-------------------------------------|
| AC     | 11                                  |
| HD     | 1 (HP 4)                            |
| Save   | `TC` 11                             |
| Attack | +0 Seax 1d6                         |
| Morale | 8                                   |
| Move   | 30ft 9m 6sq t                       |
| DCs    | str11 con11 dex11 int10 wis10 cha10 |

_Leader_ A NPC of level 2 or better.

<!-- </div> -->

<!-- <div.creature> -->

## Bear

| key    | val                                 |
|--------|-------------------------------------|
| AC     | 13                                  |
| HD     | 4 (HP 18) Large                     |
| Save   | `TC` 11                             |
| Attack | +3, 2 x Claws (1d3), 1 x Bite (1d6) |
| Morale | 7                                   |
| Move   | 40ft 12m 8sq F                      |
| DCs    | str19 con16 dex10 int02 wis13 cha07 |

_Bear Hug_ If the bear hits the same victim twice with its Claws in the same round, it hugs and an extra 2d8 of damage are dealt.

<!-- </div> -->

<!-- <div.creature> -->

## Wolf

| key    | val                                 |
|--------|-------------------------------------|
| AC     | 12                                  |
| HD     | 2+2 (HP 11)                         |
| Save   | `TC` 10                             |
| Attack | +2, 1 x Bite (1d6)                  |
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

  onDocumentReady(function() {

    elts('.creature').forEach(function(e) {

      var ke =
        elts(e, 'td').find(function(tde) {
          return tde.textContent.trim() === 'DCs';
        });
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
      var tc3h = {};
      tc3h.lea = mean(tch.int, tch.wis);
      tc3h.imp = mean(tch.dex, tch.wis);
      tc3h.all = mean(tch.str, tch.con, tch.dex, tch.int, tch.wis, tch.cha);
clog(tc2h);
clog(tc3h);
      var dc2h = invert(tc2h);
      var dc3h = invert(tc3h);
clog(dc2h);
clog(dc3h);
clog('---');

      // DCs

      t = Object.keys(dch)
        .map(function(k) { return k.toUpperCase() + dch[k]; })
        .join(' ');
      ve.appendChild(c('div.dcs', t));

      t = Object.keys(dc2h)
        .map(function(k) { return k.toUpperCase() + dc2h[k]; })
        .join(' ');
      ve.appendChild(c('div.dcs', t));

      t = Object.keys(dc3h)
        .map(function(k) { return k.toUpperCase() + dc3h[k]; })
        .join(' ');
      ve.appendChild(c('div.dcs', t));
    });
  });
</script>

