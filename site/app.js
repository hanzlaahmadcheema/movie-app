// HA MovieApp Download Site — 3D Section Motion & Perspective Engine

document.addEventListener('DOMContentLoaded', () => {
  // 1. Interactive 3D Tilt for Page Sections & Cards
  init3DSectionTilt();

  // 2. Render QR Code for APK Direct Download Link
  const qrContainer = document.getElementById('qrCanvasContainer');
  const apkDownloadUrl = 'https://github.com/hanzlaahmadcheema/movie-app/releases/download/v1.9.1/app-release.apk';

  if (qrContainer) {
    try {
      if (typeof QRCode !== 'undefined') {
        new QRCode(qrContainer, {
          text: apkDownloadUrl,
          width: 180,
          height: 180,
          colorDark: '#ffffff',
          colorLight: '#0d1117',
          correctLevel: QRCode.CorrectLevel.H
        });
      } else {
        const fallbackImg = document.createElement('img');
        fallbackImg.src = `https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=${encodeURIComponent(apkDownloadUrl)}&color=ffffff&bcolor=0d1117`;
        fallbackImg.alt = 'HA MovieApp APK Download QR Code';
        fallbackImg.className = 'qr-img';
        qrContainer.appendChild(fallbackImg);
      }
    } catch (e) {
      console.warn('QR Code generation fallback triggered:', e);
      const fallbackImg = document.createElement('img');
      fallbackImg.src = `https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=${encodeURIComponent(apkDownloadUrl)}&color=ffffff&bcolor=0d1117`;
      fallbackImg.alt = 'HA MovieApp APK Download QR Code';
      fallbackImg.className = 'qr-img';
      qrContainer.appendChild(fallbackImg);
    }
  }

  // 3. Mobile Menu Toggle
  const menuToggle = document.getElementById('menuToggle');
  const navMenu = document.getElementById('navMenu');

  if (menuToggle && navMenu) {
    menuToggle.addEventListener('click', () => {
      navMenu.classList.toggle('active');
      const expanded = navMenu.classList.contains('active');
      menuToggle.setAttribute('aria-expanded', expanded);
    });

    // Close menu when clicking links
    document.querySelectorAll('.nav-link').forEach(link => {
      link.addEventListener('click', () => {
        navMenu.classList.remove('active');
      });
    });
  }

  // 4. Scroll Progress Fallback
  if (!CSS.supports('animation-timeline', 'scroll()')) {
    const progress = document.querySelector('#progress');
    if (progress) {
      window.addEventListener('scroll', () => {
        const scrollable = document.documentElement.scrollHeight - window.innerHeight;
        const scrolled = window.scrollY;
        const progressPercentage = scrollable > 0 ? (scrolled / scrollable) : 0;
        progress.style.transform = `scaleX(${progressPercentage})`;
      });
    }
  }

  // 5. Download APK Button Feedback
  const downloadBtns = document.querySelectorAll('a[href*="app-release.apk"]');
  downloadBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      showToast('Downloading HA MovieApp v1.9.1 APK...');
    });
  });

  // 6. 3D Scroll Reveal Intersection Observer for Sections
  const observerOptions = {
    root: null,
    rootMargin: '0px 0px -60px 0px',
    threshold: 0.1
  };

  const scrollObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, observerOptions);

  document.querySelectorAll('section, .glass-card, .timeline-item').forEach(el => {
    el.classList.add('animate-3d-section');
    scrollObserver.observe(el);
  });
});

/* ==========================================================================
   3D Section Tilt Engine (Multi-Layer Depth Parallax)
   ========================================================================== */
function init3DSectionTilt() {
  const tiltElements = document.querySelectorAll('.glass-card, .download-box, .hero-visual');

  tiltElements.forEach(el => {
    el.addEventListener('mousemove', (e) => {
      const rect = el.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      const centerX = rect.width / 2;
      const centerY = rect.height / 2;

      const rotateX = ((y - centerY) / centerY) * -6;
      const rotateY = ((x - centerX) / centerX) * 6;

      el.style.transform = `perspective(1200px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateZ(12px) scale3d(1.015, 1.015, 1.015)`;
    });

    el.addEventListener('mouseleave', () => {
      el.style.transform = 'perspective(1200px) rotateX(0deg) rotateY(0deg) translateZ(0px) scale3d(1, 1, 1)';
    });
  });
}

// Toast Feedback System
function showToast(message) {
  let toast = document.getElementById('site-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'site-toast';
    toast.style.cssText = `
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: #10b981;
      color: #000;
      font-family: var(--font-body);
      font-weight: 700;
      font-size: 0.9rem;
      padding: 12px 24px;
      border-radius: 12px;
      z-index: 9999;
      transform: translateY(100px);
      opacity: 0;
      transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    `;
    document.body.appendChild(toast);
  }
  toast.textContent = message;
  toast.style.transform = 'translateY(0)';
  toast.style.opacity = '1';

  setTimeout(() => {
    toast.style.transform = 'translateY(100px)';
    toast.style.opacity = '0';
  }, 3500);
}
