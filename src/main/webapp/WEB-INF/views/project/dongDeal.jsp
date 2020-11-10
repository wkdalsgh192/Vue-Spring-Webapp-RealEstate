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
        <title>Happy House - Real Estate Service Only For You</title>
        <link rel="icon" type="image/x-icon" href="${root}/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${root}/global/styles.css" rel="stylesheet" />
        <link href="${root}/forum/custom.css" rel="stylesheet" />
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script>
		function loginfail(msg) {
			alert(msg);
		}
		</script>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top"
            id="mainNav">
            <div class="container nav">
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
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root}/project/board.jsp">공지사항</a></li>
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="#">오늘의 뉴스</a></li>
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root}/project/aptDeal.jsp">아파트 검색</a></li>
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root}/project/dongDeal.jsp">동 검색</a></li>
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root}/project/settings.jsp">마이페이지</a></li>
							<li class="nav-item"><a class="nav-link js-scroll-trigger" href="${root}/member.do?act=logout" id="logout">로그아웃</a></li>				
						</c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <main>
        	<div class="container main">
            	<section class="content">
	                <div class="results">
	                    <ul class="nav">
	                        <li class="nav-item">
	                            <a class="nav-link" href="#"><h3>동별</h3></a>
	                          </li>
	                        <li class="nav-item">
	                          <a class="nav-link" href="#">거래 정보</a>
	                        </li>
	                        <li class="nav-item">
	                          <a class="nav-link disabled" href="#">관심 목록</a>
	                        </li>
	                      </ul>
	                    <div class="separator"></div>
	                    <div class="items-list">
	                        <ul class="nav">
	                            <li class="item-block">
	                            	<c:forEach var = "apartment" items="${list}">
	                                	<div class="item-cell">
	                                		<div class="item-cell-img"><img src="${root}/img/dogok-raemian.jpg"></div>
                                			<div class="item-cell-desc">
                                				<h4><a class="item-title" href="${root}/map?act=deal&dong=${apartment.dong}&aptName=${apartment.aptName}">${apartment.aptName}</a></h4>
                                				<p> 거래금액 :  ${apartment.dealAmount } 천 원</p>
                                				<p> 면적 : <span> ${apartment.area } </span> </p>
                                				<p> 최종 수정일 : <span>2020.10.16</span> </p>
                               				</div>
                              			</div>
                           			</c:forEach>
	                            </li>
	                        </ul>
	                    </div>
	                </div>
	            </section>
	            <section class="content">
	            	<div class="card col-sm-12 mt-1" style="max-height: 400px;">
	            		<script type="text/javascript">
	            		let colorArr = ['table-primary','table-success','table-danger'];
	            		$(document).ready(function(){
	            			$.get("${root}/map/address"
	            				,function(data, status){
	            					console.log(data);
	            					$.each(data, function(index, vo) {
	            						$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
	            					});//each
	            				}//function
	            				, "json"
	            			);//get
	            		});//ready
	            		$(document).ready(function(){
	            			$("#sido").change(function() {
	            				console.log(1);
	            				let param = $("#sido").val();
	            				console.log(param);
	            				param = param.substring(0,2);
	            				console.log(param);
	            				$.get("${root}/map/address/sido/"+param
	            						,function(data, status){
	            							$("#gugun").empty();
	            							$("#gugun").append('<option value="0">선택</option>');
	            							$.each(data, function(index, vo) {
	            								$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
	            							});//each
	            						}//function
	            						, "json"
	            				);//get
	            			});//change
	            			$("#gugun").change(function() {
	            				console.log(2);
	            				let param = $("#gugun").val();
	            				console.log(param);
	            				param = param.substring(0,5);
	            				console.log(param);
	            				$.get("${root}/map/address/gugun/"+param
	            						,{gugun:param}
	            						,function(data, status){
	            							$("#dong").empty();
	            							$("#dong").append('<option value="0">선택</option>');
	            							$.each(data, function(index, vo) {
	            								$("#dong").append("<option value='"+vo.dongcode+"'>"+vo.dong+"</option>");
	            							});//each
	            						}//function
	            						, "json"
	            				);//get
	            			});//change
	            			$("#dong").change(function() {
		            				$("#searchForm").submit();
		            				console.log($("#searchForm"));
	 	            				$("#searchForm").focus();
	            			});//change
	            		});//ready
	            		
	            		</script>
	            		<div class="global-search">
	            			<form method='post' action="${root}/map" name="searchForm" id="searchForm">
	            				<input type="hidden" name="act" id="act" value="deal">
	            				시도 : <select id="sido" name="sido"><option value="0">선택</option></select>
	            				구군 : <select id="gugun" name="gugun"><option value="0">선택</option></select>
	            				읍면동 : <select id="dong" name="dong"><option value="0">선택</option></select>
	            			</form>
	            		</div>
	            		
						<div class="map" id="map" style="width: 100%; height: 500px; margin: auto;"></div>
	            	
	            	</div>
	            </section>
        	</div>
        </main>
        <!-- Footer-->
        <footer class="footer bg-black small text-center text-white-50"><div class="container">Copyright © Your Website 2020</div></footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
        <script defer src ="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5ago2JSBMKaGQBBssDj6oCIPEsKGVY6o&callback=initMap&libraries=&v=weekly"></script>
        <!-- Core theme JS-->
        <script src="${root}/static/global/scripts.js"></script>
        <script src="${root}/static/forum/custom.js"></script>
    </body>
</html>