/* ============================================================
   KAREVAN — Animated Ambient Background (Canvas / JS)
   جایگزین بلاب‌های ثابت CSS با یک بک‌گراند متحرک روی canvas که
   با تم روشن/تیره سایت هماهنگ می‌شود (رنگ‌ها از CSS variables خونده میشن).
   شامل: ۳ هاله‌ی نرمِ درحال‌حرکت + گرد و غبار ریز شناور + گاهی یک
   "نور عبوری" مثل چراغ ماشین که از صفحه رد میشه (تم اتومبیل).
   ============================================================ */
(function () {
  "use strict";

  function init() {
    var host = document.querySelector(".bg-ambient");
    if (!host) return; // این صفحه بک‌گراند نداره

    // اگه قبلاً ساخته شده (مثلاً اسکریپت دوبار لود شده) دوباره نساز
    if (host.querySelector(".bg-canvas")) return;

    // بلاب‌های قدیمی CSS رو غیرفعال کن (canvas جایگزینشون میشه)
    var oldBlobs = host.querySelectorAll(".blob");
    oldBlobs.forEach(function (b) {
      b.style.display = "none";
    });

    var canvas = document.createElement("canvas");
    canvas.className = "bg-canvas";
    canvas.style.position = "absolute";
    canvas.style.inset = "0";
    canvas.style.width = "100%";
    canvas.style.height = "100%";
    canvas.style.display = "block";
    // قبل از grain اضافه‌ش کن تا گرین رو بکگراند سوار بمونه
    var grain = host.querySelector(".grain");
    if (grain) host.insertBefore(canvas, grain);
    else host.appendChild(canvas);

    var ctx = canvas.getContext("2d");
    var reduceMotion =
      window.matchMedia &&
      window.matchMedia("(prefers-reduced-motion: reduce)").matches;

    var DPR = Math.min(window.devicePixelRatio || 1, 2);
    var W = 0,
      H = 0;

    function resize() {
      W = window.innerWidth;
      H = window.innerHeight;
      canvas.width = Math.floor(W * DPR);
      canvas.height = Math.floor(H * DPR);
      ctx.setTransform(DPR, 0, 0, DPR, 0, 0);
    }
    resize();
    window.addEventListener("resize", resize);

    // ---------- رنگ‌ها بر اساس تم فعلی ----------
    function hexToRgb(hex) {
      hex = (hex || "").trim().replace("#", "");
      if (hex.length === 3) {
        hex = hex
          .split("")
          .map(function (c) {
            return c + c;
          })
          .join("");
      }
      var num = parseInt(hex, 16);
      if (isNaN(num)) return { r: 245, g: 165, b: 36 };
      return { r: (num >> 16) & 255, g: (num >> 8) & 255, b: num & 255 };
    }

    var colors = { amber: { r: 245, g: 165, b: 36 }, teal: { r: 45, g: 212, b: 191 } };
    var isLight = false;

    function refreshColors() {
      var cs = getComputedStyle(document.documentElement);
      colors.amber = hexToRgb(cs.getPropertyValue("--amber"));
      colors.teal = hexToRgb(cs.getPropertyValue("--teal"));
      isLight = document.documentElement.getAttribute("data-theme") === "light";
    }
    refreshColors();

    // تغییر تم رو زنده تشخیص بده و رنگ‌ها رو آپدیت کن
    var mo = new MutationObserver(function (muts) {
      muts.forEach(function (m) {
        if (m.attributeName === "data-theme") refreshColors();
      });
    });
    mo.observe(document.documentElement, { attributes: true });

    // ---------- هاله‌های بزرگ (جایگزین بلاب‌ها) ----------
    var orbs = [
      { cx: 0.86, cy: 0.06, r: 0.34, color: "amber", sx: 0.05, sy: 0.045, tX: 0, tY: 1.7 },
      { cx: 0.1, cy: 0.92, r: 0.3, color: "teal", sx: 0.038, sy: 0.05, tX: 2.4, tY: 0.6 },
      { cx: 0.55, cy: 0.44, r: 0.2, color: "amber", sx: 0.03, sy: 0.032, tX: 4.1, tY: 3.2 }
    ];

    function drawOrb(orb, t) {
      var driftX = Math.sin(t * orb.sx + orb.tX) * 0.06;
      var driftY = Math.cos(t * orb.sy + orb.tY) * 0.05;
      var scale = 1 + Math.sin(t * orb.sx * 0.7 + orb.tX) * 0.08;

      var x = (orb.cx + driftX) * W;
      var y = (orb.cy + driftY) * H;
      var r = orb.r * Math.max(W, H) * scale;
      var c = colors[orb.color];
      var alpha = isLight ? 0.16 : 0.24;

      var grad = ctx.createRadialGradient(x, y, 0, x, y, r);
      grad.addColorStop(0, "rgba(" + c.r + "," + c.g + "," + c.b + "," + alpha + ")");
      grad.addColorStop(1, "rgba(" + c.r + "," + c.g + "," + c.b + ",0)");
      ctx.fillStyle = grad;
      ctx.beginPath();
      ctx.arc(x, y, r, 0, Math.PI * 2);
      ctx.fill();
    }

    // ---------- گرد و غبار ریز شناور ----------
    var particles = [];
    function makeParticles() {
      var count = Math.round((W * H) / 26000);
      count = Math.max(18, Math.min(70, count));
      particles = [];
      for (var i = 0; i < count; i++) {
        particles.push({
          x: Math.random() * W,
          y: Math.random() * H,
          r: 0.6 + Math.random() * 1.6,
          vx: (Math.random() - 0.5) * 0.12,
          vy: -0.05 - Math.random() * 0.12,
          a: 0.15 + Math.random() * 0.35,
          color: Math.random() > 0.5 ? "amber" : "teal"
        });
      }
    }
    makeParticles();
    window.addEventListener("resize", function () {
      makeParticles();
    });

    function drawParticles() {
      particles.forEach(function (p) {
        p.x += p.vx;
        p.y += p.vy;
        if (p.y < -10) p.y = H + 10;
        if (p.x < -10) p.x = W + 10;
        if (p.x > W + 10) p.x = -10;

        var c = colors[p.color];
        var alpha = p.a * (isLight ? 0.6 : 1);
        ctx.beginPath();
        ctx.fillStyle = "rgba(" + c.r + "," + c.g + "," + c.b + "," + alpha + ")";
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
        ctx.fill();
      });
    }

    // ---------- نور عبوری (مثل چراغ ماشین) ----------
    var streaks = [];
    var nextStreakAt = performance.now() + 3000 + Math.random() * 4000;

    function spawnStreak(now) {
      var fromLeft = Math.random() > 0.5;
      var y = Math.random() * H * 0.9 + H * 0.05;
      streaks.push({
        y: y,
        len: 220 + Math.random() * 180,
        width: 1.5 + Math.random() * 1.5,
        dir: fromLeft ? 1 : -1,
        x: fromLeft ? -260 : W + 260,
        speed: (2.4 + Math.random() * 1.8) * (fromLeft ? 1 : -1),
        color: Math.random() > 0.5 ? "amber" : "teal",
        start: now
      });
      nextStreakAt = now + 5000 + Math.random() * 6000;
    }

    function drawStreaks(now) {
      if (now >= nextStreakAt) spawnStreak(now);

      streaks = streaks.filter(function (s) {
        s.x += s.speed;
        var alive = s.dir === 1 ? s.x < W + 300 : s.x > -300;
        if (!alive) return false;

        var c = colors[s.color];
        var edgeFade = Math.min(1, (W * 0.5 - Math.abs(s.x - W / 2)) / (W * 0.5) + 0.3);
        edgeFade = Math.max(0, Math.min(1, edgeFade));
        var alpha = (isLight ? 0.22 : 0.32) * edgeFade;

        var x1 = s.x - (s.len / 2) * s.dir;
        var x2 = s.x + (s.len / 2) * s.dir;
        var grad = ctx.createLinearGradient(x1, s.y, x2, s.y);
        grad.addColorStop(0, "rgba(" + c.r + "," + c.g + "," + c.b + ",0)");
        grad.addColorStop(0.5, "rgba(" + c.r + "," + c.g + "," + c.b + "," + alpha + ")");
        grad.addColorStop(1, "rgba(" + c.r + "," + c.g + "," + c.b + ",0)");

        ctx.strokeStyle = grad;
        ctx.lineWidth = s.width;
        ctx.lineCap = "round";
        ctx.beginPath();
        ctx.moveTo(x1, s.y);
        ctx.lineTo(x2, s.y);
        ctx.stroke();
        return true;
      });
    }

    // ---------- حلقه‌ی انیمیشن ----------
    var running = true;
    var t0 = performance.now();

    function frame(now) {
      if (!running) return;
      var t = (now - t0) / 1000;

      ctx.clearRect(0, 0, W, H);
      orbs.forEach(function (o) {
        drawOrb(o, t);
      });
      drawParticles();
      drawStreaks(now);

      requestAnimationFrame(frame);
    }

    if (reduceMotion) {
      // فقط یک فریم ثابت بکش و ثابت بمون (بدون انیمیشن مزاحم)
      ctx.clearRect(0, 0, W, H);
      orbs.forEach(function (o) {
        drawOrb(o, 0);
      });
    } else {
      requestAnimationFrame(frame);
    }

    document.addEventListener("visibilitychange", function () {
      if (document.hidden) {
        running = false;
      } else if (!reduceMotion) {
        running = true;
        requestAnimationFrame(frame);
      }
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
