<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 게시글 작성</title>
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
				<label for="title">제목</label>
				<input type="text" id="title" name="title" value="${board.title}" placeholder="제목을 입력하세요">
				<c:if test="${not empty errors.title}">
					<p class="error-message">${errors.title}</p>
				</c:if>
			</div>

			<div class="form-group">
				<label for="author">작성자</label>
				<input type="text" id="author" name="author" value="${board.author}" placeholder="작성자를 입력하세요">
				<c:if test="${not empty errors.author}">
					<p class="error-message">${errors.author}</p>
				</c:if>
			</div>

			<div style="display: flex; gap: 20px;">
				<div class="form-group" style="flex: 1;">
					<label>위치 (위도, 경도)</label>
					<button type="button" onclick="getLocation()">위치 찾기</button>
					<input type="hidden" id="location" name="location" value="${board.location}">
					<p id="location-status">위치 정보를 받아오세요.</p>
					<c:if test="${not empty errors.location}">
						<p class="error-message">${errors.location}</p>
					</c:if>
				</div>

				<div class="form-group" style="flex: 1;">
					<label for="weather">날씨</label>
					<input type="text" id="weather" name="weather" value="${board.weather}" 
            placeholder="날씨 정보를 기다리는 중..." readonly>
            
					<p id="weather-status" style="font-size: 0.9em; color: #007bff; margin-top: 5px;">날씨 정보가 표시됩니다.</p>
					<c:if test="${not empty errors.weather}">
						<p class="error-message">${errors.weather}</p>
					</c:if>
				</div>
			</div>

			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력해주세요">${board.content}</textarea>
				<c:if test="${not empty errors.content}">
					<p class="error-message">${errors.content}</p>
				</c:if>
			</div>

			<div class="btn-group">
				<a href="/board/list" class="btn-back">목록으로</a>
				<button type="submit" class="btn-submit">작성 완료</button>
			</div>
		</form>

		<script>
		const WEATHER_API_URL = "https://api.openweathermap.org/data/2.5/weather";
		const WEATHER_API_KEY = "d4a79527b0f1a2e2b58a924c4cb5b504";

		function getLocation() {
			if (navigator.geolocation) {
				navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
			} else {
				alert("이 브라우저에서는 위치 정보를 사용할 수 없습니다.");
			}
		}

		function successCallback(position) {
			const latitude = position.coords.latitude;
			const longitude = position.coords.longitude;
			const locationInput = document.getElementById("location");
			if (locationInput) {
				locationInput.value = latitude + "," + longitude;
			}
			document.getElementById("location-status").innerText = "위치 정보를 받았습니다.";
			getWeather(latitude, longitude);
		}

		function getWeather(lat, lon) {
			document.getElementById("weather-status").innerText = "날씨 정보 요청 중";
			document.getElementById("weather").value = "";
			const url = WEATHER_API_URL + "?lat=" + lat + "&lon=" + lon + "&appid=" + WEATHER_API_KEY + "&units=metric&lang=kr";

			fetch(url)
				.then(response => {
					if (!response.ok) {
						throw new Error("HTTP 오류: " + response.status);
					}
					return response.json();
				})
				.then(data => {
					const weatherDescription = data.weather && data.weather.length > 0 ? data.weather[0].description : "알 수 없는 날씨";
					const temperature = data.main ? data.main.temp.toFixed(1) : "N/A";
					const fullWeather = weatherDescription + " (" + temperature + "°C)";
					document.getElementById("weather").value = fullWeather;
					
					const fullLocationInfo = data.name || lat.toFixed(4) + ", " + lon.toFixed(4);
		
					document.getElementById("location-status").innerText = "위치 획득 성공. (" + (data.name ? data.name : fullLocationInfo) + ")";
					document.getElementById("weather-status").innerText = "날씨 획득 성공. (" + fullLocationInfo + ")";
				})
				.catch(error => {
					console.error("날씨 정보 획득 실패:", error);
					document.getElementById("weather-status").innerText = "날씨 획득 실패. (API Key 확인 필요)";
					document.getElementById("weather").value = "날씨 정보를 가져올 수 없습니다.";
				});
		}

		function errorCallback(error) {
			let errorMessage = "위치 정보를 가져올 수 없음.";
			switch (error.code) {
				case error.PERMISSION_DENIED:
					errorMessage += " 사용자가 위치 정보 공유를 거부함.";
					break;
				case error.POSITION_UNAVAILABLE:
					errorMessage += " 위치 정보 사용이 불가함.";
					break;
				default:
					errorMessage += " 오류 코드: " + error.code;
			}
			document.getElementById("location-status").innerText = "위치 획득 실패";
			document.getElementById("weather-status").innerText = "위치 획득 실패로 날씨를 가져올 수 없습니다.";
			alert(errorMessage);
		}
		</script>
	</div>
</body>
</html>
