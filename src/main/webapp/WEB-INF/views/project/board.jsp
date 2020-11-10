<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="${root}/forum/custom.css" rel="stylesheet" />
<!-- google map -->
<script defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyANHmuFg33a00Xxoa3ri4xAq5SNDa2-6q0&callback=initMap">
	
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	let map;
	function initMap() {
		map = new google.maps.Map(document.getElementById("map"), {
			center : {
				lat : 37.5013068,
				lng : 127.037471
			},
			zoom : 17
		});
	}
	function loginfail(msg) {
		alert(msg);
	}
</script>

<style type="text/css">
.login {
	background-color: #f8f9fa;
}

td {
	height: 15px;
}
</style>
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light fixed-top"
		id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="${root}">Home</a>
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
							<script>
								loginfail("${error}")
							</script>
						</c:if>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="" data-toggle="modal" data-target="#singUp">회원가입</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="" data-toggle="modal" data-target="#login">로그인</a></li>
					</c:if>
					<c:if test="${member ne null}">
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="${root}/notice.do/board">공지사항</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="#">오늘의 뉴스</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="${root}/member.do/dong">동별 검색</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="${root}/member.do/apt">아파트 검색</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="${root}/member.do/mypage">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
							href="${root}/member.do/logout" id="logout">로그아웃</a></li>
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


					<!-- Featured Project Row-->
					<div class="row align-items-center no-gutters mb-4 mb-lg-5">
						<div class="col-xl-12 col-lg-7">
							<!-- map -->
							<!-- 게시판 -->
							<h2>공지사항</h2>

							<table class="table table-dark table-hover">
								<thead style="font-size: 25px;">
									<tr>
										<th>번호</th>
										<th>재목</th>
										<th>날짜</th>
									</tr>
								</thead>

								
								<tbody style="margin: 0 auto">
									<c:if test="${no.size() != 0}">
										<c:forEach var="notice" items="${no}">
											<tr>
												<td>${notice.no}</td>
												<td>${notice.title}</td>
												<td>${notice.date}</td>
											</tr>
										</c:forEach>
									</c:if>
								</tbody>
							</table>
							<!-- 
							<ul class="pagination justify-content-center">
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">최신</a></li>
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">이전</a></li>
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">1</a></li>
								<li class="page-item active"><a class="page-link"
									href="javascript:void(0);">2</a></li>
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">3</a></li>
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">다음</a></li>
								<li class="page-item"><a class="page-link"
									href="javascript:void(0);">마지막</a></li>
							</ul>
							 -->
						</div>
					</div>


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
				<div class="modal-body">
					<div class="form-group">
						<label for="modalId"> ID:</label> <input type="text"
							class="form-control" placeholder="ID" id="modalId">
					</div>
					<div class="form-group">
						<label for="modalPwd">Password:</label> <input type="password"
							class="form-control" placeholder="password" id="modalPwd">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						id='loginbtn'>Login</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<div class="modal fade" id="singUp">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header" style="">
					<h4 class="modal-title">SingUp</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div class="form-group">
						<label for="singUpId"> ID:</label> <input type="text"
							class="form-control" placeholder="ID" id="singUpId">
					</div>
					<div class="form-group">
						<label for="singUpPwd">Password:</label> <input type="password"
							class="form-control" placeholder="password" id="singUpPwd">
					</div>
					<div class="form-group">
						<label for="resingUpPwd">Password-check:</label> <input
							type="password" class="form-control" placeholder="password"
							id="resingUpPwd">
					</div>
					<div class="form-group">
						<label for="singUpEmail">E-mail:</label> <input type="email"
							class="form-control" placeholder="password" id="singUpEmail">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">SingUp</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<!-- Footer-->
	<footer class="footer bg-black small text-center text-white-50">
		<div class="container">front_end 구미 2반</div>
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
	<script src="js/scripts.js"></script>
</body>
</html>
