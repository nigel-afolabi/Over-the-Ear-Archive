<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Over the Ear</title>
    <style>
        :root {
            --bg: #0d0d0d;
            --panel: rgba(18, 18, 18, 0.88);
            --ink: #f5f1ea;
            --muted: #b8b0a7;
            --line: rgba(255, 255, 255, 0.09);
            --accent: #ff1493;
            --accent-soft: #ff69b4;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        html, body {
            width: 100%;
            min-height: 100%;
            background: var(--bg);
            color: var(--ink);
            font-family: "Segoe UI", Helvetica, Arial, sans-serif;
            overflow: hidden;
        }

        body {
            background-image:
                radial-gradient(circle at top, rgba(255, 20, 147, 0.08), transparent 28%),
                linear-gradient(180deg, #0b0b0b 0%, #121212 100%);
        }

        .hero-container {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background:
                linear-gradient(180deg, rgba(8, 8, 8, 0.48), rgba(8, 8, 8, 0.82)),
                url('assets/img/mybackground.png') center/cover no-repeat;
            background-size: cover;
            background-position: center center;
            overflow: hidden;
        }

        .hero-container::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(12, 12, 12, 0.48);
            backdrop-filter: blur(2px) saturate(0.7);
            -webkit-backdrop-filter: blur(2px) saturate(0.7);
        }

        .hero-overlay {
            position: absolute;
            inset: 0;
            background:
                linear-gradient(180deg, rgba(8,8,8,0.15), rgba(8,8,8,0.72)),
                repeating-linear-gradient(
                    0deg,
                    rgba(255,255,255,0.02),
                    rgba(255,255,255,0.02) 1px,
                    transparent 1px,
                    transparent 3px
                );
            border: 1px solid var(--line);
            z-index: 0;
        }

        .ui-wrapper {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: 1.4rem;
            padding: 2rem;
            animation: introFloat 1.2s ease-out both;
        }

        .main-title {
            margin: 0;
            font-size: clamp(3.2rem, 5vw, 6rem);
            font-weight: 500;
            letter-spacing: 0.08em;
            text-transform: lowercase;
            line-height: 0.9;
            color: var(--ink);
            text-shadow: 0 0 30px rgba(255, 20, 147, 0.18);
        }

        .enter-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 140px;
            padding: 0.7rem 1.1rem;
            border: 1px solid var(--line);
            background: rgba(255,255,255,0.02);
            color: var(--ink);
            text-decoration: none;
            text-transform: lowercase;
            letter-spacing: 0.24em;
            font-size: 0.78rem;
            transition: border-color 0.2s ease, color 0.2s ease, background 0.2s ease, transform 0.2s ease;
        }

        .enter-btn:hover {
            border-color: rgba(255, 105, 180, 0.7);
            background: rgba(255, 105, 180, 0.08);
            color: var(--accent-soft);
            transform: translateY(-1px);
        }

        .static-glow {
            position: absolute;
            inset: 0;
            pointer-events: none;
            background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.055) 48%, transparent 100%);
            mix-blend-mode: screen;
            opacity: 0.75;
            animation: staticSweep 4.2s ease-in-out infinite alternate;
            z-index: 1;
        }

        @keyframes introFloat {
            from {
                opacity: 0;
                transform: translateY(18px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes staticSweep {
            0% {
                transform: translateX(-10%);
                opacity: 0.4;
            }
            100% {
                transform: translateX(10%);
                opacity: 0.8;
            }
        }
    </style>
</head>
<body>
    <div class="hero-container" id="hero">
        <div class="hero-overlay"></div>
        <div class="static-glow"></div>
        <div class="ui-wrapper">
            <h1 class="main-title">over the ear.</h1>
            <a href="${pageContext.request.contextPath}/latest" class="enter-btn" id="enter-btn">enter</a>
        </div>
    </div>
</body>
</html>