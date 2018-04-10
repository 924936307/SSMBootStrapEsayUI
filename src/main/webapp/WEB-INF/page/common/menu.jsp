<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	$(function() {
		//导航切换
		$(".menuson li").click(function() {
			$(".menuson li.active").removeClass("active")
			$(this).addClass("active");
		});

		$('.title').click(function() {
			var $ul = $(this).next('ul');
			$('dd').find('ul').slideUp();
			if ($ul.is(':visible')) {
				$(this).next('ul').slideUp();
			} else {
				$(this).next('ul').slideDown();
			}
		});
	})
	function logout() {
		if (confirm("您确认要退出系统吗？")) {
			$
					.post(
							"${pageContext.request.contextPath}/user/logout",
							{},
							function(result) {
								var result = eval('(' + result + ')');
								if (result.success) {
									window.location.href = "${pageContext.request.contextPath}/flight/indexList";
								}
							});
		}
	}
	function refund(id) {
		if (confirm("您确认要退票吗？")) {
			$
					.post(
							"${pageContext.request.contextPath}/ticket/refund",
							{
								id : id
							},
							function(result) {
								var result = eval('(' + result + ')');
								if (result.success) {
									alert("退票成功！");
									window.location.href = "${pageContext.request.contextPath}/ticket/myTicketOrderList";
								}
							});
		}
	}
</script>
<div class="div_01">
	<div class="lefttop">导航栏</div>

	<dl class="leftmenu">

		<dd>
			<div class="title">个人信息</div>
			<ul class="menuson">
				<li><cite></cite> <a
					href="${pageContext.request.contextPath}/user/showUserInfo">个人信息</a><i></i></li>
			</ul>
		</dd>

		<dd>
			<div class="title">订单管理</div>
			<ul class="menuson">
				<li><cite></cite> <a
					href="${pageContext.request.contextPath}/ticketOrder/myTicketOrderList">机票信息</a>
					<i></i></li>
			</ul>
		</dd>

		<dd>

			<div>
				<a href="javascript:logout()" class="title">安全退出</a>
			</div>
		</dd>
	</dl>
</div>
