<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="hobbyList" value="${mylikeMap.hobbyList}" />
<c:set var="areaList" value="${mylikeMap.areaList}" />
<c:set var="likeList" value="${mylikeMap.memlikeList}" />
<c:set var="clubList" value="${mylikeMap.clubList}" />
<c:set var="classList" value="${mylikeMap.classList}" />
<c:set var="itemList" value="${mylikeMap.itemList}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, inital-scale=1.0">
	<link rel="stylesheet" href="${contextPath }/resources/css/common/list.css" />	
	<link rel="stylesheet" href="${contextPath }/resources/css/mypage.css" />	
	<script type="text/javascript">
		$(function() {
			$("#myMenu ul:eq(1)").find("li:eq(1)").addClass("select")			
			
			$("#tab_menu li").click(function() {
				$(this).addClass("select")
				$(this).siblings().removeClass("select")
			})
			
			$("#tab_menu li:eq(0)").click(function() {
				$("#likeClubList").css("display","block")
				$("#likeClassList").css("display","none")
				$("#likeItemList").css("display","none")
			})
			
			$("#tab_menu li:eq(1)").click(function() {
				$("#likeClubList").css("display","none")
				$("#likeClassList").css("display","block")
				$("#likeItemList").css("display","none")
			})
			
			$("#tab_menu li:eq(2)").click(function() {
				$("#likeClubList").css("display","none")
				$("#likeClassList").css("display","none")
				$("#likeItemList").css("display","block")
			})
		})
	</script>
	<style type="text/css">
		.paging {
			font-size:large; 
			text-shadow: yellow;
		}
		
		.paging a {
			text-decoration: overline;
			font-weight: bolder; 
		}
		
		.order_table {
			background-color: none;
			border-top: none;
			border-left: none; 
			border-right: none;
		}
		
		.listTitle {
			background-color: #ededed;
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
			<div style="margin: 20px;">
				<h3>?????? ??????</h3>
				<table class="table order_table">
						<c:if test="${empty orderList}">
							<td colspan="7" align="center">?????? ????????? ????????????</td>
						</c:if>
						<c:if test="${not empty orderList}">
							<c:forEach items="${orderList }" var="orderList">
								<tr class="listTitle">
									<th colspan="2" width="10%">????????????</th>
									<td width="45%">${orderList.orderId }</td>
									<th width="10%">????????????</th>
									<td width="15%">${orderList.orderDate }</td>
									<th width="10%">????????????</th>
									<td width="10%">${orderList.orderState }</td>
								</tr>
								<tr>
									<td></td>
									<th></th>
									<th style="text-align: center;">?????????</th>
									<th colspan="2" style="text-align: center;">??????</th>
									<th colspan="2" style="text-align: center;">??????</th>
								</tr>
								<c:if test="${empty orderList.orders}">
									<tr>
										<td colspan="7" align="center">?????? ????????? ????????????</td>
									</tr>
								</c:if>
								<c:if test="${not empty orderList.orders}">
									<c:forEach items="${orderList.orders }" var="goodsList" varStatus="status">
										<tr>	
											<td></td>
											<td align="center">${status.count }</td>
											<td align="center">${goodsList.goods_name }</td>
											<td colspan="2" align="center">${goodsList.quantity }</td>
											<td colspan="2" align="center"><fmt:formatNumber value="${goodsList.price }" pattern="##,###,###" /></td>
										</tr>
									</c:forEach>
									<tr style="border: none;"><td style="border: none; height: 30px;" colspan="7"></td></tr>
								</c:if>
							</c:forEach>	
							
							    <tr align="center" class="paging">
							    	<td colspan="7">
								        <c:if test="${pageMarker.prev}">
								            <a href="${contextPath }/order/contractList.do?page=${pageMaker.startPage - 1}">??????</a>
								        </c:if>
								        <c:forEach begin="${pageMarker.startPage}" end="${pageMarker.endPage}" var="idx">
								               <a href="${contextPath }/order/contractList.do?page=${idx}">${idx}</a>
								        </c:forEach>
								        <c:if test="${pageMarker.next && pageMarker.endPage > 0}">
								            <a href="${contextPath }/order/contractList.do?page=${pageMaker.endPage + 1}">??????</a>
								        </c:if>
							        </td>
							    </tr>
							    
						</c:if>
					</table>
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