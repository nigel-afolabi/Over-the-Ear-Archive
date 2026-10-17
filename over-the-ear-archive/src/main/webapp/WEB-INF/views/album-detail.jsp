<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${album.albumTitle} — Over the Ear</title>
    <style>
        :root {
            --bg: #0d0d0d;
            --panel: rgba(18, 18, 18, 0.96);
            --ink: #f3efe9;
            --muted: #b9b0a6;
            --line: rgba(255, 255, 255, 0.08);
            --accent: #ff1493;
            --accent-soft: #ff69b4;
        }

        * { box-sizing: border-box; }

        body {
            position: relative;
            margin: 0;
            min-height: 100vh;
            background: var(--bg);
            color: var(--ink);
            font-family: "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.7;
            overflow-x: hidden;
        }

        .page-shell,
        .page-topbar,
        .album-cover-block,
        .review-layout {
            position: relative;
            z-index: 1;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        img {
            display: block;
            max-width: 100%;
        }

        .page-shell {
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem 1.5rem 4rem;
        }

        .page-topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 0.8rem;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--line);
        }

        .nav-back {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 2.2rem;
            height: 2.2rem;
            color: var(--muted);
            font-size: 1.5rem;
            line-height: 1;
            transition: color 0.2s ease;
        }

        .nav-back:hover {
            color: var(--accent-soft);
        }

        .album-cover-block {
            display: grid;
            grid-template-columns: minmax(180px, 240px) minmax(0, 1fr);
            gap: 2rem;
            align-items: end;
            padding: 1rem 0 2rem;
        }

        .cover-wrap {
            width: 100%;
            max-width: 240px;
            border: 1px solid var(--line);
            background: #121212;
            box-shadow: 0 22px 48px rgba(0,0,0,0.28);
        }

        .cover-wrap img {
            width: 100%;
            aspect-ratio: 1;
            object-fit: cover;
            display: block;
        }

        .album-header-copy {
            min-width: 0;
        }

        .eyebrow {
            margin: 0 0 0.7rem;
            color: var(--muted);
            font-size: 0.72rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
        }

        .album-title {
            margin: 0;
            font-size: clamp(2.3rem, 4vw, 4.4rem);
            font-weight: 500;
            line-height: 0.96;
            letter-spacing: -0.05em;
        }

        .artist-line {
            margin-top: 0.9rem;
            color: var(--muted);
            font-size: 1rem;
        }

        .meta-strip {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem 1rem;
            margin-top: 1.2rem;
            padding-top: 0.9rem;
            border-top: 1px solid var(--line);
            color: var(--muted);
            font-size: 0.7rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
        }

        .review-layout {
            display: grid;
            grid-template-columns: minmax(0, 1.6fr) minmax(260px, 320px);
            gap: 2.5rem;
            align-items: start;
        }

        .review-body {
            max-width: 700px;
            color: var(--muted);
            font-family: Georgia, "Times New Roman", serif;
            font-size: 1.12rem;
            line-height: 1.82;
            letter-spacing: 0.01em;
        }

        .review-body p {
            margin: 0 0 1.5rem;
        }

        .review-signoff {
            margin-top: 1.5rem;
            padding-top: 1rem;
            border-top: 1px solid var(--line);
            color: var(--muted);
            font-size: 0.72rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
        }

        .track-panel {
            background: var(--panel);
            border: 1px solid var(--line);
            padding: 1rem 1rem 0.25rem;
        }

        .panel-label {
            margin: 0 0 0.8rem;
            color: var(--muted);
            font-size: 0.72rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
        }

        .track-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .track-table th,
        .track-table td {
            padding: 0.72rem 0;
            border-bottom: 1px solid var(--line);
            vertical-align: top;
        }

        .track-table th {
            color: var(--muted);
            font-size: 0.7rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            text-align: left;
            font-weight: 600;
        }

        .track-table td {
            color: var(--muted);
            font-size: 0.92rem;
        }

        .track-table td.track-number {
            width: 2.4rem;
            color: var(--muted);
        }

        .track-table td.track-title {
            color: var(--ink);
            padding-right: 0.8rem;
        }

        .track-table td.track-length {
            width: 3.5rem;
            text-align: right;
            font-variant-numeric: tabular-nums;
        }

        .track-table tbody tr:last-child td {
            border-bottom: none;
        }

        .credit-block {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid var(--line);
            color: var(--muted);
            font-size: 0.8rem;
            line-height: 1.8;
            white-space: pre-line;
        }

        @media (max-width: 860px) {
            .album-cover-block,
            .review-layout {
                grid-template-columns: 1fr;
            }

            .cover-wrap {
                max-width: 220px;
            }
        }
    </style>
</head>
<body>
    <div class="page-shell">
        <header class="page-topbar" aria-label="Album navigation">
            <a href="${pageContext.request.contextPath}/latest" class="nav-back" aria-label="Back to archive">←</a>
        </header>

        <section class="album-cover-block" aria-label="Album overview">
            <div class="cover-wrap">
                <img src="${pageContext.request.contextPath}/${album.coverImagePath}" alt="${album.albumTitle}">
            </div>

            <div class="album-header-copy">
                <p class="eyebrow">Album review</p>
                <h1 class="album-title">${album.albumTitle}</h1>
                <div class="artist-line">${album.artistName}</div>

                <div class="meta-strip" aria-label="Album metadata">
                    <span>${album.genres}</span>
                    <span>Review by ${album.reviewerName}</span>
                </div>
            </div>
        </section>

        <main class="review-layout" aria-label="Album review content">
            <article>
                <div class="review-body">
                    <p>${album.reviewText}</p>
                </div>
                <div class="review-signoff">Review by ${album.reviewerName}</div>
            </article>

            <aside aria-label="Track listing and credits">
                <section class="track-panel" aria-labelledby="tracklist-heading">
                    <h2 id="tracklist-heading" class="panel-label">Tracklist</h2>
                    <table class="track-table">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Title</th>
                                <th scope="col">Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="track" items="${album.tracks}">
                                <tr>
                                    <td class="track-number">${track.trackNumber}</td>
                                    <td class="track-title">${track.trackTitle}</td>
                                    <td class="track-length">${track.trackLength}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </section>

                <div class="credit-block">${album.credits}</div>
            </aside>
        </main>
    </div>
</body>
</html>