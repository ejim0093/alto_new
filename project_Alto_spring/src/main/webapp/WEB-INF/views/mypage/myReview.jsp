<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<c:set var="contextPath" value="${pageContext.request.contextPath}" />  
<c:set var="classReviewList" value="${reviewList.classReviewList }" />
<c:set var="itemReviewList" value="${reviewList.itemReviewList }" />
<c:set var="hobbyList" value="${mylikeMap.hobbyList}" />
<c:set var="areaList" value="${mylikeMap.areaList}" />
<c:set var="likeList" value="${mylikeMap.memlikeList}" />
<c:set var="clubList" value="${mylikeMap.clubList}" />
<c:set var="classList" value="${mylikeMap.classList}" />
<c:set var="itemList" value="${mylikeMap.itemList}" />
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, inital-scale=1.0">
	<link rel="stylesheet" href="${contextPath }/resources/css/common/list.css" />	
	<link rel="stylesheet" href="${contextPath }/resources/css/mypage.css" />	
	<link rel="stylesheet" href="${contextPath}/resources/css/club/board.css" />
	<script type="text/javascript">
			
		$(document).ready(function(){
				
				setTotalInfo();
				
				$(".individual_cart_checkbox").on("change", function(){
					setTotalInfo($(".cart_info_td"));
				});
				
				$(".class_all_check_input").on("click", function(){
					if($(".class_all_check_input").prop("checked")){
						$(".individual_class_cart_checkbox").prop("checked", true);
					} else{
						$(".individual_class_cart_checkbox").prop("checked", false);
					}
					setTotalInfo($(".cart_info_td"));	
				});
				
				$(".item_all_check_input").on("click", function(){
					if($(".item_all_check_input").prop("checked")){
						$(".individual_item_cart_checkbox").prop("checked", true);
					} else{
						$(".individual_item_cart_checkbox").prop("checked", false);
					}
					setTotalInfo($(".cart_info_td"));	
				});
				
				$(".order_btn").on("click", function(){
					let form_contents ='';
					let orderNumber = 0;
					
					$(".cart_info_td").each(function(index, element){
						
						if($(element).find(".individual_cart_checkbox").is(":checked") === true){
							let goods_type = $(element).find(".individual_goodsType_input").val();
							let goods_code = $(element).find(".individual_goodsCode_input").val();
							let quantity = $(element).find(".individual_goodsCount_input").val();
							
							let goods_type_input = "<input name='orders[" + orderNumber + "].goods_type' type='hidden' value='" + goods_type + "'>";
							form_contents += goods_type_input;
							
							let goods_code_input = "<input name='orders[" + orderNumber + "].goods_code' type='hidden' value='" + goods_code + "'>";
							form_contents += goods_code_input;
							
							let quantity_input = "<input name='orders[" + orderNumber + "].quantity' type='hidden' value='" + quantity + "'>";
							form_contents += quantity_input;
							
							orderNumber += 1;
						}
						
					});
					
					$(".order_form").html(form_contents);
					$(".order_form").submit();
				});
				
			});
			
			function setTotalInfo(){
				let totalPrice = 0;
				let totalCount = 0;
				let totalKind = 0;
		
				$(".cart_info_td").each(function(index, element){
					if($(element).find(".individual_cart_checkbox").is(":checked") === true){	//????????????
						totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
						totalCount += parseInt($(element).find(".individual_goodsCount_input").val());
						totalKind += 1;			
					}
				});
				
				// ??? ??????
				$(".totalPrice_span").text(totalPrice.toLocaleString());
				// ??? ??????
				$(".totalCount_span").text(totalCount);
				// ??? ??????
				$(".totalKind_span").text(totalKind);	
			}
			
		$(function() {
			$("#myMenu ul:eq(2)").find("li:eq(0)").addClass("select")			
			
			$("#tab_menu li").click(function() {
				$(this).addClass("select")
				$(this).siblings().removeClass("select")
			})
			
			$("#tab_menu li:eq(0)").click(function() {
				$("#classList").css("display","block")
				$("#itemList").css("display","none")
			})
			
			$("#tab_menu li:eq(1)").click(function() {
				$("#classList").css("display","none")
				$("#itemList").css("display","block")
			})
			
		})
	</script>
	<style type="text/css">
		
		form {
		margin:0;
		display:inline;
		height:20px;
		}
		
		.table-cart {
			border-top: none;
			border-left: none;
			border-right: none;
			margin-bottom: 40px;
		}
		
		.listTitle {
			background-color: #ededed;
		}
		
		.table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
		  background-color: #fefaf0;
		}
		
	</style>
</head>
<body>
	<!-- CONTENTS -->
	<section>
		<div id="myInfo">
			<div class="profile">				
				<input type="hidden" name="mem_id" id="mem_id" value="${login.mem_id}" />
				<c:if test="${login.img == null}">
					<img src="${contextPath }/resources/img/profile_default.png" />
				</c:if>
				<c:if test="${login.img != null}">
					<img src="${contextPath }/memberImgDown.do?imageFileName=${login.img}" />				
				</c:if>				
				<a class="editBtn01" onclick="fn_imgEditPopup()">??????</a>
				<h1>${login.mem_name}</h1>
				<p>${login.mem_id}</p>
				<a class="editBtn02" href="${contextPath }/mypage/infoEditFrm.do">??????????????????</a>
			</div>
			
			<div class="hobby">
				<h2>??? ??????</h2>
				<c:if test="${not empty hobbyList}">
					<a class="editBtn02" href="${contextPath }/mypage/memHobby.do">??????</a>
					<ul>
						<c:forEach var="hobby" items="${hobbyList}">
							<li>
								<img src="${contextPath }/resources/img/hobby_img/${hobby.hobby_code}.png" />
							</li>						
						</c:forEach>						
					</ul>
				</c:if>
				<c:if test="${empty hobbyList}">
					<ul>
						<li class="noCnt">
							<a href="${contextPath }/mypage/memHobby.do">?????? ????????????</a>
						</li>
					</ul>
				</c:if>				
			</div>
			
			<div class="area">
				<h2>??? ??????</h2>
				<c:if test="${not empty areaList}">
					<a class="editBtn02" href="${contextPath }/mypage/memArea.do">??????</a>
					<ul>
						<c:forEach var="area" items="${areaList}">
							<li class="areaIcon">${area.name}</li>
						</c:forEach>						
					</ul>
				</c:if>
				<c:if test="${empty areaList}">
					<ul>
						<li class="noCnt">
							<a href="${contextPath }/mypage/memArea.do">?????? ????????????</a>
						</li>
					</ul>
				</c:if>
			</div>
		</div>
		
		<div id="myMenu">
			<h3>?????????</h3>
			<ul>
				<li><a href="${contextPath }/mypage/myActivList.do">??? ????????????</a></li>
				<li><a href="${contextPath }/mypage/mylikeList.do">????????????</a></li>
				<li><a href="${contextPath }/mypage/myAddItem.do">??? ????????????</a></li>
			</ul>
			
			<h3>????????????</h3>
			<ul>
				<li><a href="${contextPath }/mypage/cartClass.do">????????????</a></li>
				<li><a href="${contextPath }/order/contractList.do">?????? ??????</a></li>
			</ul>
			
			<h3>?????????</h3>
			<ul>
				<li><a href="${contextPath}/mypage/myReview.do">?????? ??????</a></li>
			</ul>
		</div>		
		
		
		<div id="myPageCont">
			<ul id="tab_menu">
				<li>?????????</li>
				<li class="select">????????????</li>
			</ul>
			
			<div id="classList">
				<div id="clubCont" style="width: 100%">
					<h3>?????? ?????? ??????</h3>
						
					<c:choose>
						<c:when test="${empty classReviewList }">		<!-- ???????????? ?????? ??? -->
							<p class="noList">????????? ???????????? ????????????!</p>
						</c:when>
						
						<c:when test="${not empty classReviewList }">
							<table id="clubBoard">
								<thead>
									<tr>
										<th width="5%">??????</th>
										<th width="30%">?????????</th>
										<th width="5%">??????</th>
										<th width="35%">????????????</th>
										<th width="10%">?????????</th>
										<th width="10%">??????</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="article" items="${classReviewList }" varStatus="articleNum">
										<tr>
											<td>${articleNum.count }</td>
											<td><a href="${contextPath}/class/classDetail.do?class_code=${article.cmt_class}">${article.className}</a></td>
											<td>
												<c:if test="${article.cmt_star == 5 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 4 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 3 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 2 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 1 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 0 }">
													???????????????
												</c:if>
											</td>
											<td>${article.cmt_content }</td>
											<td>${article.cmt_regdate }</td>
											<td><a href="${contextPath}/class/classReviewRemove.do?class_code=${article.cmt_class}&cmt_num=${article.cmt_num}"><input type="button" value="??????"></a></td>						
										</tr>
									</c:forEach>
								</tbody>					
							</table>		
						</c:when>
					</c:choose>
				</div>
			</div>
			
			<div id="itemList">
				<div id="clubCont" style="width: 100%">
					<h3>?????? ?????? ??????</h3>
						
					<c:choose>
						<c:when test="${empty itemReviewList }">		<!-- ???????????? ?????? ??? -->
							<p class="noList">????????? ???????????? ????????????!</p>
						</c:when>
						
						<c:when test="${not empty itemReviewList }">
							<table id="clubBoard">
								<thead>
									<tr>
										<th width="5%">??????</th>
										<th width="30%">?????????</th>
										<th width="5%">??????</th>
										<th width="35%">????????????</th>
										<th width="10%">?????????</th>
										<th width="10%">??????</th>
									</tr>
								</thead>
								
								<tbody>
									<c:forEach var="article" items="${itemReviewList }" varStatus="articleNum">
										<tr>
											<td>${articleNum.count }</td>
											<td><a href="${contextPath}/item/itemDetail.do?item_code=${article.cmt_item}">${article.item_name}</a></td>
											<td>
												<c:if test="${article.cmt_star == 5 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 4 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 3 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 2 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 1 }">
													???????????????
												</c:if>
												<c:if test="${article.cmt_star == 0 }">
													???????????????
												</c:if>
											</td>
											<td>${article.cmt_content }</td>
											<td>${article.cmt_regdate }</td>
											<td><a href="${contextPath}/item/itemReviewRemove.do?item_code=${article.cmt_item}&cmt_num=${article.cmt_num}"><input type="button" value="??????"></a></td>							
										</tr>
									</c:forEach>
								</tbody>
													
							</table>		
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	
		
		<div id="imgEdit_div" class="popup_div profile">
			<h4>????????? ?????? ??????</h4>
			<button class="closeBtn">??????</button>
			<form action="${contextPath }/mypage/updateImg.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="mem_id" id="mem_id" value="${login.mem_id}" />
				<c:if test="${login.img == null}">
					<img id="mem_img" src="${contextPath }/resources/img/profile_default.png" />
				</c:if>
				<c:if test="${login.img != null}">
					<img id="mem_img" src="${contextPath }/memImgDown.do?imageFileName=${login.img}" />				
				</c:if>
				<input type="file" name="file" id="mem_imgfile" onchange="readURL(this, 0)" />
				<button type="submit" class="pointBtn">??????</button>
				<button type="button" class="basicBtn" onclick="fn_delURL()">??????</button>
			</form>
		</div>		
	</section>
</body>
</html>
