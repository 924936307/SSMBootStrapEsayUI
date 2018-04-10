<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:url value="/resources/core/images/logo2.png"
			var="assets4"/>
<link href="${assets4}" rel="icon"/>
<div align="center"  style="padding-bottom: 10px;">
	<table width="100%" >
		<tr >
			<td width="10%" style="text-align:center"><a href="${pageContext.request.contextPath}/TicketOrderSys/flight/indexList"><img alt="logo" src="${assets4}"  ></a></td>
	</tr>
	</table>
</div>
