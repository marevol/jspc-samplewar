<%@page pageEncoding="UTF-8"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<jsp:useBean id="sample" scope="request" class="net.marevol.sample.entity.Sample" />
<html>
<head>
<title>Sample</title>
</head>
<body>
<p>Hello!</p>
<tags:hello/>
<%= sample.getName() %>
</body>
</html>
