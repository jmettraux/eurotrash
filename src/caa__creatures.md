
<!-- .margin.compass -->
* _Creatures_


<!-- <div.creature> -->
## Bandit

* HD: 1
* AC: 11
* Attack: +0, Seax (1d6)
* Morale: 8
* Size: medium
* Move: 30ft 9m 6sq t
* DCs: str11 con11 dex11 int10 wis10 cha10

_Leader_ A NPC of level 2 or better.
<!-- </div> -->

<!-- <div.creature> -->
## Basilisk

* HD: 6
* AC: 15
* Attack: +6, 1 × Bite (1d10), 1 × Gaze (Petrification)
* Morale: 8
* Size: medium
* Move: 20ft 6m 4sq
* DCs: str16 con15 dex08 int02 wis08 cha07

_Xxx_ Yyy
<!-- </div> -->

<!-- <div.creature> -->
## Bat

* HD: (HP 1)
* AC: 13
* Attack: -1, 1 × Bite (1)
* Morale: 6
* Size: tiny
* Move: 40ft 12m 8sq F
* DCs: str02 con08 dex15 int02 wis12 cha04

_Xxx_ Yyy
<!-- </div> -->

<!-- <div.creature> -->
## Bear

* HD: 4
* AC: 13
* Attack: +3, 2 × Claws (1d3), 1 × Bite (1d6)
* Morale: 7
* Size: large
* Move: 40ft 12m 8sq F
* DCs: str19 con16 dex10 int02 wis13 cha07

_Bear Hug_ If the bear hits the same victim twice with its Claws in the same round, it hugs and an extra 2d8 of damage are dealt.
<!-- </div> -->

<!-- PAGE BREAK creatures -->

<!-- .margin.compass -->
* _Creatures_

<!-- <div.creature> -->
## Boar

* HD: 3
* AC: 12
* Attack: +2, 1 × Tusk (2d4)
* Morale: 9
* Size: medium
* Move: 40ft 12m 8sq F
* DCs: str13 con12 dex11 int02 wis09 cha05

_Xxx_ Yyy
<!-- </div> -->

<!-- <div.creature> -->
## Centaur

* HD: 4
* AC: 14
* Attack: +3, 1 × Weapon
* Morale: 8
* Size: medium
* Move: 50ft 15m 10sq V
* DCs: str18 con14 dex14 int09 wis13 cha11

_Xxx_ Yyy
<!-- </div> -->

<!-- <div.creature> -->
## Chimera

* HD: 9
* AC: 15
* Attack: +7, 2 × Claw (1d3), 2 x Bite (3d4)
* Morale: 9
* Size: medium
* Move: 50ft 15m 10sq V
* DCs: str19 con19 dex11 int03 wis14 cha10

_Xxx_ Yyy
<!-- </div> -->

<!-- <div.creature> -->
## Lion

* HD: 5
* AC: 13
* Attack: +4, 2 × Claw (1d4+1), 1 × bite (1d10)
* Morale: 9
* Size: medium
* Move: 50ft 15m 10sq V
* DCs: str13 con12 dex11 int02 wis09 cha05

_Xxx_ Yyy
<!-- </div> -->

<!-- PAGE BREAK creatures -->

<!-- .margin.compass -->
* _Creatures_

<!-- <div.creature> -->
## Wolf

* HD: 3
* AC: 12
* Attack: +2, 1 × Bite (1d6)
* Morale: 6 (8 pack)
* Size: medium
* Move: 40ft 12m 8sq F
* DCs: str12 con12 dex15 int03 wis12 cha06

_Scent_ +1 on _Hunt_, _Scout_, and _Spy_ checks.
<!-- </div> -->


<script>
  var sizes = {
    //tiny: '2.5 × 2.5 ft',
    //small: '5 × 5 ft',
    //medium: '5 × 5 ft',
    //large: '10 × 10 ft',
    //huge: '15 × 15 ft',
    //gargantuan: '20 × 20 ft'
    tiny: '(2.5ft)', small: '(5ft)', medium: '(5ft)', large: '(10ft)',
    huge: '(15ft)', gargantuan: '(20ft)'
  };

  onDocumentReady(function() {

    var gatherStats = function(e) {
      return elts(e, 'li').reduce(
        function(h, ee) {
          var s = ee.textContent.trim();
          var m = s.match(/^([^:]+):(.*)$/);
          h[m[1].toLowerCase()] = m[2].trim();
          return h; },
        {});
    };
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
    var htos = function(h) {
      return Object.keys(h)
        .map(function(k) { return k.toUpperCase() + h[k]; })
        .join(' | ');
    };
    var expandStats = function(h) {
      h.hd0 = h.hd;
      h.hd1 = parseInt(h.hd0, 10);
      h.hd2 = Math.floor(h.hd1 / 2);
      h.hp = Math.floor(h.hd1 * 4.5);
      if (h.hd0.slice(0, 1) === '(') {
        h.hd = '';
        h.hd2 = 0;
        h.hp = parseInt(h.hd0.match(/(\d+)/)[1], 10);
      }
      h.dcs0 = h.dcs;
      h.dcs = h.dcs.split(' ').reduce(
        function(hh, s) {
          hh[s.slice(0, 3)] = parseInt(s.slice(3), 10);
          return hh; },
        {});
      h.tcs = invert(h.dcs);
      h.tcs.bod = mean(h.tcs.str, h.tcs.con, h.tcs.dex);
      h.tcs.sou = mean(h.tcs.int, h.tcs.wis, h.tcs.cha);
      h.tcs.phy = mean(h.tcs.str, h.tcs.con);
      h.tcs.eva = mean(h.tcs.dex, h.tcs.int);
      h.tcs.men = mean(h.tcs.wis, h.tcs.cha);
      h.tcs.lea = mean(h.tcs.int, h.tcs.wis);
      h.tcs.imp = mean(h.tcs.dex, h.tcs.wis);
      h.tcs.all = mean(
        h.tcs.str, h.tcs.con, h.tcs.dex, h.tcs.int, h.tcs.wis, h.tcs.cha);
      h.dcs = invert(h.tcs);
      h.ini = `1d8 + ${h.dcs.imp}`;
      var savh = { phy: h.tcs.phy, eva: h.tcs.eva, men: h.tcs.men };
      h.save = `1d20 + ${h.hd2} ≥ ${htos(savh)}`;
      return h;
    };
    var setValue = function(e, k, v) {
      var ve = elt(e, `.v.${k}`);
      ve.innerHTML = '';
      if (typeof v === 'string') { ve.textContent = v; }
      else if (v === undefined || v === null) {}
      else { ve.appendChild(v); }
    };
    var makeGrid = function(h, tes) {
      var te = elt('#creature_template').content.cloneNode(true);
      var hde = c('div');
      hde.appendChild(c('span.hd', '' + h.hd));
      hde.appendChild(c('span.hp', `(hp${h.hp})`));
      setValue(te, 'hd', hde);
      setValue(te, 'ac', h.ac);
      setValue(te, 'ini', h.ini);
      setValue(te, 'att', h.attack);
      setValue(te, 'sav', h.save);
      setValue(te, 'mor', `2d6 ≤ ${h.morale}`);
      setValue(te, 'siz', `${h.size} ${sizes[h.size]}`);
      setValue(te, 'mov', h.move);
      var dch = {
        str: h.dcs.str, con: h.dcs.con, dex: h.dcs.dex,
        int: h.dcs.int, wis: h.dcs.wis, cha: h.dcs.cha };
      var dchh = {
        bod: h.dcs.bod, sou: h.dcs.sou,
        phy: h.dcs.phy, eva: h.dcs.eva, men: h.dcs.men, imp: h.dcs.imp };
      var dcse = c('div');
      dcse.appendChild(c('div.dcs-row', htos(dch)));
      dcse.appendChild(c('div.dcs-row', htos(dchh)));
      setValue(te, 'dcs', dcse);
      var txe = elt(te, '.t');
      txe.innerHTML = '';
      tes.forEach(function(te) { txe.appendChild(te); });
      return te;
    };

    elts('.creature').forEach(function(e) {
      var ule = elt(e, 'ul');
      var tes = elts(e, 'p');
      var h = expandStats(gatherStats(e));
      ule.remove();
      tes.forEach(function(e) { e.remove(); });
      e.appendChild(makeGrid(h, tes));
    });
  });
//      var dcxh = {
//        bod: dc2h.bod, sou: dc2h.sou,
//        phy: dc2h.phy, eva: dc2h.eva, men: dc2h.men,
//        imp: dc2h.imp };
//      ve.appendChild(c('div.dcs', htos(dcxh)));

  onDocumentReady(function() {

    //
    // generate compass...

    var pages = elts('[data-aa-title="creatures"] .page');

    var firsts = pages.map(function(pe) {
      return elt(pe, '.creature h2').textContent; });

    pages.forEach(function(pe, i) {
      var k = firsts[i];
      var ule = elt(pe, 'ul.compass');
      firsts.forEach(function(f, j) {
        var lie;
        if (i === j) {
          lie = c('li', ''); lie.appendChild(c('strong', f)); }
        else {
          lie = c('li', f); }
        ule.appendChild(lie);
      });
    });
  });
</script>
<template id="creature_template">
  <div class="creature-grid">
    <div class="k s1 hd">HD</div><div class="v s1 hd">v</div>
    <div class="k s1 ac">AC</div><div class="v s1 ac">v</div>
    <div class="k s1 ini">Ini</div><div class="v s1 ini">v</div>
    <div class="k att">Att</div><div class="v att">v</div>
    <div class="k sav">Save</div><div class="v sav">v</div>
    <div class="k s1 mor">Morale</div><div class="v s1 mor">v</div>
    <div class="k s1 siz">Size</div><div class="v s1 siz">v</div>
    <div class="k mov">Move</div><div class="v mov">v</div>
    <div class="k dcs">DCs</div><div class="v dcs">v</div>
    <div class="t">t</div>
  </div>
</template>

