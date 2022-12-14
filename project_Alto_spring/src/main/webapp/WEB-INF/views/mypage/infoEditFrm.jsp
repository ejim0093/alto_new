<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="info" value="${memInfo}" />
<fmt:parseDate value="${info.birth}" var="birth" pattern="yyyy-MM-dd" />
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, inital-scale=1.0">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="${path}/resources/css/member.css" />
	<link rel="stylesheet" href="${path}/resources/css/mypage.css" />	
	<script src="${path}/resources/js/essential-textbox.js"></script>	
	<script type="text/javascript">		
	
		$(function() {
			if($("#gender").val() == 'M') {
				$(".gender_div span:nth-child(1)").addClass("select")
			}else {
				$(".gender_div span:nth-child(2)").addClass("select")
			}
			
			if($("#mem_open").val() == 'Y') {
				$("#_mem_open").attr("checked","checked")
			}else {
				$("#_mem_open").removeAttr("checked")
			}
			
			$("#_mem_open").click(function() {
				if($(this).attr("checked") == 'checked') {
					$("#_mem_open").removeAttr("checked")
					$("#mem_open").val("N")
				}else {
					$("#_mem_open").attr("checked","checked")
					$("#mem_open").val("Y")
				}
			})
			
		})
	</script>
</head>
<body>
	
	<section>
		<div id="memberInfo" class="form-check form-switch">
			<a href="${path}/mypage/myMain.do" class="backBtn">back</a>
			<h2>회원정보수정</h2>
			<form name="memberFrm" method="post" action="${path}/mypage/modMemberInfo.do">
				<input type="hidden" name="mem_id" value="${login.mem_id}" />
				<input type="hidden" name="memberId_yn" value="${login.memberId_yn}" />
				<div class="memSection">
					<div class="info_div">
						<div class="align_div float_left">
							<input type="text" name="mem_name" class="essential" placeholder="이름" value="${info.mem_name}" />
							<span class="noti2">필수 입력입니다.</span>
						</div>
						<div class="align_div float_right">
							<input type="hidden" name="gender" id="gender" value="${info.gender}" />
							<div class="gender_div"><span class="gender">남</span><span class="gender">여</span></div>
							<span class="noti2">필수 선택</span>
						</div>
					</div>										
					<input type="text" id="datepicker" name="birth" class="essential" placeholder="생일" value="<fmt:formatDate value="${birth}" pattern="yyyy-MM-dd" />" autocomplete='off' />
					<span class="noti2">필수 입력입니다.</span>	
					<input type="text" id="phone" name="phone" placeholder="휴대폰" value="${info.phone}" />
					<input type="hidden" id="mem_open" name="mem_open" value="${info.mem_open}" />
					<input class="form-check-input" type="checkbox" name="_mem_open" id="_mem_open"/>
					<label class="form-check-label" for="_mem_open">정보 공개 여부</label><br/>					
				</div>
				<button type="submit" class="pointBtn size0" onclick="return checkinfo(memberFrm)">수정하기</button> 
				<button type="button" class="basicBtn02 size0" onclick="location.href='${path}/mypage/pwUpdateFrm.do'">비밀번호 변경하기</button>
				<button type="button" class="basicBtn size0" onclick="location.href='${path}/mypage/delMemFrm.do'">회원탈퇴</button>				 
			</form>			
		</div>
	</section>
	
</body>
</html>