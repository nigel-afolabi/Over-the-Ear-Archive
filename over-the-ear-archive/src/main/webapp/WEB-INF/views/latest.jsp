<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Over the Ear — Latest</title>
    <style>
        :root {
            --bg: #0d0d0d;
            --panel: rgba(16, 16, 16, 0.96);
            --ink: #f3efe9;
            --muted: #b8b2aa;
            --line: rgba(255, 255, 255, 0.08);
            --accent: #ff1493;
            --accent-soft: #ff69b4;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            position: relative;
            min-height: 100vh;
            background: var(--bg);
            color: var(--ink);
            font-family: "Segoe UI", Helvetica, Arial, sans-serif;
            padding: 2rem 1.25rem 4rem;
            overflow-x: hidden;
        }

        .header-nav,
        .album-grid {
            position: relative;
            z-index: 1;
        }

        .header-nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1180px;
            margin: 0 auto 2.5rem;
            padding-bottom: 0.9rem;
            border-bottom: 1px solid var(--line);
        }

        .header-nav a {
            color: var(--muted);
            text-decoration: none;
            font-size: 1.5rem;
            line-height: 1;
        }

        .header-nav a:hover {
            color: var(--accent-soft);
        }

        .album-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 240px));
            justify-content: center;
            gap: 2rem;
            align-items: start;
            max-width: 1180px;
            margin: 0 auto;
        }

        .album-card {
            display: flex;
            flex-direction: column;
            align-self: start;
            width: 100%;
            max-width: 240px;
            min-height: 0;
            padding: 0.85rem 0.85rem 1rem;
            background: var(--panel);
            border: 1px solid var(--line);
            text-decoration: none;
            color: inherit;
            transition: border-color 0.2s ease, transform 0.2s ease;
        }

        .album-card:hover {
            border-color: rgba(255, 105, 180, 0.6);
            transform: translateY(-2px);
        }

        .cover-container {
            width: 100%;
            height: 220px;
            overflow: hidden;
            background: #111;
            margin-bottom: 0.9rem;
            border: 1px solid var(--line);
        }

        .cover-container img {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: saturate(0.9) contrast(1.03);
        }

        .album-info {
            display: flex;
            flex-direction: column;
            gap: 0.35rem;
        }

        .album-title {
            font-size: 0.95rem;
            color: var(--ink);
            letter-spacing: 0.01em;
        }

        .artist-name {
            font-size: 0.72rem;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.12em;
        }
    </style>
</head>
<body>
    <div class="header-nav">
        <a href="${pageContext.request.contextPath}/" aria-label="Back to home">←</a>
    </div>

    <div class="album-grid">
        <c:forEach var="album" items="${albums}">
            <a href="${pageContext.request.contextPath}/album?id=${album.id}" class="album-card">
                <div class="cover-container">
                    <img src="${pageContext.request.contextPath}/${album.coverImagePath}" alt="${album.albumTitle}">
                </div>
                <div class="album-info">
                    <span class="album-title">${album.albumTitle}</span>
                    <span class="artist-name">${album.artistName}</span>
                </div>
            </a>
        </c:forEach>
    </div>
</body>
</html>