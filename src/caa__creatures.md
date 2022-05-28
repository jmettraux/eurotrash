
<!-- .margin.compass -->
* _Creatures_
* aaa
* bbb
* ccc


<!-- <div.creature> -->

## Bandit

* **AC**      11
* **HD**      1 (HP 4)
* **Save**    `TC` 11
* **Attack**  +0 Seax 1d6
* **Morale**  8
* **Move**    30ft 9m 6sq t
* **DCs**     str11 con11 dex11 int10 wis10 cha10

_Leader_ A NPC of level 2 or better.

<!-- </div> -->

<!-- <div.creature> -->

## Bear

* **AC**      13
* **HD**      4 (HP 18) Large
* **Save**    `TC` 11
* **Attack**  +3, 2 x Claws (1d3), 1 x Bite (1d6)
* **Morale**  7
* **Move**    40ft 12m 8sq F

_Bear Hug_ If the bear hits the same victim twice with its Claws in the same round, it hugs and an extra 2d8 of damage are dealt.

<!-- </div> -->

<!-- <div.creature> -->

## Wolf

* **AC**      12
* **HD**      2+2 (HP 11)
* **Save**    `TC` 10
* **Attack**  +2, 1 x Bite (1d6)
* **Morale**  6 (8 when in pack)
* **Move**    40ft 12m 8sq F

_Scent_ +1 on _Hunt_, _Scout_, and _Spy_ checks.

<!-- </div> -->

<script>
  onDocumentReady(function() {

    elts('.creature').forEach(function(e) {
      elts(e, 'li').forEach(function(lie) {

        var se = elt(lie, 'strong');
        if (se.textContent.trim() !== 'DCs') return;

        var s = lie.textContent.trim();
        lie.childNodes[1].textContent = '';
        s = s.slice(s.indexOf('str'));
        var ah = s.split(' ').reduce(
          function(h, ss) {
            var k = ss.slice(0, 3);
            var v = parseInt(ss.slice(3), 10);
            h[k] = v;
            return h; },
          {});

        // DCs

        var t = Object.keys(ah)
          .map(function(k) { return k.toUpperCase() + ah[k]; })
          .join(' ');
        lie.appendChild(c('span.dcs', ' ' + t));

        // TCs

        //t = Object.keys(ah)
        //  .map(function(k) { return k.toUpperCase() + (21 - ah[k]); })
        //  .join(' ');
        //var ee = c('li');
        //e.appendChild(c('span.dcs', ' ' + t));
      });
    });
  });
</script>

