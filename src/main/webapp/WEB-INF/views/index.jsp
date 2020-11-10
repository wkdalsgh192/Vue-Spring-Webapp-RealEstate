<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <c:set var="root" value="${pageContext.request.contextPath}"></c:set>
  <c:set var="error" value="${msg}"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Grayscale - Start Bootstrap Theme</title>
<link rel="icon" type="image/x-icon" href="${root}/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Varela+Round"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${root}/global/styles.css" rel="stylesheet" />
<!-- google map -->
<script defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyANHmuFg33a00Xxoa3ri4xAq5SNDa2-6q0&callback=initMap">
	
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	var multi = {
		lat : 37.5665734,
		lng : 126.978179
	};
	var map;
	let markers = [];
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center : multi,
			zoom : 12
		});
		var marker = new google.maps.Marker({
			position : multi,
			map : map
		});
	}
	function setMapOnAll(map) {
		  for (let i = 0; i < markers.length; i++) {
		    markers[i].setMap(map);
		  }
		}
	function clearMarkers() {
		 setMapOnAll(null);
	}
	function deleteMarkers() {
		  clearMarkers();
		  markers = [];
	}
	function addMarker(tmpLat, tmpLng, aptName) {
		var marker = new google.maps.Marker({
			position : new google.maps.LatLng(parseFloat(tmpLat),
					parseFloat(tmpLng)),
			label : aptName,
			title : aptName
		});
		marker.addListener('click', function() {
			map.setZoom(17);
			map.setCenter(marker.getPosition());
			callHouseDealInfo();
		});
		marker.setMap(map);
		markers.push(marker);
	}
	function callHouseDealInfo() {
		alert("you can call HouseDealInfo");
	}
	function geocode(jsonData) {
		let idx = 0;
		deleteMarkers();
		$.each(jsonData, function(index, vo) {
			let tmpLat;
			let tmpLng;
			$.get("https://maps.googleapis.com/maps/api/geocode/json"
					,{	key: 'AIzaSyDT7sSTMO5sgyqu_1l0KuaIK_QAyv0U44c'
						, address:vo.dong+"+"+vo.aptName+"+"+vo.jibun
					}
					, function(data, status) {
						//alert(data.results[0].geometry.location.lat);
						tmpLat = data.results[0].geometry.location.lat;
						tmpLng = data.results[0].geometry.location.lng;
						$("#lat_"+index).text(tmpLat);
						$("#lng_"+index).text(tmpLng);
						addMarker(tmpLat, tmpLng, vo.aptName);
					}
					, "json"
			);//get
		});//each
	}
</script>

<script>
let colorArr = ['table-primary','table-success','table-danger'];
	$(document).ready(function(){
		$.get("${pageContext.request.contextPath}/map"
			,{act:"sido"}
			,function(data, status){
				$.each(data, function(index, vo) {
					$("#sido").append("<option value='"+vo.sido_code+"'>"+vo.sido_name+"</option>");
				});//each
			}//function
			, "json"
		);//get
	});//ready
	function loginfail(msg) {
		alert(msg);
	}
	$(document).ready(function() {
		$("#loginbtn").click(function() {
			if($("#id").val().trim()==''){
				alert("아이디를 입력하세요")
				$("id").focus();
				return;
			}
			else if($("#pw").val().trim()==''){
				alert("아이디를 입력하세요")
				$("#pw").focus();
				return;
			}
			$("#loginForm").submit();			
			
		});
	
		$("#signbtn").click(function() {
			if($("#signid").val().trim()==''){
				alert("아이디를 입력하세요")
				$("signid").focus();
				return;
			}
			else if($("#signpw").val().trim()==''){
				alert("비밀번호를 입력하세요")
				$("#signpw").focus();
				return;
			}
			else if($("#rpw").val().trim()==''){
				alert("비밀번호확인를 입력하세요")
				$("#rpw").focus();
				return;
			}
			else if($("#signemail").val().trim()==''){
				alert("이메일를 입력하세요")
				$("#signemail").focus();
				return;
			}
			if($("#rpw").val().trim() != $("#signpw").val().trim()){
				alert("비밀번호가 다릅니다.")
				$("#signpw").focus();
				return;
			}			
			$("#signForm").submit();
			
		});
		$("#sido").change(function() {
			$.get("${pageContext.request.contextPath}/map"
					,{act:"gugun", sido:$("#sido").val()}
					,function(data, status){
						$("#gugun").empty();
						$("#gugun").append('<option value="0">ì í</option>');
						$.each(data, function(index, vo) {
							$("#gugun").append("<option value='"+vo.gugun_code+"'>"+vo.gugun_name+"</option>");
						});//each
					}//function
					, "json"
			);//get
		});//change
		$("#gugun").change(function() {
			$.get("${pageContext.request.contextPath}/map"
					,{act:"dong", gugun:$("#gugun").val()}
					,function(data, status){
						$("#dong").empty();
						$("#dong").append('<option value="0">ì í</option>');
						$.each(data, function(index, vo) {
							$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
						});//each
					}//function
					, "json"
			);//get
		});//change
		$("#dong").change(function() {
			$.get("${pageContext.request.contextPath}/map"
					,{act:"apt", dong:$("#dong").val()}
					,function(data, status){
						$("#searchResult").empty();
						//$("tbody").empty();
						$.each(data, function(index, vo) {
							let str = "<tr class="+colorArr[index%3]+">"
							+ "<td>" + vo.no + "</td>"
							+ "<td>" + vo.dong + "</td>"
							+ "<td>" + vo.aptName + "</td>"
							+ "<td>" + vo.jibun + "</td>"
							+ "<td>" + vo.code
							+ "</td><td id='lat_"+index+"'></td><td id='lng_"+index+"'></td></tr>";
							$("tbody").append(str);
/* 							$("#searchResult").append(vo.dong+" "+vo.aptName+" "+vo.jibun+"<br>"); */
						});//each
						geocode(data);
					}//function
					, "json"
			);//get
		});//change
		
	});
</script>
<style type="text/css">
.login {
	background-color: #f8f9fa;
}
</style>
</head>
<body id="page-top">
	
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="${root }">Home</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto" id="navbarManuList">					
					<c:if test="${member eq null}">
						<c:if test="${error ne null}">
							<script>loginfail("${error}") </script>
						</c:if>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="" data-toggle="modal" data-target="#signUp">회원가입</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="" data-toggle="modal" data-target="#login">로그인</a></li>
					</c:if>
					<c:if test="${member ne null}">
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/notice.do/list">공지사항</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="#">오늘의 뉴스</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/member.do/dong">동별 검색</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/member.do/apt">아파트 검색</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/member.do/mypage">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/member.do/logout" id="logout">로그아웃</a></li>				
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container d-flex h-100 align-items-center">
			<div class="mx-auto text-center">
				<h1 class="mx-auto my-0 text-uppercase">HAPPY HOUSE</h1>
				<h2 class="text-white-50 mx-auto mt-2 mb-5">행복한 우리집!</h2>
				<!-- <a class="btn btn-primary js-scroll-trigger" href="#about">Get Started</a> -->
			</div>
		</div>
	</header>
	<!-- About-->

	<!-- Projects-->
	<section class="projects-section bg-light" id="projects">

		<div class="container">
			<div class="row align-items-center no-gutters mb-4 mb-lg-5">
				<div class="container-fluid">
					<!-- filters start -->
					<div
						class="sorting-filters text-center mb-20 d-flex justify-content-center mb-5 mb-lg-0">
						<form class="form-inline" id="frm"
							action="searchRecentHouseDeal.do">
							<!-- <input type="hidden" id="code"  name="code" value="code"/> -->
							<div class="form-group md">
								<select class="form-control"  name="sido" id="sido">
									<option value="0">선택</option>
								</select>
							</div>
							<div class="form-group md-1">
								<select class="form-control"  name="gugun" id="gugun">
									<option value="0">선택</option>
								</select>
							</div>
							<div class="form-group md-1">
								<select class="form-control"  name="dong" id="dong">
									<option value="0">선택</option>
								</select>
							</div>
						</form>
					</div>
					<table class="table mt-2">
	
						<thead>
							<tr>
							<th>번호</th>
							<th>법정동</th>
							<th>아파트이름</th>
							<th>지번</th>
							<th>지역코드</th>
							<th>위도</th>
							<th>경도</th>
							</tr>
						</thead>
						<tbody id="searchResult">
						</tbody>
					</table>
						<!-- filters end -->
				</div>
			</div>
			<!-- Featured Project Row-->
			<div class="row align-items-center no-gutters mb-4 mb-lg-5">
				<div class="col-xl-12 col-lg-7">
					<!-- map -->
					<div id="map" style="width: 100%; height: 600px; margin: auto;"></div>
				</div>
			</div>
			<!-- Project One Row-->
			<div class="row justify-content-center no-gutters mb-5 mb-lg-0">
				<div class="col-lg-6">
					<div class="bg-black text-center h-100 project">
						<div class="d-flex h-100">
							<div class="project-text w-100 my-auto text-center text-lg-left">
								<h4 class="text-white">공지사항</h4>
								<hr class="d-none d-lg-block mb-0 ml-0" />
								<div class="mb-0 text-white-50">
									<a href="#!">공지사항 1</a>
								</div>
								<div class="mb-0 text-white-50">
									<a href="#!">공지사항 2</a>
								</div>
								<div class="mb-0 text-white-50">
									<a href="#!">공지사항 3</a>
								</div>
								<!--  <p class="mb-0 text-white-50">An example of where you can
									put an image of a project, or anything else, along with a
									description.</p>-->
								<hr class="d-none d-lg-block mb-0 ml-0" />
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="bg-black text-center h-100 project">
						<div class="d-flex h-100">
							<div class="project-text w-100 my-auto text-center text-lg-left">
								<h4 class="text-white">오늘의 뉴스</h4>
								<hr class="d-none d-lg-block mb-0 ml-0" />
								<div class="mb-0 text-white-50">
									<a href="#!">오늘의 뉴스 1</a>
								</div>
								<div class="mb-0 text-white-50">
									<a href="#!">오늘의 뉴스 2</a>
								</div>
								<div class="mb-0 text-white-50">
									<a href="#!">오늘의 뉴스 3</a>
								</div>
								<!--  <p class="mb-0 text-white-50">An example of where you can
									put an image of a project, or anything else, along with a
									description.</p>-->
								<hr class="d-none d-lg-block mb-0 ml-0" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Signup-->
	<section class="signup-section" id="signup">
		<div class="container">
			<div class="row">
				<div class="col-md-10 col-lg-8 mx-auto text-center">
					<i class="far fa-paper-plane fa-2x mb-2 text-white"></i>
					<h2 class="text-white mb-5">찾으시는 건물 매물을 검색해보세요</h2>
					<form class="form-inline d-flex">
						<input class="form-control flex-fill mr-0 mr-sm-2 mb-3 mb-sm-0"
							id="inputEmail" type="email" placeholder="건물이름 혹은 주소를 입력해주세요" />
						<button class="btn btn-primary mx-auto" type="submit">찾기</button>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- modal -->
	<div class="modal fade" id="login">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" style="">
					<h4 class="modal-title">Login</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<form method = "post" name = "loginForm" id ="loginForm" action="${root}/member.do/login">
				<div class="modal-body">
					<div class="form-group">
						<label for="modalId"> ID:</label> <input type="text"
							class="form-control" placeholder="ID" id="id" name="id">
					</div>
					<div class="form-group">
						<label for="modalPwd">Password:</label> <input type="password"
							class="form-control" placeholder="password" id="pw" name="pw">
					</div>
				</div>
				</form>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id='loginbtn'>Login</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<div class="modal fade" id="signUp">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" style="">
					<h4 class="modal-title">SignUp</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<form method = "post" name = "signForm" id ="signForm" action="member.do/signup">
				<div class="modal-body">
					<div class="form-group">
						<label for="signId"> ID:</label> <input type="text"
							class="form-control" placeholder="ID" id="signid" name="id">
					</div>
					<div class="form-group">
						<label for="signPw">Password:</label> <input type="password"
							class="form-control" placeholder="password" id="signpw" name="pw">
					</div>
					<div class="form-group">
						<label for="resignPw">Password-check:</label> <input
							type="password" class="form-control" placeholder="password"
							id="rpw">
					</div>
		
					<div class="form-group">
						<label for="signUpEmail">E-mail:</label> <input type="email"
							class="form-control" placeholder="password" id="signemail" name="email">
					</div>
				</div>
				</form>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal" id='signbtn'>SignUp</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<!-- Footer-->
	<footer class="footer bg-black small text-center text-white-50">
		<div class="container">front_end 구미 2반</div>
		<div class="container">장민호, 송원준</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
	<!-- Third party plugin JS-->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
	<!-- Core theme JS-->
	<!-- <script src="js/scripts.js"></script> -->
</body>
</html>
