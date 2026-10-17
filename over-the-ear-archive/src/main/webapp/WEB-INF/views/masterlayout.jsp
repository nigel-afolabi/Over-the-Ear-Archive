<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Archive / Index</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/brutalist.css">
</head>
<body>
    <nav class="site-nav">
        <div class="nav-cluster">
            <button class="nav-link" onclick="history.back()" aria-label="Back">←</button>
        </div>
    </nav>

    <main class="canvas">
        <jsp:include page="${pageContent}" />
    </main>

    <script src="${pageContext.request.contextPath}/assets/js/transition.js"></script>
</body>
</html>