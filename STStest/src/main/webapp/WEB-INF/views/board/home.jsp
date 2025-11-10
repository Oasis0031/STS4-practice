<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환영합니다</title>
</head>
<body>
	<h1> 스프링부트 + 오라클 db 연결 성공!</h1>
	<p> 이 페이지는 jsp를 통해 렌더링되고 있습니다.</p>
	<p> 현재 시간을 확인해보세요: <%= new java.util.Date() %>

	<a href="/data">데이터베이스 테스트 페이지로 이동</a>
</body>
</html>