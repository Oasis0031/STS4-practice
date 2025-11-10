<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정: ${board.title}</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f7f6;
	margin: 0;
	padding: 20px;
}

.container {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

h1 {
	color: #333;
	text-align: center;
	margin-bottom: 30px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #555;
}

input[type="text"], textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	box-sizing: border-box;
	font-size: 16px;
}

textarea {
	resize: vertical;
	min-height: 200px;
}

.error-message {
	color: #dc3545;
	font-size: 0.9em;
	margin-top: 5px;
}

.btn-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 30px;
}

.btn-submit {
	padding: 10px 20px;
	background-color: #ffc107;
	color: #333;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-submit:hover {
	background-color: #e0a800;
}

.btn-back {
	padding: 10px 20px;
	background-color: #6c757d;
	color: white;
	border: none;
	border-radius: 8px;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-back:hover {
	background-color: #5a6268;
}
</style>
</head>
<body>
	<div class="container">
		<h1>게시글 수정</h1>

		<!-- BoardController의 POST /modify로 데이터를 보냅니다. -->
		<form action="/board/modify" method="post">

			<!-- 게시글 ID (수정을 위해 필수적으로 hidden 필드로 전달해야 합니다.) -->
			<input type="hidden" name="id" value="${board.id}">

			<!-- 제목 -->
			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" value="${board.title}" placeholder="제목을 입력하세요">
				<p class="error-message">${errors.title}</p>
			</div>

			<!-- 작성자 (수정 불가능하다고 가정하고 disabled 처리, 필요 시 수정 가능하게 변경) -->
			<div class="form-group">
				<label for="author">작성자</label> <input type="text" id="author"
					name="author" value="${board.author}" disabled
					style="background-color: #eee;">
				<!-- 작성자는 수정하지 않더라도 Board 객체에 포함되어야 하므로 hidden으로 한 번 더 보냅니다. -->
				<input type="hidden" name="author" value="${board.author}">
			</div>

			<!-- 위치/날씨 -->
			<div style="display: flex; gap: 20px;">
				<div class="form-group" style="flex: 1;">
					<label for="location">위치</label> <input type="text" id="location"
						name="location" value="${board.location}" placeholder="예: 서울, 제주">
					<p class="error-message">${errors.location}</p>
				</div>
				<div class="form-group" style="flex: 1;">
					<label for="weather">날씨</label> <input type="text" id="weather"
						name="weather" value="${board.weather}" placeholder="예: 맑음, 비">
					<p class="error-message">${errors.weather}</p>
				</div>
			</div>

			<!-- 내용 -->
			<div class="form-group">
				<label for="content">내용</label>
				<!-- 내용이 null일 경우를 대비해 EL 내부에서 처리하는 것이 안전하지만, 여기서는 단순화합니다. -->
				<textarea id="content" name="content" placeholder="내용을 입력해주세요">${board.content}</textarea>
				<p class="error-message">${errors.content}</p>
			</div>

			<div class="btn-group">
				<a href="/board/view/${board.id}" class="btn-back">취소 및 돌아가기</a>
				<button type="submit" class="btn-submit">수정 완료</button>
				<button type="button" onclick="deletePost(${board.id})" class="btn-default btn-delete">삭제하기</button>
				
			</div>
		</form>
	</div>


</body>
</html>