let param;
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
$("#sido").change(function() {
	param = $("#sido").val();
	param = param.substring(0,2);
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
	param = $("#gugun").val().substring(0,5);
	$.get("${root}/map/address/gugun/"+param
			,{gugun:param}
			,function(data, status){
				$("#dong").empty();
				$("#dong").append('<option value="0">선택</option>');
				$.each(data, function(index, vo) {
					$("#dong").append("<option value='"+vo["dongcode"]+"'>"+vo["dong"]+"</option>");
				});//each
			}//function
			, "json"
	);//get
});//change
$("#dong").change(function() {
	param = $("#dong").val();
	console.log("param : "+param);
	$.get("${root}/map/house/info/"+param
		,{dongcode:param}
		, function(data, status) {
			const arr = new Array();
			$(".item-block").empty();
			$.each(data, function(index, vo) {
				var obj = {'x': vo.lat, 'y': vo.lng};
				arr.push(obj);
				/* $(".item-block").append('<div class="item-cell"')
				$(".item-block").append('<div class="item-cell-img"')
				$(".item-block").append('<img src="${root}/img/dogok-raemian.jpg">'+'</div>')
				$(".item-block").append('<div class="item-cell-desc"')
				$(".item-block").append('<h4><a class="item-title" href="${root}/map?act=deal&dongcode=vo.code&aptname=vo.aptName"}>'+vo.aptName+'</a><h4>')
				$(".item-block").append('<p> 건축년도 : '+vo.builtYear + ' 천 원</p>')
				$(".item-block").append('<p> 면적 : <span>' + vo.area + ' </span> </p>')
				$(".item-block").append('<p> 최종 수정일 : <span>'+'</span></p>') */
			})
			renewMap(arr);
		}
		, "json"
	);
});//change
});//ready