<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- HEADER -->
	<header>
		<div>
			<h1 id="logo"><a href="../main.do">AlTo Alone Together</a></h1>
			<nav>
				<ul id="main_menu">
					<li><a href="../club/clubMain.jsp">모임</a></li>
					<li><a href="${path }/class/classMain.do">클래스</a></li>
					<li><a href="${path }/item/itemMain.do">취미용품</a></li>
				</ul>
			</nav>
			<form action="${path }/item/listItem.do" id="allSearch" name="allSearchForm">
				<input type="text" id="allSearch_keyword" name="keyword" placeholder="취미용품을 검색해보세요!"/>
				<input type="submit" id="search_btn" value="검색" />
			</form> 
			<c:if test="${not empty login}"> 
				<ul id="sub_menu">
					<li><a href="${path}/member/logout.do">로그아웃</a></li>
					<li><a href="${path}/mypage/myMain.do">마이페이지</a></li>
					<li><a href="${path}/faq/faqMain.do">FAQ</a></li>
				</ul>
			</c:if>
			
			<c:if test="${empty login}">
				<ul id="sub_menu">
					<li><a href="${path}/member/loginFrm.do">로그인</a></li>
					<li><a href="${path}/member/joinTerms.do">회원가입</a></li>
					<li><a href="${path}/faq/faqMain.do">FAQ</a></li>
				</ul>
			</c:if>			
			
		</div>		
	</header>
</body>
</html>