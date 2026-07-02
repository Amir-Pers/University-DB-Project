/* ===========================================================
   کاروان — انیمیشن بک‌گراند بخش هیرو (بزرگراه پرسپکتیو)
   یه صحنه‌ی جاده با ماشین/موتور در حال حرکت به‌سمت بیننده،
   افق شهر، خورشید/ماه و ستاره‌ها. کاملا سبک و مرتبط با موضوع
   خرید و فروش خودرو. با پرفورمنس و prefers-reduced-motion سازگاره.
=========================================================== */
(function(){
  const canvas = document.getElementById('heroRoad');
  if(!canvas || !canvas.getContext) return;
  const ctx = canvas.getContext('2d');

  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  let W = 0, H = 0, DPR = Math.min(window.devicePixelRatio || 1, 2);
  let colors = readColors();
  let running = false;
  let rafId = null;
  let lastT = 0;

  /* ---------- خواندن رنگ‌ها از متغیرهای CSS تم فعلی ---------- */
  function readColors(){
    const cs = getComputedStyle(document.documentElement);
    const isLight = document.documentElement.getAttribute('data-theme') === 'light';
    return {
      isLight,
      amber: cs.getPropertyValue('--amber').trim() || '#f5a524',
      teal: cs.getPropertyValue('--teal').trim() || '#2dd4bf',
      text: cs.getPropertyValue('--text').trim() || '#f1f1f3',
      line: cs.getPropertyValue('--line').trim() || '#2c2f37',
    };
  }

  /* ---------- تبدیل hex به rgba ---------- */
  function hexToRgba(hex, a){
    let h = hex.replace('#','').trim();
    if(h.length === 3) h = h.split('').map(c=>c+c).join('');
    const r = parseInt(h.substring(0,2),16);
    const g = parseInt(h.substring(2,4),16);
    const b = parseInt(h.substring(4,6),16);
    if(isNaN(r)||isNaN(g)||isNaN(b)) return `rgba(245,165,36,${a})`;
    return `rgba(${r},${g},${b},${a})`;
  }

  /* ---------- تنظیم اندازه‌ی کانواس ---------- */
  function resize(){
    const rect = canvas.parentElement.getBoundingClientRect();
    W = Math.max(1, rect.width);
    H = Math.max(1, rect.height);
    canvas.width = Math.round(W * DPR);
    canvas.height = Math.round(H * DPR);
    canvas.style.width = W + 'px';
    canvas.style.height = H + 'px';
    ctx.setTransform(DPR,0,0,DPR,0,0);
  }

  /* ---------- ستاره‌های ثابت (فقط تم تیره) ---------- */
  let stars = [];
  function buildStars(){
    stars = [];
    const count = Math.round((W*H)/9000);
    for(let i=0;i<count;i++){
      stars.push({
        x: Math.random(),
        y: Math.random()*0.55,
        r: Math.random()*1.1 + 0.3,
        tw: Math.random()*Math.PI*2
      });
    }
  }

  /* ---------- ابرهای دوردست ---------- */
  let clouds = [];
  function buildClouds(){
    clouds = [];
    for(let i=0;i<4;i++){
      clouds.push({
        x: Math.random(),
        y: 0.08 + Math.random()*0.28,
        s: 0.5 + Math.random()*0.9,
        speed: 0.002 + Math.random()*0.003
      });
    }
  }

  /* ---------- ساختمان‌های افق (شهر) ---------- */
  let skyline = [];
  function buildSkyline(){
    skyline = [];
    let x = -0.05;
    while(x < 1.05){
      const w = 0.02 + Math.random()*0.045;
      const h = 0.02 + Math.random()*0.09;
      skyline.push({x, w, h, lit: Math.random() > 0.45});
      x += w + 0.004;
    }
  }

  /* ---------- ماشین‌های در حال حرکت روی جاده ---------- */
  const CAR_COUNT = 6;
  let cars = [];
  function buildCars(){
    cars = [];
    for(let i=0;i<CAR_COUNT;i++) cars.push(makeCar(true));
  }
  function makeCar(randomStart){
    const kinds = ['car','car','car','moto'];
    const kind = kinds[Math.floor(Math.random()*kinds.length)];
    const paletteKeys = ['amber','teal','neutral','neutral'];
    const palette = paletteKeys[Math.floor(Math.random()*paletteKeys.length)];
    return {
      lane: (Math.random()*2 - 1), // -1..1 نسبت به مرکز جاده
      t: randomStart ? Math.random() : 0, // 0 = نزدیک افق ، 1 = نزدیک بیننده
      speed: 0.10 + Math.random()*0.09,
      kind,
      palette,
      wobble: Math.random()*Math.PI*2
    };
  }

  /* ---------- هندسه‌ی پرسپکتیو جاده ---------- */
  function roadGeom(){
    const horizonY = H * 0.40;
    const bottomY = H * 1.05;
    const cx = W * 0.5;
    const topHalfWidth = W * 0.035;
    const bottomHalfWidth = W * 0.62;
    return {horizonY, bottomY, cx, topHalfWidth, bottomHalfWidth};
  }
  function roadXAt(t, laneOffset, g){
    const halfW = g.topHalfWidth + (g.bottomHalfWidth - g.topHalfWidth) * t;
    return g.cx + laneOffset * halfW * 0.62;
  }
  function roadYAt(t, g){
    return g.horizonY + (g.bottomY - g.horizonY) * t;
  }

  /* ---------- رسم آسمان ---------- */
  function drawSky(g){
    const grad = ctx.createLinearGradient(0,0,0,g.horizonY);
    if(colors.isLight){
      grad.addColorStop(0, '#bfe0f5');
      grad.addColorStop(0.6, '#eef2ee');
      grad.addColorStop(1, hexToRgba(colors.amber,0.35));
    } else {
      grad.addColorStop(0, '#0c0d12');
      grad.addColorStop(0.55, '#181a22');
      grad.addColorStop(1, hexToRgba(colors.amber,0.28));
    }
    ctx.fillStyle = grad;
    ctx.fillRect(0,0,W,g.horizonY+2);

    // ستاره‌ها (تم تیره)
    if(!colors.isLight){
      stars.forEach(s=>{
        const tw = 0.55 + 0.45*Math.sin(s.tw);
        ctx.globalAlpha = tw;
        ctx.fillStyle = '#ffffff';
        ctx.beginPath();
        ctx.arc(s.x*W, s.y*g.horizonY, s.r, 0, Math.PI*2);
        ctx.fill();
      });
      ctx.globalAlpha = 1;
    }

    // ابرها
    clouds.forEach(c=>{
      const cxp = ((c.x*1.3) % 1.3 - 0.15) * W;
      const cyp = c.y * g.horizonY;
      const s = c.s * (W*0.06);
      ctx.fillStyle = colors.isLight ? 'rgba(255,255,255,.75)' : 'rgba(255,255,255,.06)';
      ctx.beginPath();
      ctx.ellipse(cxp, cyp, s, s*0.42, 0, 0, Math.PI*2);
      ctx.ellipse(cxp + s*0.7, cyp+s*0.08, s*0.7, s*0.34, 0, 0, Math.PI*2);
      ctx.ellipse(cxp - s*0.6, cyp+s*0.1, s*0.55, s*0.3, 0, 0, Math.PI*2);
      ctx.fill();
    });

    // خورشید/ماه با هاله
    const sunX = W*0.66, sunY = g.horizonY*0.62, sunR = W*0.028;
    const glow = ctx.createRadialGradient(sunX,sunY,0,sunX,sunY,sunR*6);
    glow.addColorStop(0, hexToRgba(colors.amber, colors.isLight?0.55:0.45));
    glow.addColorStop(1, hexToRgba(colors.amber, 0));
    ctx.fillStyle = glow;
    ctx.beginPath(); ctx.arc(sunX,sunY,sunR*6,0,Math.PI*2); ctx.fill();
    ctx.fillStyle = colors.isLight ? '#fff6e6' : hexToRgba(colors.amber,0.9);
    ctx.beginPath(); ctx.arc(sunX,sunY,sunR,0,Math.PI*2); ctx.fill();
  }

  /* ---------- رسم افق شهر ---------- */
  function drawSkyline(g){
    ctx.fillStyle = colors.isLight ? 'rgba(120,110,95,.28)' : 'rgba(0,0,0,.55)';
    skyline.forEach(b=>{
      const x = b.x*W, w = b.w*W, h = b.h*g.horizonY*3.2;
      ctx.fillRect(x, g.horizonY - h, w, h+2);
      if(b.lit){
        ctx.fillStyle = hexToRgba(colors.amber, colors.isLight?0.5:0.7);
        const wx = x + w*0.3, wy = g.horizonY - h*0.6;
        ctx.fillRect(wx, wy, Math.max(1,w*0.18), Math.max(1,w*0.18));
        ctx.fillStyle = colors.isLight ? 'rgba(120,110,95,.28)' : 'rgba(0,0,0,.55)';
      }
    });
  }

  /* ---------- رسم سطح و خطوط جاده ---------- */
  function drawRoad(g){
    // سطح جاده
    ctx.beginPath();
    ctx.moveTo(g.cx - g.topHalfWidth, g.horizonY);
    ctx.lineTo(g.cx + g.topHalfWidth, g.horizonY);
    ctx.lineTo(g.cx + g.bottomHalfWidth, g.bottomY);
    ctx.lineTo(g.cx - g.bottomHalfWidth, g.bottomY);
    ctx.closePath();
    const roadGrad = ctx.createLinearGradient(0,g.horizonY,0,g.bottomY);
    if(colors.isLight){
      roadGrad.addColorStop(0,'#d9d4c8');
      roadGrad.addColorStop(1,'#f2efe8');
    } else {
      roadGrad.addColorStop(0,'#22242b');
      roadGrad.addColorStop(1,'#0f1013');
    }
    ctx.fillStyle = roadGrad;
    ctx.fill();

    // لبه‌های درخشان جاده
    ctx.save();
    ctx.strokeStyle = hexToRgba(colors.amber, colors.isLight?0.55:0.8);
    ctx.lineWidth = 2;
    ctx.shadowColor = colors.amber;
    ctx.shadowBlur = 8;
    ctx.beginPath();
    ctx.moveTo(g.cx - g.topHalfWidth, g.horizonY);
    ctx.lineTo(g.cx - g.bottomHalfWidth, g.bottomY);
    ctx.moveTo(g.cx + g.topHalfWidth, g.horizonY);
    ctx.lineTo(g.cx + g.bottomHalfWidth, g.bottomY);
    ctx.stroke();
    ctx.restore();

    // خط وسط چین‌دار با پرسپکتیو، همراه با حرکت
    const dashSpeed = reduceMotion ? 0 : (performance.now()/900) % 1;
    ctx.fillStyle = colors.isLight ? 'rgba(120,110,95,.6)' : 'rgba(255,255,255,.55)';
    const segs = 14;
    for(let i=0;i<segs;i++){
      let t0 = (i/segs + dashSpeed) % 1;
      let t1 = t0 + (0.5/segs);
      if(t1 > 1) continue;
      const y0 = roadYAt(t0,g), y1 = roadYAt(t1,g);
      const x0 = roadXAt(t0,0,g), x1 = roadXAt(t1,0,g);
      const w0 = (g.topHalfWidth + (g.bottomHalfWidth-g.topHalfWidth)*t0) * 0.02;
      const w1 = (g.topHalfWidth + (g.bottomHalfWidth-g.topHalfWidth)*t1) * 0.02;
      ctx.beginPath();
      ctx.moveTo(x0-w0,y0); ctx.lineTo(x0+w0,y0);
      ctx.lineTo(x1+w1,y1); ctx.lineTo(x1-w1,y1);
      ctx.closePath();
      ctx.fill();
    }
  }

  /* ---------- رسم یک ماشین/موتور ساده و شیک ---------- */
  function drawVehicle(x, y, scale, kind, palette){
    const baseColor = palette === 'amber' ? colors.amber
                     : palette === 'teal' ? colors.teal
                     : (colors.isLight ? '#4b4a46' : '#c9cad2');
    ctx.save();
    ctx.translate(x,y);
    if(kind === 'moto'){
      const w = 18*scale, h = 26*scale;
      // چراغ جلو (هاله)
      ctx.fillStyle = hexToRgba('#fff6d8', 0.55*scale);
      ctx.beginPath(); ctx.ellipse(0, h*0.62, w*0.7, h*0.35, 0,0,Math.PI*2); ctx.fill();
      // بدنه موتور
      ctx.fillStyle = baseColor;
      ctx.beginPath();
      ctx.ellipse(0, 0, w*0.32, h*0.5, 0, 0, Math.PI*2);
      ctx.fill();
      ctx.fillStyle = colors.isLight ? '#2a2822' : '#0d0e11';
      ctx.beginPath(); ctx.ellipse(0, -h*0.28, w*0.22, h*0.16, 0,0,Math.PI*2); ctx.fill();
      // چراغ جلو نقطه‌ای روشن
      ctx.fillStyle = '#fff6d8';
      ctx.beginPath(); ctx.arc(0, h*0.42, Math.max(1,w*0.12), 0, Math.PI*2); ctx.fill();
    } else {
      const w = 46*scale, h = 30*scale;
      // هاله چراغ جلو
      const gg = ctx.createRadialGradient(0,h*0.5,0,0,h*0.5,w*0.9);
      gg.addColorStop(0, hexToRgba('#fff6d8', 0.5*scale));
      gg.addColorStop(1, hexToRgba('#fff6d8', 0));
      ctx.fillStyle = gg;
      ctx.beginPath(); ctx.ellipse(0,h*0.55,w*0.9,h*0.6,0,0,Math.PI*2); ctx.fill();

      // بدنه
      ctx.fillStyle = baseColor;
      roundRect(-w/2, -h*0.38, w, h*0.78, h*0.28);
      ctx.fill();
      // کابین/شیشه
      ctx.fillStyle = colors.isLight ? 'rgba(35,33,28,.55)' : 'rgba(10,11,14,.75)';
      roundRect(-w*0.28, -h*0.66, w*0.56, h*0.4, h*0.16);
      ctx.fill();
      // چراغ‌های جلو
      ctx.fillStyle = '#fff6d8';
      ctx.beginPath(); ctx.arc(-w*0.32, h*0.14, Math.max(1,w*0.06), 0, Math.PI*2); ctx.fill();
      ctx.beginPath(); ctx.arc(w*0.32, h*0.14, Math.max(1,w*0.06), 0, Math.PI*2); ctx.fill();
    }
    ctx.restore();
  }
  function roundRect(x,y,w,h,r){
    ctx.beginPath();
    ctx.moveTo(x+r,y);
    ctx.arcTo(x+w,y,x+w,y+h,r);
    ctx.arcTo(x+w,y+h,x,y+h,r);
    ctx.arcTo(x,y+h,x,y,r);
    ctx.arcTo(x,y,x+w,y,r);
    ctx.closePath();
  }

  /* ---------- به‌روزرسانی و رسم ماشین‌ها ---------- */
  function drawCars(g, dt){
    const sorted = [...cars].sort((a,b)=>a.t-b.t);
    sorted.forEach(c=>{
      if(!reduceMotion){
        c.t += c.speed * dt;
        if(c.t > 1.08){
          Object.assign(c, makeCar(false));
        }
      }
      const t = Math.min(c.t, 1.08);
      const x = roadXAt(t, c.lane, g);
      const y = roadYAt(t, g);
      const scale = 0.12 + t*1.15;
      const alpha = t < 0.06 ? t/0.06 : (t > 1 ? Math.max(0,1-(t-1)/0.08) : 1);
      ctx.globalAlpha = Math.max(0, Math.min(1, alpha));
      drawVehicle(x, y, scale, c.kind, c.palette);
      ctx.globalAlpha = 1;
    });
  }

  /* ---------- حلقه‌ی اصلی رسم ---------- */
  function frame(now){
    if(!running) return;
    const dt = lastT ? Math.min(2, (now-lastT)/1000) : 0;
    lastT = now;

    ctx.clearRect(0,0,W,H);
    const g = roadGeom();
    drawSky(g);
    drawSkyline(g);
    drawRoad(g);
    drawCars(g, dt);

    if(!reduceMotion) rafId = requestAnimationFrame(frame);
  }

  function drawStaticFrame(){
    ctx.clearRect(0,0,W,H);
    const g = roadGeom();
    drawSky(g);
    drawSkyline(g);
    drawRoad(g);
    drawCars(g, 0);
  }

  function start(){
    if(running) return;
    running = true;
    lastT = 0;
    if(reduceMotion){ drawStaticFrame(); }
    else rafId = requestAnimationFrame(frame);
  }
  function stop(){
    running = false;
    if(rafId) cancelAnimationFrame(rafId);
    rafId = null;
  }

  function rebuildScene(){
    resize();
    buildStars();
    buildClouds();
    buildSkyline();
    if(cars.length === 0) buildCars();
    if(reduceMotion) drawStaticFrame();
  }

  /* ---------- رویدادها ---------- */
  let resizeTimer;
  window.addEventListener('resize', ()=>{
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(rebuildScene, 150);
  });

  document.addEventListener('visibilitychange', ()=>{
    if(document.hidden) stop(); else if(inView) start();
  });

  let inView = true;
  if('IntersectionObserver' in window){
    const io = new IntersectionObserver(entries=>{
      entries.forEach(e=>{
        inView = e.isIntersecting;
        if(inView && !document.hidden) start(); else stop();
      });
    }, {threshold: 0.01});
    io.observe(canvas);
  }

  // به‌روزرسانی رنگ‌ها هنگام تغییر تم
  const themeObserver = new MutationObserver(()=>{
    colors = readColors();
    if(reduceMotion) drawStaticFrame();
  });
  themeObserver.observe(document.documentElement, {attributes:true, attributeFilter:['data-theme']});

  rebuildScene();
  if(!reduceMotion) start();
})();
