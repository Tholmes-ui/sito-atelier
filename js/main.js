/* ==========================================================================
   ATELIER — JavaScript del sito
   Due sole funzioni:
   A. Il carosello della sezione "lavori" (scorre da destra a sinistra)
   B. L'invio del modulo di contatto tramite Web3Forms
   ========================================================================== */

(function () {
  'use strict';

  /* ======================================================================
     A. CAROSELLO HERO
     ====================================================================== */
  function initCarousel(root) {
    var slides = Array.prototype.slice.call(root.querySelectorAll('[data-slide]'));
    var dotsWrap = root.querySelector('[data-dots]');
    var prevBtn = root.querySelector('[data-prev]');
    var nextBtn = root.querySelector('[data-next]');
    if (slides.length === 0) return;

    var AUTOPLAY_MS = 5000;
    var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var index = 0;
    var timer = null;

    // Crea i pallini dinamicamente, uno per foto
    var dots = slides.map(function (_, i) {
      var b = document.createElement('button');
      b.type = 'button';
      b.className = 'hero-dot';
      b.setAttribute('aria-label', 'Vai alla foto ' + (i + 1));
      b.addEventListener('click', function () {
        goTo(i);
        start();
      });
      dotsWrap.appendChild(b);
      return b;
    });

    function goTo(i) {
      index = (i + slides.length) % slides.length; // fa il "giro" in modo continuo
      slides.forEach(function (s, k) {
        s.classList.toggle('is-active', k === index);
      });
      dots.forEach(function (d, k) {
        d.classList.toggle('is-active', k === index);
        d.setAttribute('aria-current', k === index ? 'true' : 'false');
      });
    }

    function next() { goTo(index + 1); }
    function prev() { goTo(index - 1); }

    function start() {
      if (reduceMotion) return; // nessuna rotazione automatica se l'utente l'ha disattivata
      stop();
      timer = window.setInterval(next, AUTOPLAY_MS);
    }
    function stop() {
      if (timer !== null) {
        window.clearInterval(timer);
        timer = null;
      }
    }

    if (nextBtn) nextBtn.addEventListener('click', function () { next(); start(); });
    if (prevBtn) prevBtn.addEventListener('click', function () { prev(); start(); });

    // Pausa quando il mouse è sopra o il carosello ha il focus
    root.addEventListener('mouseenter', stop);
    root.addEventListener('mouseleave', start);
    root.addEventListener('focusin', stop);
    root.addEventListener('focusout', start);

    // Frecce della tastiera
    root.addEventListener('keydown', function (e) {
      if (e.key === 'ArrowRight') { next(); start(); }
      if (e.key === 'ArrowLeft') { prev(); start(); }
    });

    // Scorri con il dito su mobile
    var touchStartX = null;
    root.addEventListener('touchstart', function (e) {
      touchStartX = e.changedTouches[0].clientX;
      stop();
    }, { passive: true });
    root.addEventListener('touchend', function (e) {
      if (touchStartX === null) return;
      var delta = e.changedTouches[0].clientX - touchStartX;
      if (Math.abs(delta) > 45) { delta < 0 ? next() : prev(); }
      touchStartX = null;
      start();
    }, { passive: true });

    // Pausa quando la scheda non è visibile (risparmia risorse)
    document.addEventListener('visibilitychange', function () {
      document.hidden ? stop() : start();
    });

    goTo(0);
    start();
  }

  /* ======================================================================
     B. MODULO DI CONTATTO (Web3Forms)
     ====================================================================== */
  function initForm(form) {
    var status = form.querySelector('.form-status');
    var button = form.querySelector('button[type="submit"]');
    var keyInput = form.querySelector('input[name="access_key"]');

    function setStatus(message, type) {
      status.textContent = message;
      status.className = 'form-status' + (type ? ' is-' + type : '');
    }

    form.addEventListener('submit', function (event) {
      // Se JS è attivo gestiamo noi l'invio; altrimenti il form funziona
      // comunque come invio classico (action + method nell'HTML).
      event.preventDefault();

      // Controllo che la chiave sia stata configurata
      var key = keyInput ? keyInput.value.trim() : '';
      if (!key || key.indexOf('INSERISCI') !== -1) {
        setStatus('Modulo non ancora configurato: inserisci la tua access key di Web3Forms nel file index.html (vedi README.md).', 'error');
        return;
      }

      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }

      var originalLabel = button.textContent;
      button.disabled = true;
      button.textContent = 'Invio in corso…';
      setStatus('', '');

      var payload = Object.fromEntries(new FormData(form));

      fetch(form.action, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
        body: JSON.stringify(payload)
      })
        .then(function (res) {
          return res.json().catch(function () { return {}; }).then(function (data) {
            return { ok: res.ok, data: data };
          });
        })
        .then(function (result) {
          if (result.ok && result.data && result.data.success) {
            form.reset();
            setStatus('Grazie! La tua richiesta è stata inviata. Ti ricontatterò il prima possibile.', 'success');
          } else {
            throw new Error((result.data && result.data.message) || 'Errore di invio');
          }
        })
        .catch(function () {
          setStatus('Non è stato possibile inviare il messaggio. Riprova tra poco, oppure scrivimi direttamente via email o telefono.', 'error');
        })
        .finally(function () {
          button.disabled = false;
          button.textContent = originalLabel;
        });
    });
  }

  /* ======================================================================
     C. ANIMAZIONE ALLO SCROLL + ANNO NEL FOOTER
     ====================================================================== */
  function initReveal() {
    var items = document.querySelectorAll('[data-reveal]');
    if (!items.length) return;

    if (!('IntersectionObserver' in window)) {
      items.forEach(function (el) { el.classList.add('is-visible'); });
      return;
    }

    var observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.15 });

    items.forEach(function (el) { observer.observe(el); });
  }

  function initYear() {
    var yearEl = document.getElementById('year');
    if (yearEl) yearEl.textContent = String(new Date().getFullYear());
  }

  /* ======================================================================
     D. EFFETTO "SI ACCENDE" SUI CONTATTI
     Quando si clicca un link che porta a #contatti:
       - "Contatti"                  -> si illumina la zona dei recapiti;
       - "Richiedi (un) preventivo"  -> si illumina il modulo da compilare.
     Così l'occhio cade subito sul punto giusto.
     ====================================================================== */
  function initContactGlow(form) {
    var facts = document.querySelector('.contact-facts');
    if (!facts && !form) return;

    var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var timers = new WeakMap();

    // Fa "accendere" un elemento: gli mette la classe is-lit per 2 secondi.
    function flash(el) {
      if (!el || reduceMotion) return; // rispetta chi ha disattivato le animazioni
      el.classList.remove('is-lit');
      void el.offsetWidth; // trucco: "resetta" l'animazione se si clicca più volte
      el.classList.add('is-lit');
      var previous = timers.get(el);
      if (previous) window.clearTimeout(previous);
      timers.set(el, window.setTimeout(function () {
        el.classList.remove('is-lit');
      }, 2000));
    }

    // Tutti i link che portano alla sezione contatti (header, hero, footer).
    // Decido COSA illuminare in base al testo del link.
    document.querySelectorAll('a[href="#contatti"]').forEach(function (link) {
      var illuminaModulo = /preventivo/i.test(link.textContent || '');
      link.addEventListener('click', function () {
        // piccolo ritardo: così il lampo parte quando lo scroll fluido è arrivato
        window.setTimeout(function () {
          flash(illuminaModulo ? form : facts);
        }, 350);
      });
    });

    // Se la pagina si apre già con #contatti nell'indirizzo
    if (window.location.hash === '#contatti') {
      window.setTimeout(function () { flash(facts); }, 500);
    }
  }

  /* ======================================================================
     AVVIO
     ====================================================================== */
  document.addEventListener('DOMContentLoaded', function () {
    var slider = document.querySelector('[data-slider]');
    if (slider) initCarousel(slider);

    var form = document.getElementById('contact-form');
    if (form) initForm(form);

    initReveal();
    initYear();
    initContactGlow(form);
  });
})();
