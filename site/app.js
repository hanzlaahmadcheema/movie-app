// HA MovieApp Download Site — Interactive Script with Three.js 3D Moving Blocks

document.addEventListener('DOMContentLoaded', () => {
  // 1. Three.js Interactive 3D Moving Blocks Engine
  init3DMovingBlocks();

  // 2. Interactive 3D Tilt Effect on Feature & Mockup Cards
  init3DCardTilt();

  // 3. Render QR Code for APK Direct Download Link
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

  // 4. Mobile Menu Toggle
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

  // 5. Scroll Progress Fallback
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

  // 6. Download APK Button Feedback
  const downloadBtns = document.querySelectorAll('a[href*="app-release.apk"]');
  downloadBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      showToast('Downloading HA MovieApp v1.9.1 APK...');
    });
  });

  // 7. Scroll Reveal Intersection Observer
  const observerOptions = {
    root: null,
    rootMargin: '0px 0px -40px 0px',
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

  document.querySelectorAll('.glass-card, .timeline-item, .section-header').forEach(el => {
    el.classList.add('animate-on-scroll');
    scrollObserver.observe(el);
  });
});

/* ==========================================================================
   Three.js 3D Moving Blocks Engine Implementation
   ========================================================================== */
function init3DMovingBlocks() {
  const canvas = document.getElementById('webgl-3d-blocks');
  if (!canvas || typeof THREE === 'undefined') return;

  // Scene, Camera, Renderer
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 1000);
  camera.position.z = 45;

  const renderer = new THREE.WebGLRenderer({
    canvas: canvas,
    alpha: true,
    antialias: true
  });
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

  // Lighting
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
  scene.add(ambientLight);

  const dirLight1 = new THREE.DirectionalLight(0x00e5ff, 1.2);
  dirLight1.position.set(20, 40, 30);
  scene.add(dirLight1);

  const dirLight2 = new THREE.DirectionalLight(0x10b981, 0.8);
  dirLight2.position.set(-20, -30, 20);
  scene.add(dirLight2);

  // Generate 3D Moving Floating Blocks
  const blocks = [];
  const blockCount = 42;
  const colors = [0x00e5ff, 0x38bdf8, 0x10b981, 0xc084fc];

  for (let i = 0; i < blockCount; i++) {
    const size = 1.8 + Math.random() * 3.5;
    const geometry = new THREE.BoxGeometry(size, size, size);

    // Solid semi-transparent dark body mesh
    const material = new THREE.MeshPhongMaterial({
      color: 0x111726,
      emissive: 0x070b14,
      specular: 0x00e5ff,
      shininess: 40,
      transparent: true,
      opacity: 0.65
    });

    const mesh = new THREE.Mesh(geometry, material);

    // Sharp 3D wireframe edges
    const wireGeo = new THREE.EdgesGeometry(geometry);
    const wireMat = new THREE.LineBasicMaterial({
      color: colors[i % colors.length],
      linewidth: 1.5
    });
    const wireframe = new THREE.LineSegments(wireGeo, wireMat);
    mesh.add(wireframe);

    // Initial 3D Positions
    mesh.position.x = (Math.random() - 0.5) * 90;
    mesh.position.y = (Math.random() - 0.5) * 80;
    mesh.position.z = (Math.random() - 0.5) * 60;

    // Initial 3D Rotations
    mesh.rotation.x = Math.random() * Math.PI;
    mesh.rotation.y = Math.random() * Math.PI;

    // Movement & Rotation Velocity
    const blockData = {
      mesh: mesh,
      vx: (Math.random() - 0.5) * 0.04,
      vy: (Math.random() - 0.5) * 0.04,
      vz: (Math.random() - 0.5) * 0.03,
      rx: (Math.random() - 0.5) * 0.015,
      ry: (Math.random() - 0.5) * 0.015,
      rz: (Math.random() - 0.5) * 0.01
    };

    scene.add(mesh);
    blocks.push(blockData);
  }

  // Mouse Parallax & Scroll Sensitivity Variables
  let mouseX = 0;
  let mouseY = 0;
  let targetMouseX = 0;
  let targetMouseY = 0;

  window.addEventListener('mousemove', (e) => {
    targetMouseX = (e.clientX / window.innerWidth - 0.5) * 12;
    targetMouseY = (e.clientY / window.innerHeight - 0.5) * 12;
  });

  // Animation Loop
  function animate() {
    requestAnimationFrame(animate);

    // Smooth lerp for camera mouse movement
    mouseX += (targetMouseX - mouseX) * 0.05;
    mouseY += (targetMouseY - mouseY) * 0.05;

    camera.position.x = mouseX;
    camera.position.y = -mouseY - (window.scrollY * 0.015);
    camera.lookAt(0, -window.scrollY * 0.015, 0);

    // Update floating 3D blocks position & rotation
    blocks.forEach(b => {
      b.mesh.position.x += b.vx;
      b.mesh.position.y += b.vy;
      b.mesh.position.z += b.vz;

      b.mesh.rotation.x += b.rx;
      b.mesh.rotation.y += b.ry;
      b.mesh.rotation.z += b.rz;

      // Wrap around 3D space bounds
      if (b.mesh.position.x > 50) b.mesh.position.x = -50;
      if (b.mesh.position.x < -50) b.mesh.position.x = 50;
      if (b.mesh.position.y > 45) b.mesh.position.y = -45;
      if (b.mesh.position.y < -45) b.mesh.position.y = 45;
      if (b.mesh.position.z > 20) b.mesh.position.z = -50;
      if (b.mesh.position.z < -50) b.mesh.position.z = 20;
    });

    renderer.render(scene, camera);
  }

  animate();

  // Responsive Reserving
  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });
}

/* ==========================================================================
   3D Card Tilt Micro-Interactions (CSS 3D Perspective)
   ========================================================================== */
function init3DCardTilt() {
  const tiltCards = document.querySelectorAll('.glass-card');

  tiltCards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      const centerX = rect.width / 2;
      const centerY = rect.height / 2;

      const rotateX = ((y - centerY) / centerY) * -8;
      const rotateY = ((x - centerX) / centerX) * 8;

      card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale3d(1.02, 1.02, 1.02)`;
    });

    card.addEventListener('mouseleave', () => {
      card.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)';
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
