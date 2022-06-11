
var sizes = {
  //tiny: '2.5 × 2.5 ft',
  //small: '5 × 5 ft',
  //medium: '5 × 5 ft',
  //large: '10 × 10 ft',
  //huge: '15 × 15 ft',
  //gargantuan: '20 × 20 ft'
  //tiny: '(2.5ft)', small: '(5ft)', medium: '(5ft)', large: '(10ft)',
  //huge: '(15ft)', gargantuan: '(20ft)'
  tiny: 'tny ½×½sq', small: 'sml 1×1sq', medium: 'med 1×1sq',
  large: 'lrg 2×2sq', huge: 'hge 3×3sq', gargantuan: 'gar 4×4sq'
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
  //var htos = function(h) {
  //  return Object.keys(h)
  //    .map(function(k) { return k.toUpperCase() + h[k]; })
  //    .join(' | ');
  //};
  var htoe = function(h) {
    var e = c('div.htoe');
    var ks = Object.keys(h);
    ks.forEach(function(k, i) {
      var se = c('span.score');
      se.appendChild(c('code', k.toUpperCase()));
      se.appendChild(c('span', '' + h[k]));
      e.appendChild(se);
      //if (i !== ks.length - 1) e.appendChild(t('|'));
      if (i !== ks.length - 1) e.appendChild(t(' '));
    });
    return e;
  };
  var expandStats = function(h) {
    h.hd0 = h.hd;
    h.hd1 = parseInt(h.hd0, 10);
    h.hd2 = Math.floor(h.hd1 / 2);
    h.hp = Math.floor(h.hd1 * 4.5);
    if (h.hd0.slice(0, 1) === '(') {
      h.hd = ''; h.hd2 = 0; h.hp = parseInt(h.hd0.match(/(\d+)/)[1], 10);
    }
    else if (h.hd0.match(/\./)) {
      h.hd = '½'; h.hd2 = 0; h.hp = 2;
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
    h.ini = `1d20 + ${h.dcs.imp}`;
    h.savh = { phy: h.tcs.phy, eva: h.tcs.eva, men: h.tcs.men };
    h.skls = (h.skills || '').split(/ *, */).sort().join(', ');
    return h;
  };
  var listSkills = function(s) {
    var r = []; if (typeof s !== 'string') return r;
    var ss = s.split(/ *, */);
    ss.forEach(function(ssi, i) {
      var x = ssi.split(/ *\+ */);
      r.push(c('em', x[0]));
      r.push(t(' +' + x[1]));
      if (i !== ss.length - 1) r.push(t(', '));
    });
    return r;
  };
  var listMovements = function(s) {
    var ss = s.split(/ *, */).reduce(
      function(a, e) {
        a.push(e);
        a.push(', ');
        return a; },
      []);
    ss.pop(); if (ss.length > 4) ss.splice(4, 0, c('br'));
    return ss;
  };
  var fiveToBx = {
    10: 15, 20: 25, 25: 30, 30: 40, 40: 45, 50: 60, 60: 80, 80: 100,
    90: 120, 120: 150 };
  var listBxMovements = function(s) {
    return s.split(/ *, */).map(function(ss) {
      var five = parseInt(ss, 10);
      var sss = ss.split(/ +/);
      var d = fiveToBx[five];
      var x = sss.length > 4 ? (' ' + sss.splice(-1)) : '';
      return `(${d}'${x})`;
    }).join(', ');
  };
  var computeThac0 = function(s) {
    return '' + (19 - parseInt(s, 10));
  };
  var computeDescAc = function(s) {
    //return `]${19 - parseInt(s, 10)}[`;
    return `↓${19 - parseInt(s, 10)}`;
  };
  var computeDamageAverage = function(s) {
    var m = s.match(/\(([^)]+)\)/);
    var m = m && m[1].match(/(\d+)d(\d+)\s*(([-+])\s*(\d+))?/);
    if ( ! m) return null;
    var c = parseInt(m[1], 10);
    var d = parseInt(m[2], 10);
    var p = m[5] ? parseInt(m[5], 10) * (m[4] === '-' ? -1 : 1) : 0;
    var a = 0.5 + d / 2;
    return '' + Math.floor(c * a + p);
  };
  var splitAttacks = function(s) {
    var a = [];
    var ii = 0; var j; while (true) {
      ii = ii + 1; if (ii > 30) { clog('HAD TO BREAK'); break; }
      var ci = s.indexOf(', ');
      var oi = s.indexOf(' or ');
      if (ci === -1) ci = 9999; if (oi === -1) oi = 9999;
      if (ci === oi) { a.push(s); break; } // 9999 and 9999
      if (ci > oi) {
        a.push(s.slice(0, oi)); a.push('|'); j = oi + 4; }
      else {
        a.push(s.slice(0, ci)); a.push('&'); j = ci + 2; }
      s = s.slice(j);
    }
    return a;
  };
  var listAttacks = function(s) {
    var ats = splitAttacks(s);
//clog(ats);
    var atb = ats.shift();
    var a = [];
    a.push(c('span.atb', atb));
    ats.forEach(function(at) {
      if (at === '&') { a.push(', '); }
      else if (at === '|') { a.push(' or '); }
      else {
        a.push(at);
        var dav = computeDamageAverage(at);
        if (dav) a.push(c('span.dav', dav));
      }
    });
    return a;
  };
  var setValue = function(e, k, ...vs) {
    var ve = elt(e, `.v.${k}`);
    ve.innerHTML = '';
    vs.flat().forEach(function(v) {
      if (typeof v === 'string') {
        ve.appendChild(document.createTextNode(v)); }
      else if (v === undefined || v === null) {
        }
      else {
        ve.appendChild(v); }
    });
  };
  var makeGrid = function(h, tes) {
    var te = elt('#creature_template').content.cloneNode(true);
    var hde = c('span.hd', '' + h.hd);
    var hpe = c('span.hp', '(', c('code', 'hp'), '' + h.hp, ')');
    setValue(te, 'hd', hde, hpe);
    setValue(te, 'ac', h.ac);
    elt(te, '.v.ac').appendChild(c('div.bx', computeDescAc(h.ac)));
    setValue(te, 'ini', h.ini);
    setValue(te, 'att', listAttacks(h.attack));
    elt(te, '.v.att').appendChild(c('div.bx', computeThac0(h.attack) + '→0'));
    setValue(te, 'sav', `1d20 + ${h.hd2} ≥`, htoe(h.savh));
    setValue(te, 'mor', `2d6 ≤ ${h.morale}`);
    setValue(te, 'siz', sizes[h.size]);
    setValue(te, 'mov', listMovements(h.move));
    elt(te, '.v.mov').appendChild(c('div.bx', listBxMovements(h.move)));
    var dch = {
      str: h.dcs.str, con: h.dcs.con, dex: h.dcs.dex,
      int: h.dcs.int, wis: h.dcs.wis, cha: h.dcs.cha };
    var dchh = {
      bod: h.dcs.bod, sou: h.dcs.sou,
      phy: h.dcs.phy, eva: h.dcs.eva, men: h.dcs.men, imp: h.dcs.imp };
    var dcse = c('div');
    dcse.appendChild(htoe(dch));
    dcse.appendChild(htoe(dchh));
    setValue(te, 'dcs', dcse);
    setValue(te, 'sks', listSkills(h.skills));
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
      f = f.split(',')[0];
      if (i === j) {
        lie = c('li', ''); lie.appendChild(c('strong', f)); }
      else {
        lie = c('li', f); }
      ule.appendChild(lie);
    });
  });
});

onDocumentReady(function() {

  //
  // rewrite h2

  elts('.creature h2').forEach(function(h2e) {
    h2e.id = h2e.id.replaceAll(/,/g, '');
    var tt = h2e.textContent.trim().split(/ *, */);
    h2e.innerHTML = '';
    h2e.appendChild(c('span', tt.shift()));
    tt.forEach(function(t) { h2e.appendChild(c('span.post', ', ' + t)); });
  });
});

