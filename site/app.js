// MovieApp Download Site — Interactive Script

document.addEventListener('DOMContentLoaded', () => {
  // 1. Render QR Code for APK Direct Download Link
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
        fallbackImg.alt = 'MovieApp APK Download QR Code';
        fallbackImg.className = 'qr-img';
        qrContainer.appendChild(fallbackImg);
      }
    } catch (e) {
      console.warn('QR Code generation fallback triggered:', e);
      const fallbackImg = document.createElement('img');
      fallbackImg.src = `https://api.qrserver.com/v1/create-qr-code/?size=180x180&data=${encodeURIComponent(apkDownloadUrl)}&color=ffffff&bcolor=0d1117`;
      fallbackImg.alt = 'MovieApp APK Download QR Code';
      fallbackImg.className = 'qr-img';
      qrContainer.appendChild(fallbackImg);
    }
  }

  // 2. Mobile Menu Toggle
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

  // 3. Scroll Progress Fallback for Browsers without CSS scroll-timeline support
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

  // 4. Download APK Button Feedback
  const downloadBtns = document.querySelectorAll('a[href*="app-release.apk"]');
  downloadBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      showToast('Downloading MovieApp v1.9.1 APK...');
    });
  });

  // 5. Lightweight Toast Notification System
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
        box-shadow: 0 10px 25px rgba(16, 185, 129, 0.4);
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
});
