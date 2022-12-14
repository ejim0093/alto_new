<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, inital-scale=1.0">
	<link rel="stylesheet" href="${contextPath }/resources/css/class/list.css" /> 	
	<link rel="stylesheet" href="${contextPath }/resources/css/class/club.css" /> 
	<link href="${contextPath }/resources/css/class/class_main_sl.css" rel="stylesheet" />
	<script src="${contextPath }/resources/js/search_tabmenu.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#main_menu li:nth-child(2)").css("color","#00c7ae");
						
			/* 클럽개설 버튼 팝업 */
			$("#open_btn").mouseover(function() {
				$("div.info_div").show()
			})
			$("#open_btn").mouseout(function() {
				$("div.info_div").hide()
			})
			$("#open_btn").click(function() {
				location.href = '${contextPath}/class/classform.do'
			})
		})
		
		function sendSearchList() {
			
			let h_cnt = $("#m_cate ul li.select").length
			let hobbycodeList = Array(h_cnt)
			let a_cnt = $("#area_list ul li.select").length
			let areaCodeList = Array(a_cnt)
			
			//취미
/* 			for(let i=0; i<h_cnt; i++) {
				hobbycodeList[i] = " "
			} */
			
			for(i=0; i<h_cnt; i++) {
				let hobby_code = $("#m_cate ul li.select:eq("+i+")").children("img:eq(0)").attr("src")
					
				console.log(hobby_code)
				if(hobby_code !== undefined){
					hobby_code = hobby_code.substring(0, hobby_code.lastIndexOf("."))
					hobby_code = hobby_code.substring((hobby_code.lastIndexOf("/")+1), hobby_code.length)
					hobbycodeList[i] = hobby_code
				}
			}
			searchList.hobbyCodeList.value = hobbycodeList
			
			
			//지역
			for(let i=0; i<a_cnt; i++) {
				areaCodeList[i] = " "
			}
			
			for(i=0; i<a_cnt; i++) {
				let area_code = $("#area_list ul li.select:eq("+i+")").find('input[type=hidden]').val()
					
				console.log(area_code)
					
				areaCodeList[i] = area_code
			}
			searchList.areaCodeList.value = areaCodeList
		}
	
	</script>
</head>
<body>
	
	<!-- CONTENTS -->
	<section>
		<ul id="tab_menu">
			<li><span>전체 취미</span></li>
			<li><span>전체 지역</span></li>
		</ul>
		
		<div id="tab_area">
			<form action="${contextPath}/class/listClass.do" name="searchList"  onclick="return sendSearchList()" >
				<input type="hidden" name="hobbyCodeList" />
				<input type="hidden" name="areaCodeList" />
				<div id="m_cate">
					<ul>
						<li id="m_cate_all" class="all">전체</li>
						<c:forEach items="${hobbyList }" var="hobby">
							<c:if test="${hobby.hobby_code eq hobbyC}">
								<c:set var="in" value="true" />
							</c:if>
							<c:choose>
								<c:when test="${in}">
									<li class="select">
										<img src="${contextPath}/resources/img/hobby_img/${hobby.hobby_code}.png" />
										<p class="hobby_name">${hobby.name}</p>
									</li>
									<c:set var="in" value="false" />
								</c:when>
								<c:otherwise>
									<li>
										<img src="${contextPath}/resources/img/hobby_img/${hobby.hobby_code}.png" />
										<p class="hobby_name">${hobby.name}</p>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</div>
				<div id="s_cate">
					<ul>
						<li class="all select">전체</li>
					</ul>
				</div>
				<div id="area_list">
					<ul>
						<li class="all">전체</li>
						<c:forEach items="${areaList }" var="areaList">
							 <li>
							 <input type="hidden" value="${areaList.area_code }">
							 ${areaList.name }
							 </li>
						</c:forEach>
					</ul>
				</div>
				<button type="submit" id="opSearch_btn">선택 조건으로 검색</button>
			</form>
		</div>
		
		<div id="selectBoxArea">
			<div class="selectBox">Best순</div>
			<div class="selectBox select_list">
				<ul>
					<li><a href="${contextPath }/class/listClass.do?sort=stuU&hobbyC=${listMap.hobbyC }&keyword=${listMap.keyword }">회원수 많은</a></li>
					<li><a href="${contextPath }/class/listClass.do?sort=stuD&hobbyC=${listMap.hobbyC }&keyword=${listMap.keyword }">회원수 적은</a></li>
					<li><a href="${contextPath }/class/listClass.do?sort=fast&hobbyC=${listMap.hobbyC }&keyword=${listMap.keyword }">최근 일정</a></li>
					<li><a href="${contextPath }/class/listClass.do?sort=new&hobbyC=${listMap.hobbyC }&keyword=${listMap.keyword }">신규</a></li>
					<li><a href="${contextPath }/class/listClass.do?sort=old&hobbyC=${listMap.hobbyC }&keyword=${listMap.keyword }">오래된</a></li>
				</ul>
			</div>
		</div>
		
		
		<div id="search_result">
			<h2>클래스 검색 결과</h2>
			<div class="searchList">
				<ul class="club">
					<c:choose>
						<c:when test="${empty classList }">
							<tr height="10">
								<td colspan="4"><p><span style="font-size: 9pt;">일치하는 클래스가 없습니다.</span></p></td>
							</tr>
						</c:when>
						
						<c:when test="${!empty classList }">
							<c:forEach var="classList" items="${classList }">
								<li>
									<a href="${contextPath}/class/classDetail.do?class_code=${classList.class_code}">
									<div class="class_products_img"><img src="${contextPath}/download.do?imgName=${classList.imgName}&class_code=${classList.class_code}"></div>
									<span class="area">${classList.area_name }</span>
									<span class="hobby_icon"><img src="${contextPath }/resources/img/hobby_img/${classList.hobby_code }.png" /></span>
									<p class="club_name">${classList.className }</p>
									<span class="memNum" style="font-size: 11px">${classList.member_max }  명</span>
									<p class="club_schedule">
										<span class="s_icon2"></span><span><fmt:formatNumber value="${classList.price}" pattern="#,###" /> 원</span>
									</p>
									<span class="like_icon">관심</span>
									</a>
								</li>
							</c:forEach>
						</c:when>
					</c:choose>
				</ul>
			</div>
			
		</div>
		
		<div class="info_div">
			<p>원하는 클래스를 찾지 못하셨나요?</p>
			<span class="p_color">그럼 직접 만들어보세요!</span>
		</div>
		<div id="open_btn"></div>		
	</section>
		
	<%@include file="../layout/common_popup.jsp" %>
</body>
</html>