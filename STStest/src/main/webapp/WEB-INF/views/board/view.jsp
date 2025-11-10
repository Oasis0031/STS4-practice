<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기: ${board.title}</title>
    <style>
        /* 🎨 기본 스타일 */
        body { font-family: 'Arial', sans-serif; background-color: #f4f7f6; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); }
        h1 { color: #333; text-align: center; margin-bottom: 20px; }
        
        /* 📝 게시글 헤더 */
        .post-header { border-bottom: 2px solid #eee; padding-bottom: 10px; margin-bottom: 20px; }
        .post-title { font-size: 1.8em; color: #007bff; margin-bottom: 5px; }
        .post-meta { 
            font-size: 0.9em; 
            color: #888; 
            display: flex; 
            justify-content: space-between; /* 항목들을 양쪽으로 분리 */
            margin-top: 10px; 
        }
        
        /* 📜 게시글 내용 */
        .post-content { 
            white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
            line-height: 1.6; 
            color: #444; 
            min-height: 200px; 
            padding: 20px 0; 
        }
        
        /* ➡️ 버튼 그룹 */
        .btn-group { 
            display: flex; 
            justify-content: flex-end; 
            gap: 10px; 
            border-top: 1px solid #eee; 
            padding-top: 20px; 
            margin-top: 20px; 
        }
        /* 버튼 공통 스타일 */
        .btn-default { padding: 10px 15px; border: none; border-radius: 8px; text-decoration: none; cursor: pointer; transition: background-color 0.3s; }
        .btn-list { background-color: #6c757d; color: white; }
        .btn-list:hover { background-color: #5a6268; }
        .btn-modify { background-color: #ffc107; color: #333; }
        .btn-modify:hover { background-color: #e0a800; }
        .btn-delete { background-color: #dc3545; color: white; }
        .btn-delete:hover { background-color: #c82333; }
   .map-link { color: #007bff; /* 파란색 링크 */ text-decoration: none; /* 밑줄 제거 */ font-weight: bold; /* 글꼴 굵게 */}
    .map-link:hover {text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */}
    </style>
    
    <script>
        /**
         * 게시글 삭제 확인 및 요청 함수
         * @param {number} id - 삭제할 게시글의 ID
         */
        function deletePost(id) {
            // alert 대신 confirm을 사용하여 사용자에게 삭제 의사를 한 번 더 확인합니다.
            if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                // 확인 시, /board/delete/{id} 경로로 이동 (DELETE 요청 처리 추정)
                location.href = '/board/delete/' + id;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>게시글 상세 보기</h1>

    <div class="post-header">
        <h2 class="post-title">${board.title}</h2>
        
        <div class="post-meta">
            <span>작성자: ${board.author}</span>
            <span>작성일: ${board.createdAt}</span>
        </div>
        
        <div class="post-meta">
            <span>ID: ${board.id}</span>
			<strong>위치: </strong>
			<c:choose>
                		<c:when test="${not empty board.location}">
                		<c:set var="coords" value="${fn:split(board.location, ',')}"/>
                		<c:set var="latitude" value="${coords[0]}"/>
                		<c:set var="longitude" value="${coords[1]}"/>
                		
                		<a href="https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}"
                		   target="_blank"
                		   title="구글 지도로 위치 확인"
                 		   class="map-link">
                			${latitude},${longitude}
                		</a>
                </c:when>
                <c:otherwise>
                위치 정보 없음
                </c:otherwise>
                </c:choose>
        </div>
        <div class="meta-item"><strong>날씨:</strong> ${board.weather}</div>
        
    </div>
    
    <div class="post-content">
        ${board.content}
    </div>

    <div class="btn-group">
        <a href="/board/list" class="btn-default btn-list">목록으로</a>
        <a href="/board/modify/${board.id}" class="btn-default btn-modify">수정하기</a>
        <button onclick="deletePost(${board.id})" class="btn-default btn-delete">삭제하기</button>
    </div>
</div>
</body>
</html>