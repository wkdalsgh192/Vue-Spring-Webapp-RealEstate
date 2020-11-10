<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <c:set var="root" value="${pageContext.request.contextPath}"></c:set>
   <c:set var="error" value="${msg}"></c:set>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Settings</title>
        <link rel="icon" type="image/x-icon" href="${root}/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${root}/global/styles.css" rel="stylesheet" />
        <link href="${root}/settings/settings.css" rel="stylesheet" />
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script>
        $(document).ready(function() {
    		$("#confirmbtn").click(function() {
    			if($("#id").val().trim()==''){
    				alert("아이디를 입력하세요")
    				$("#id").focus();
    				return;
    			}
    			else if($("#pw").val().trim()==''){
    				alert("비밀번호를 입력하세요")
    				$("#pw").focus();
    				return;
    			}
    			else if($("#email").val().trim()==''){
    				alert("이메일를 입력하세요")
    				$("#email").focus();
    				return;
    			}
    			$("#updateForm").submit();		
    			
            });
			$("#deletebtn").click(function(){
				$("#deleteForm").submit();
			})
		});
    	function loginfail(msg) {
    		alert(msg);
    	}
        </script>
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
							<script>loginfail("${error}") </script>
						</c:if>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="" data-toggle="modal" data-target="#singUp">회원가입</a></li>
						<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="" data-toggle="modal" data-target="#login">로그인</a></li>
					</c:if>
					<c:if test="${member ne null}">
						<li class="nav-item"><a class="nav-link js-scroll-trigger"href="${root}/member.do/board">공지사항</a></li>
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
        <main>
            <section class="content">
                <h1 class="mainTitle">MY Home</h1>
                <ul class="nav">
                    <li class="nav-item">
                      <a class="nav-link" href="#">정보 수정</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="#">관심 매물</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">나의 리뷰</a>
                      </li>
                </ul>
                <div class="item-container">
                    <div class="item-cell" id="item-header">
                        <div class="item-cell-img">
                            <img src="${root}/img/dogok-raemian.jpg" alt="">
                            <p><a href="" class="profile">프로필 사진 변경</a></p>
                        </div>
                    </div>
                    <div class="item-cell" id="item-body">
                      <form method = "post" name = "updateForm" id ="updateForm" action="${root}/member.do/update">
                            <div class="form-group">
                                <label for="id">아이디</label>
                                <input type="text" name="id" id="id" value="${member.id}" readonly="readonly">
                            </div>
                            <div class="form-group">
                                <label for="password">비밀번호</label>
                                <input type="pw" name="pw"  value="${member.pw}" id="pw">
                            </div>
                            <div class="form-group">
                                <label for="email">이메일</label>
                                <input type="email" name="email"value="${member.email}" id="email">
                            </div>
                        </form>
                    </div>
                    <div class="item-cell" id="item-footer">
                        <button type="button" class="btn btn-primary" id="confirmbtn" >정보 수정</button>
					    <button type="button" class="btn btn-danger" >지우기</button>
					    <form method = "get" name = "deleteForm" id = "deleteForm" action ="${root}/member.do/delete/${member.id}">
					    	<button type="button" class="btn btn-danger" id="deletebtn">회원탈퇴</button>
					    </form>
					     
                    </div>
                </div>
            </section>
        </main>
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
						<label for="resingUpPwd">Password-check:</label> <input type="password"
							class="form-control" placeholder="password" id="resingUpPwd">
					</div>
					<div class="form-group">
						<label for="singUpEmail">E-mail:</label> <input type="email"
							class="form-control" placeholder="password" id="singUpEmail">
					</div>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Confirm</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div> 
    <!-- Footer-->
    <footer class="footer bg-black small text-center text-white-50"><div class="container">Copyright © Your Website 2020</div></footer>
    <!-- Bootstrap core JS-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
    <!-- Third party plugin JS-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
    <!-- Core theme JS-->
    <script src="../static/global/scripts.js"></script>
    </body>
</html>
