/**
 * 필수입력 textbox
 */
 /* joinFrm Validation */
function checkinfo(obj) {
	let ch_name = checkName(obj.mem_name.value)
	let ch_birth = checkBirth(obj.birth.value)
	
	let vali = ch_name && ch_birth			

	if (!vali) {			
		return false
	}			
	
	if (confirm("정보를 수정하시겠습니까?")) {
		obj.submit()
		return false
	}
	
}

function checkAll(obj) {
	let ch_pass = checkPass(memberFrm.mem_pwd.value, memberFrm.mem_pwd_2.value)
	let ch_name = checkName(memberFrm.mem_name.value)
	let ch_birth = checkBirth(memberFrm.birth.value)
	let ch_gen = checkGender()
	let ch_mail = checkUserMail(memberFrm._mem_id.value)	
	
	let vali = ch_mail && ch_pass && ch_name && ch_birth && ch_gen	
	
	if (!vali) {			
		return false
	}
	
	if($("#memberId_yn").val() == 'N') {
		alert("이메일 중복 체크를 해주세요.")
		return false
	}
	
	if (confirm("회원가입하시겠습니까?")) {
		obj.submit()
		return false
	}
	
}
	
function checkExistData(element, value) {
	if(value == "") {
		element.className += " notiTxt"
		let nextEle = element.nextElementSibling
		nextEle.textContent = "필수 입력입니다."
		nextEle.style.display = "block"
		return false
	}
	return true
}

function checkUserMail(email) {
	if (!checkExistData(memberFrm._mem_id, email))
		return false
	
	let emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/
	if (!emailRegExp.test(email)) {
		memberFrm._mem_id.className += " notiTxt"
		let nextEle = memberFrm._mem_id.nextElementSibling
		nextEle.textContent = "올바른 이메일이 아닙니다."
		nextEle.style.display = "block"
		nextEle.style.color = "#00c7ae"
		memberFrm._mem_id.style.borderColor = "#00c7ae"
		
		memberFrm._mem_id.value=""
		memberFrm._mem_id.focus()
		return false
	}
	return true
}

function checkPass(pwd1, pwd2) {
	if (!checkExistData(memberFrm.mem_pwd, pwd1) && !checkExistData(memberFrm.mem_pwd_2, pwd2))
		return false
	
	let password1RegExp = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,12}$/        
		
	if (!password1RegExp.test(pwd1)) {  
		memberFrm.mem_pwd.className += " notiTxt"
		let nextEle = memberFrm.mem_pwd.nextElementSibling
		nextEle.textContent = "영문 대소문자와 숫자 조합, 8~12자"
		nextEle.style.display = "block" 
		nextEle.style.color = "#00c7ae" 
		memberFrm.mem_pwd.style.borderColor = "#00c7ae"       
		         
		memberFrm.mem_pwd.value = ""  
		memberFrm.mem_pwd_2.value = ""           
		memberFrm.mem_pwd.focus()            
		return false     
	}        
	
	if (pwd1 != pwd2) {  
		nextEle = memberFrm.mem_pwd_2.nextElementSibling
		nextEle.textContent = "패스워드가 일치하지 않습니다."
		nextEle.style.display = "block"
		nextEle.style.color = "#00c7ae"
		memberFrm.mem_pwd_2.style.borderColor = "#00c7ae" 
		                    
		memberFrm.mem_pwd_2.value = ""            
		memberFrm.mem_pwd_2.focus()           
		return false        
	}
	return true
						
}

function checkName(name) {
	if (!checkExistData(memberFrm.mem_name, name))
		return false
	return true
}

function checkBirth(birth) {
	if (!checkExistData(memberFrm.birth, birth))
		return false
	return true
} 

function checkGender() {
	if($(".gender_div").find("span.select").length == 0) {
		$(".gender_div").next("span.noti2").css("display","block")
		return false
	}
	return true
}
 
 
 
 $(function() {
 
	/* 필수 입력 알림 css */	
	let essen = $("#payment_div .essential").length
	for (let i=0 ; i <= essen ; i++) {
		
		if ($("#payment_div .essential:eq("+i+")").val() == "") {
			$("#payment_div .essential:eq("+i+")").addClass("notiTxt")
			$("#payment_div .essential:eq("+i+")").next("span.noti2").css("display","block")
		}else {
			$("#payment_div .essential:eq("+i+")").removeClass("notiTxt")
			$("#payment_div .essential:eq("+i+")").next("span.noti2").css("display","none")
		}
		
	}			
	
	/* 결제 */
	$("#payment_div .essential").on("change keyup paste", function() {
		if ($(this).val() == "") {
			$(this).addClass("notiTxt")		
			$(this).next("span.noti2").css("display","block")
		}else {
			$(this).removeClass("notiTxt")
			$(this).next("span.noti2").css("display","none")
		}
	})
	
	$("span.noti2").css("display","none")
	
	/* 회원가입 */	
	$("#member_div .essential").on("change keyup paste", function() {
		if ($(this).val() == "") {
			$(this).addClass("notiTxt")
			$(this).next("span.noti2").text("필수 입력입니다.")			
			$(this).next("span.noti2").css("display","block")
			$(this).css("border-color", "#F3BE34")	
			$(this).next("span.noti2").css("color","#F3BE34")
		}else {
			$(this).removeClass("notiTxt")
			$(this).css("border-color", "#e4e4e4")
			$(this).next("span.noti2").css("display","none")
		}
	})
	
	/* 회원정보 수정 */	
	$("#memberInfo .essential").on("change keyup paste", function() {
		if ($(this).val() == "") {
			$(this).addClass("notiTxt")
			$(this).next("span.noti2").text("필수 입력입니다.")			
			$(this).next("span.noti2").css("display","block")
			$(this).css("border-color", "#F3BE34")	
			$(this).next("span.noti2").css("color","#F3BE34")
		}else {
			$(this).removeClass("notiTxt")
			$(this).css("border-color", "#e4e4e4")
			$(this).next("span.noti2").css("display","none")
		}
	})
	
	/* 비밀번호 입력 양식 알림 */
	$("#mem_pwd").on("keyup click", function() {
		$(this).next("span.noti2").text("영문 대소문자와 숫자 조합, 8~12자")			
		$(this).next("span.noti2").css("display","block")
		$(this).next("span.noti2").css("color","#00c7ae")
		$(this).css("border-color","#00c7ae")
	})
							
	/* birth - datepicker */	
	$("#datepicker").datepicker({
		changeMonth: true,
		changeYear: true,
		minDate: '-70y',
		yearRange: 'c-70:c+0',
		dateFormat: 'yy-mm-dd',
		showMonthAfterYear: true,
		dayNamesMin: ['일','월','화','수','목','금','토'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	})
	
	/* gender select */
	$(".gender_div span").click(function() {
		$(this).addClass("select")
		$(this).siblings().removeClass("select")
		$(".gender_div").next("span.noti2").css("display","none")
		
		if($(this).text() == '남') {
			$("#gender").attr("value","M")
		}else {
			$("#gender").attr("value","W")
		}
		
	})
			
})