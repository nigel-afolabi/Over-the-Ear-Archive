document.addEventListener("DOMContentLoaded", () => {
    const staticOverlay = document.getElementById('fnaf-static');
    const hero = document.getElementById('hero');
    const glitchText = document.getElementById('glitch-text');

    // Check if they have already seen the intro this session
    if (!sessionStorage.getItem('introPlayed')) {
        
        // --- FULL INTRO (First Time) ---
        setTimeout(() => {
            staticOverlay.style.backgroundImage = 'none';
            if(glitchText) glitchText.style.display = 'none'; 
            staticOverlay.style.backgroundColor = '#000';
            
            setTimeout(() => {
                staticOverlay.style.transition = 'opacity 3s ease-in-out';
                staticOverlay.style.opacity = '0';
                hero.style.opacity = '1';

                setTimeout(() => { staticOverlay.style.display = 'none'; }, 3000);
            }, 300);

        }, 1800); // Glitch runs for 1.8s
        
        // Mark the intro as played so it doesn't happen again
        sessionStorage.setItem('introPlayed', 'true');

    } else {
        
        // --- FAST STATIC (Subsequent Visits) ---
        // Hide the big text immediately
        if(glitchText) glitchText.style.display = 'none';
        
        // Just a quick 300ms flash of static before fading to the hero
        setTimeout(() => {
            staticOverlay.style.backgroundImage = 'none';
            staticOverlay.style.backgroundColor = '#000';
            
            setTimeout(() => {
                staticOverlay.style.transition = 'opacity 1s ease-out';
                staticOverlay.style.opacity = '0';
                hero.style.opacity = '1';

                setTimeout(() => { staticOverlay.style.display = 'none'; }, 1000);
            }, 100);
        }, 300); // Glitch only runs for 0.3s
    }
});