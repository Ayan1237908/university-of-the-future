document.addEventListener("DOMContentLoaded", function () {
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    const renderer = new THREE.WebGLRenderer({ canvas: document.getElementById("three-canvas"), alpha: true });

    renderer.setSize(window.innerWidth, window.innerHeight * 0.6);
    document.getElementById("canvas-container").appendChild(renderer.domElement);

    // Создаем сферу (глобус)
    const geometry = new THREE.SphereGeometry(2, 32, 32);
    const material = new THREE.MeshBasicMaterial({ color: 0x00ffcc, wireframe: true });
    const sphere = new THREE.Mesh(geometry, material);
    scene.add(sphere);

    camera.position.z = 5;

    function animate() {
        requestAnimationFrame(animate);
        sphere.rotation.y += 0.005;
        renderer.render(scene, camera);
    }

    animate();

    // Адаптация к изменению размера окна
    window.addEventListener("resize", () => {
        renderer.setSize(window.innerWidth, window.innerHeight * 0.6);
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
    });
});