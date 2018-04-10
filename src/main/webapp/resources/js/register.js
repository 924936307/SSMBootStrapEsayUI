$(function() {

	var name2 = false;
	var pwd2 = false;
	var repwd2 = false;
	var phone2 = false;
	var email2 = false;
	function checkSubmit() {
		// alert(name);
		if (name2 && pwd2 && repwd2 && email2 && phone2) {
			$("#registerBtn").removeAttr("disabled");
			// alert('123');
		}
	}
	// 验证用户名
	$("#userName").focus(
			function() {
				$(this).removeClass().addClass(
						"register_input register_input_Focus");
				$("#userName_prompt").removeClass().addClass("register_prompt")
				.html("输入的用户名长不能小于6大于10");
			}).blur(function() {
		validate($(this));
	});
	// 验证密码
	$("#pwd").focus(
			function() {
				$(this).removeClass().addClass(
						"register_input register_input_Focus");
				$("#pwd_prompt").removeClass().addClass("register_prompt")
				.html("密码可由大小写英文字母、数字组成，长度为4-20个字符");
			}).blur(function() {
		validate($(this));
	});
	// 验证重复密码
	$("#repwd").focus(function() {
		$(this).removeClass().addClass("register_input register_input_Focus");
	}).blur(function() {
		validate($(this));
	});
	// 验证手机号码
	$("#telPhone").focus(
			function() {
				$(this).removeClass().addClass(
						"register_input register_input_Focus");
				$("#telPhone_prompt").removeClass().addClass("register_prompt")
				.html("手机号码由数字组成，首位必须为数字1，长度为11个字符");
			}).blur(function() {
		validate($(this));
	});
	// 验证邮箱
	$("#email").mouseenter(
			function() {
				$(this).removeClass().addClass(
						"register_input register_input_Focus");
				$("#email_prompt").removeClass().addClass("register_prompt")
				.html("此邮箱将用来接收验证和消息邮件");
			}).mouseout(function() {
		validate($(this));
	});
	// 提交表单
	$("#myform").submit(function() {
		var flag = true;
		$(this).find("input").each(function(i, ele) {
			if (!validate($(ele))) {
				flag = false;
			}
		});
		return flag;
	});
	// 验证方法
	function validate($dom) {
		var v = $dom.val();
		var id = $dom.attr("id");
		var flag = true;
		switch (id) {
		case "userName":
			$("#userName_prompt").html("");
			var name = /^[a-zA-Z]{1}\w{5,9}$/;
			if (v == "") {
				$("#userName_prompt").removeClass().addClass(
						"register_prompt_error").html("用户名是必填项，请输入您的用户名");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else if (name.test(v) == false) {
				$("#userName_prompt").removeClass().addClass(
						"register_prompt_error").html("用户名格式不正确，请重新输入");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else {
				$("#userName_prompt").removeClass().addClass(
						"register_prompt_ok");
				$dom.removeClass().addClass("register_input");
				name2 = true;
				// ("22"+name);
				checkSubmit();
			}
			// alert('123');
			break;
		case "pwd":
			$("#pwd_prompt").html("");
			var reg = /^[a-zA-Z0-9]{6,20}$/;
			if (v == "") {
				$("#pwd_prompt").removeClass()
						.addClass("register_prompt_error").html(
						"密码为必填项，请设置您的密码");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else if (reg.test(v) == false) {
				$("#pwd_prompt").removeClass()
						.addClass("register_prompt_error").html(
						"密码格式错误，请用大小写英文字母、数字，长度6-20个字符");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else {
				$("#pwd_prompt").removeClass().addClass("register_prompt_ok");
				$dom.removeClass().addClass("register_input");
				pwd2 = true;
				// alert(pwd);
				checkSubmit();
			}
			break;
		case "repwd":
			$("#repwd_prompt").html("");
			var repwd = $("#repwd").val().trim();
			var pwd = $("#pwd").val().trim();
			if (v == "") {
				$("#repwd_prompt").removeClass().addClass(
						"register_prompt_error").html("请输入您的密码");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else if (pwd != repwd) {
				$("#repwd_prompt").removeClass().addClass(
						"register_prompt_error").html("两次输入的密码不一致，请重新输入");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else {
				$("#repwd_prompt").removeClass().addClass("register_prompt_ok");
				$dom.removeClass().addClass("register_input");
				repwd2 = true;
				// alert(repwd);
				checkSubmit();
			}
			break;
		case "telPhone":
			$("#telPhone_prompt").html("");
			var phone = /^1+\d{10}$/;
			if (v == "") {
				$("#telPhone_prompt").removeClass().addClass(
						"register_prompt_error").html("手机号码为必选项，请输入您的手机号码");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else if (phone.test(v) == false) {
				$("#telPhone_prompt").removeClass().addClass(
						"register_prompt_error").html("手机号码格式错误，请用数字，长度11个字符");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else {
				$("#telPhone_prompt").removeClass().addClass(
						"register_prompt_ok");
				$dom.removeClass().addClass("register_input");
				phone2 = true;
				// alert(phone);
				checkSubmit();
			}
			break;
		case "email":
			$("#email_prompt").html("");
			var reg = /^\w+@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
			if (v == "") {
				$("#email_prompt").removeClass().addClass(
						"register_prompt_error").html("电子邮件是必填项，请输入您的Email地址");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else if (reg.test(v) == false) {
				$("#email_prompt").removeClass().addClass(
						"register_prompt_error").html("电子邮件格式不正确，请重新输入");
				$dom.removeClass().addClass(
						"register_input register_input_Blur");
				flag = false;
			} else {
				$("#email_prompt").removeClass().addClass("register_prompt_ok");
				$dom.removeClass().addClass("register_input");
				email2 = true;
				// alert(email);
				checkSubmit();
			}
			break;
		default:
			break;
		}
		return flag;
	}
});