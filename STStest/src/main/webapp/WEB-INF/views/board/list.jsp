<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
}

h1 {
	color: #333;
	border-bottom: 2px solid #eee;
	padding-bottom: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 15px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

.btn {
	padding: 5px 10px;
	background-color: #5cb85c;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	display: inline-block;
	margin-bottom: 10px;
}

.map-link {
	color: #007bff; /* 파란색 링크 */
	text-decoration: none; /* 밑줄 제거 */
	font-weight: bold; /* 글꼴 굵게 */
}

.map-link:hover {
	text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
}
</style>
</head>
<body>
	<h1>게시판 목록</h1>

	<%-- 🟢 수정됨: /write -> /board/write --%>
	<a href="/board/write" class="btn">새 게시글 작성</a>

	<table>
		<thead>
			<tr>
				<th width="5%">ID</th>
				<th width="45%">제목</th>
				<th width="15%">작성자</th>
				<th width="15%">위치</th>
				<th width="10%">날씨</th>
				<th width="10%">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${boardList}">
				<tr>
					<td>${board.id}</td>
					<td><a href="/board/view/${board.id}">${board.title}</a></td>
					<td>${board.author}</td>
					<td><c:choose>
							<c:when test="${not empty board.location}">
								<c:set var="coords" value="${fn:split(board.location, ',')}" />
								<c:set var="latitude" value="${fn:trim(coords[0])}" />
								<c:set var="longitude" value="${fn:trim(coords[1])}" />
								<a href="https://maps.google.com/?q=${latitude},${longitude}"
									target="_blank" title="구글 지도로 위치 확인" class="map-link">
									${latitude}, ${longitude} </a>
							</c:when>
							<c:otherwise>
                위치 정보 없음
                </c:otherwise>
						</c:choose></td>
					<td>${board.weather}</td>
					<td>${board.createdAt}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty boardList}">
				<tr>
					<td colspan="6" style="text-align: center;">게시글이 없습니다. 첫 글을
						작성해 보세요.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
</body>
</html>