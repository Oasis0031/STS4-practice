<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
<style>
/* 🎨 전체 레이아웃 스타일 */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f7f6; /* 연한 회색 배경 */
	margin: 0;
	padding: 20px;
}

.container {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	padding: 30px;
	border-radius: 12px; /* 둥근 모서리 */
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

h1 {
	color: #333;
	text-align: center;
	margin-bottom: 30px;
}

/* 📝 폼 요소 스타일 */
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
	min-height: 200px; /* 내용 입력 필드 최소 높이 설정 */
}

/* ❌ 에러 메시지 스타일 */
.error-message {
	color: #dc3545; /* 빨간색 계열 */
	font-size: 0.9em;
	margin-top: 5px;
}

/* ➡️ 버튼 그룹 스타일 */
.btn-group {
	display: flex;
	justify-content: flex-end; /* 버튼을 오른쪽으로 정렬 */
	gap: 10px;
	margin-top: 30px;
}

.btn-submit {
	padding: 10px 20px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-submit:hover {
	background-color: #0056b3;
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
		<h1>새 게시글 작성</h1>

		<form action="/board/write" method="post">

			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" value="${board.title}" placeholder="제목을 입력하세요">
				<p class="error-message">${errors.title}</p>
			</div>

			<div class="form-group">
				<label for="author">작성자</label> <input type="text" id="author"
					name="author" value="${board.author}" placeholder="작성자를 입력하세요">
				<p class="error-message">${errors.author}</p>
			</div>

			<div style="display: flex; gap: 20px;">
				<div class="form-group" style="flex: 1;">
					<!-- label for 제거 (경고 방지) -->
					<label>위치 (위도, 경도)</label>
					<button type="button" onclick="getLocation()">위치 찾기</button>
					<input type="hidden" id="location" name="location"
						value="${board.location}">
					<p id="location-status">위치 정보를 받아오세요.</p>
					<p class="error-message">${errors.location}</p>
				</div>

				<div class="form-group" style="flex: 1;">
					<label for="weather">날씨</label> <input type="text" id="weather"
						name="weather" value="${board.weather}" placeholder="예: 맑음, 비">
					<p class="error-message">${errors.weather}</p>
				</div>
			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력해주세요">${board.content}</textarea>
				<p class="error-message">${errors.content}</p>
			</div>

			<div class="btn-group">
				<a href="/board/list" class="btn-back">목록으로</a>
				<button type="submit" class="btn-submit">작성 완료</button>
			</div>

		</form>
		
<script>
function getLocation() {
  console.log("--- getLocation() 함수 시작 ---");

  if (navigator.geolocation) {
    console.log("1. 브라우저가 Geolocation을 지원합니다.");

    navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
  } else {
    console.log("1-B. 이 브라우저는 Geolocation을 지원하지 않습니다.");
    alert("이 브라우저에서는 위치 정보를 사용할 수 없습니다.");
  }
}

function successCallback(position) {
  console.log("2-A. 원본 coords 객체:", position.coords);

  // 좌표 변수 직접 추출 (디스트럭처링 X)
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;

  console.log("2. 위치 정보 획득 성공.");
  console.log("   - 획득한 좌표: latitude=" + latitude + ", longitude=" + longitude);

  // 숨겨진 input에 저장
  var locationInput = document.getElementById("location");
  if (locationInput) {
    locationInput.value = latitude + "," + longitude;
    console.log("3. locationInput.value: " + locationInput.value);
  } else {
    console.log("3-B. location input 요소를 찾지 못했습니다.");
  }
}

function errorCallback(error) {
  console.log("위치 정보 획득 실패:", error);
  alert("위치 정보를 가져올 수 없습니다. 오류 코드: " + error.code);
}
</script>
	</div>
</body>
</html>