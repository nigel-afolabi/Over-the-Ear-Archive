<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin — Over the Ear</title>
    <style>
        :root {
            --bg: #0d0d0d;
            --panel: rgba(18, 18, 18, 0.96);
            --ink: #f4efe9;
            --muted: #c7bdb1;
            --line: rgba(255,255,255,0.09);
            --accent: #ff1493;
            --accent-soft: #ff69b4;
            --danger: #ff6b6b;
            --success: #7fe3a3;
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            min-height: 100vh;
            background: var(--bg);
            color: var(--ink);
            font-family: "Segoe UI", Helvetica, Arial, sans-serif;
            line-height: 1.5;
        }

        .shell {
            max-width: 980px;
            margin: 0 auto;
            padding: 3rem 1.2rem 4rem;
        }

        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 2rem;
            padding-bottom: 0.9rem;
            border-bottom: 1px solid var(--line);
        }

        .brand {
            font-size: 0.72rem;
            letter-spacing: 0.22em;
            text-transform: uppercase;
            color: var(--muted);
        }

        .logout-link {
            color: var(--muted);
            text-decoration: none;
        }

        .card {
            background: var(--panel);
            border: 1px solid var(--line);
            padding: 1.3rem;
            margin-bottom: 1.5rem;
        }

        h1, h2, h3 {
            margin: 0 0 1rem;
            font-weight: 500;
        }

        label {
            display: block;
            margin-bottom: 0.45rem;
            color: var(--muted);
            font-size: 0.78rem;
            letter-spacing: 0.14em;
            text-transform: uppercase;
        }

        input, textarea {
            width: 100%;
            margin-bottom: 1rem;
            padding: 0.8rem 0.9rem;
            border: 1px solid var(--line);
            background: rgba(255,255,255,0.02);
            color: var(--ink);
            font: inherit;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        .button-row {
            display: flex;
            justify-content: flex-end;
        }

        button {
            border: 1px solid rgba(255, 105, 180, 0.6);
            background: rgba(255, 105, 180, 0.08);
            color: var(--ink);
            padding: 0.8rem 1.2rem;
            font-size: 0.76rem;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            cursor: pointer;
        }

        .message,
        .error {
            padding: 0.85rem 1rem;
            margin-bottom: 1rem;
            border: 1px solid var(--line);
        }

        .message {
            color: var(--success);
            background: rgba(127, 227, 163, 0.06);
        }

        .error {
            color: var(--danger);
            background: rgba(255, 107, 107, 0.06);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1rem;
        }

        .small-copy {
            color: var(--muted);
            font-size: 0.84rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="shell">
        <div class="topbar">
            <div class="brand">Over the Ear admin</div>
            <c:if test="${loggedIn}">
                <a class="logout-link" href="${pageContext.request.contextPath}/admin?action=logout">Logout</a>
            </c:if>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:choose>
            <c:when test="${loggedIn}">
                <div class="card">
                    <h1>Add a new album review</h1>
                    <div class="small-copy">Use the form below to publish a review and attach a tracklist. The tracklist format is one line per song: 1. Song Title - 3:14</div>

                    <form method="post" action="${pageContext.request.contextPath}/admin">
                        <input type="hidden" name="action" value="save-review" />

                        <div class="grid">
                            <div>
                                <label for="albumTitle">Album title</label>
                                <input id="albumTitle" name="albumTitle" required>
                            </div>
                            <div>
                                <label for="artistName">Artist</label>
                                <input id="artistName" name="artistName" required>
                            </div>
                        </div>

                        <div class="grid">
                            <div>
                                <label for="coverImagePath">Cover image path</label>
                                <input id="coverImagePath" name="coverImagePath" placeholder="assets/img/album-cover.jpg">
                            </div>
                            <div>
                                <label for="dominantColorHex">Accent color</label>
                                <input id="dominantColorHex" name="dominantColorHex" placeholder="#ff1493">
                            </div>
                        </div>

                        <div class="grid">
                            <div>
                                <label for="reviewerName">Reviewer</label>
                                <input id="reviewerName" name="reviewerName" required>
                            </div>
                            <div>
                                <label for="genres">Genres</label>
                                <input id="genres" name="genres" placeholder="Hip-Hop, Jazz, Soul">
                            </div>
                        </div>

                        <label for="reviewText">Review text</label>
                        <textarea id="reviewText" name="reviewText" required></textarea>

                        <label for="credits">Credits</label>
                        <textarea id="credits" name="credits" placeholder="Produced by ...\nRecorded at ..."></textarea>

                        <label for="trackList">Tracklist</label>
                        <textarea id="trackList" name="trackList" placeholder="1. Intro - 1:37&#10;2. River Run - 3:58"></textarea>

                        <div class="button-row">
                            <button type="submit">Publish review</button>
                        </div>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <h2>Admin access</h2>
                    <form method="post" action="${pageContext.request.contextPath}/admin">
                        <input type="hidden" name="action" value="login" />
                        <label for="password">Password</label>
                        <input id="password" name="password" type="password" required>
                        <div class="button-row">
                            <button type="submit">Enter</button>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
