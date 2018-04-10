<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
    // 登录
    function login() {
        var userName = $("#username").val();
        var password = $("#password").val();
        if (userName == null || userName == "") {
            document.getElementById("error").innerHTML = "用户名不能为空！";
            return;
        }
        if (password == null || password == "") {
            document.getElementById("error").innerHTML = "密码不能为空！";
            return;
        }

        $.ajax({
            url: '/MavenDemo/user/login',
            method: 'post',
            data: {
                username: userName,
                password: password
            },
            success: function (result) {
                var info = eval('(' + result + ')');
                if (info.success) {
                    window.location.href = "${pageContext.request.contextPath}/flight/indexList";

                } else {
                    document.getElementById("error").innerHTML = "用户名或密码错误！";
                }
            }
        });
    }
    //获得时间日期
    function getDateTime() {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1)
            : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var weekday = date.getDay();
        var week = new Array("星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六")
        var h = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        var m = date.getMinutes() < 10 ? "0" + date.getMinutes() : date
            .getMinutes();
        var s = date.getSeconds() < 10 ? "0" + date.getSeconds() : date
            .getSeconds();
        if (h > 12) {
            h = h - 12;
            if (h < 10) {
                h = "0" + h;
            }
            var sContent = year + "年" + month + "月" + day + "日" + "<br>"
                + week[weekday] + "<br>" + h + "时" + m + "分" + s + "秒";
        } else {
            var sContent = year + "年" + month + "月" + day + "日" + "<br>"
                + week[weekday] + "<br>" + h + "时" + m + "分" + s + "秒";
        }
        document.getElementById("clock").innerHTML = "<h4>" + sContent
            + "</h4>";
        setTimeout("getDateTime()", 200);
    }
    // 安全退出
    function logout() {
        if (confirm("您确认要退出系统吗？")) {
            $
                .post(
                    "${pageContext.request.contextPath}/user/logout",
                    {},
                    function (result) {
                        var result = eval('(' + result + ')');
                        if (result.success) {
                            window.location.href = "/MavenDemo/flight/indexList";
                        }
                    });
        }
    }

    // 用户注册
    function register1() {
        /*  var name3 = false;
         var pwd3 = false;
         var repwd3 = false;
         var email3 = false;*/
        // 验证用户名
        $("#userName2").blur(function () {
            validate($(this));
        });
        // 验证密码
        $("#pwd").blur(function () {
            validate($(this));
        });
        // 验证重复密码
        $("#pwd2").blur(function () {
            validate($(this));
        });

        // 验证邮箱
        $("#email").mouseout(function () {
            validate($(this));
        });
        // 提交表单
        $("#myform01").submit(function () {
            var flag = true;
            $(this).find("button").each(function (i, ele) {
                if (!validate($(ele))) {
                    flag = false;
                }
            });
            return flag;
        });

    }
    function register() {
        var userName = $("#userName2").val();
        var pwd = $("#pwd").val();
        var email = $("#email").val();
        $
            .post(
                "${pageContext.request.contextPath}/user/register",
                {
                    'userName': userName,
                    'password': pwd,
                    'email': email
                },
                function (result) {
                    var result = eval('(' + result + ')');
                    if (result.error) {
                        document.getElementById("error2").innerHTML = result.error;
                    } else {
                        alert("注册成功！请登录！");
                        window.location.href = "${pageContext.request.contextPath}/flight/indexList";
                    }
                });
    }
    function validate($dom) {
        var v = $dom.val();
        var id = $dom.attr("id");
        var flag = true;
        switch (id) {
            case "userName2":
                $("#error2").html("");
                var name = /^[a-zA-Z]{1}\w{3,9}$/;
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("用户名是必填项");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (name.test(v) == false) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("用户名格式不正确，请重新输入");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    name3 = true;
                    // ("22"+name);
                    checkSubmit();
                }
                // alert('123');
                break;
            case "pwd":
                $("#pwd").html("");
                var reg = /^[a-zA-Z0-9]{5,10}$/;
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("密码为必填项");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (reg.test(v) == false) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("格式错误，不能单纯使用数字/字母,5-10个字符");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    pwd3 = true;
                    // alert(pwd);
                    checkSubmit();
                }
                break;
            case "pwd2":
                $("#error2").html("");
                var repwd = $("#pwd2").val().trim();
                var pwd = $("#pwd").val().trim();
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("请输入您的密码");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (pwd != repwd) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("密码不一致，请重新输入");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    repwd3 = true;
                    // alert(repwd);
                    checkSubmit();
                }
                break;
            case "email":
                $("#error2").html("");
                var reg = /^\w+@\w+(\.[a-zA-Z]{2,3}){1,2}$/;
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("电子邮件是必填项");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (reg.test(v) == false) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("格式不正确，请重新输入");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    email3 = true;
                    // alert(email);
                    checkSubmit();
                }
                break;
            default:
                break;
        }
        return flag;
    }
    function checkSubmit() {
        // alert(name);
        if (name3 && pwd3 && repwd3 && email3) {
            $("#myform01").removeAttr("disabled");
            // alert('123');
        }
    }
    function resetValue() {
        $("#fromCity").val("");
        $("#toCity").val("");
        $("#fromTime").val("");
    }
</script>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">用户信息</h3>
    </div>
    <div class="panel-body">
        <c:if test="${currentUser!=null }">
        </c:if>
        <c:choose>
            <c:when test="${currentUser!=null }">
                <p>
                    欢迎旅客：<strong>${currentUser}</strong>&nbsp;&nbsp;<a
                        href="javascript:logout()"><font color="black">【安全退出】</font></a>
                </p>
                <a href="/MavenDemo/user/userCenter"
                   target="_blank"><font color="red"><strong>进入个人中心</strong></font></a>
                </p>
            </c:when>
            <c:otherwise>
                <form method="post"
                      action="/user/login">
                    <table style="height: 180px;">
                        <tr>
                            <td colspan="2" style="text-align: center; height: 12px;"><span
                                    id="error" style="color: red; text-align: center;"></span></td>
                        </tr>
                        <tr height="40px;">
                            <td>用户名:</td>
                            <td><input type="text" id="username" name="username"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>密&nbsp;&nbsp;&nbsp;码:</td>
                            <td><input type="password" id="password" name="password"/></td>
                        </tr>
                        <tr height="40px;">
                            <td><input type="button" value="登录" onclick="login()"
                                       style="margin-left: 24px;"/></td>
                            <td>&nbsp;&nbsp;<input onclick="register1()"
                                                   style="margin-left: 24px;" type="button" value="注册"
                                                   data-toggle="modal" data-target="#myModal"/></td>
                        </tr>
                    </table>
                </form>
            </c:otherwise>
        </c:choose>

    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">航班查询</h3>
    </div>
    <div class="panel-body">
        <form action="http://localhost:8080/MavenDemo/flight/search" method="post">
            <table>
                <tr height="40px;">
                    <td>出发地点:</td>
                    <td><input type="text" id="fromcity" name="fromcity"
                               value="${s_flight.fromcity}"/></td>
                </tr>
                <tr height="40px;">
                    <td>抵达地点:</td>
                    <td><input type="text" id="tocity" name="tocity"
                               value="${s_flight.tocity }"/></td>
                </tr>
                <tr height="40px;">
                    <td>出发日期:</td>
                    <td><input type="text" id="fromtime" class="Wdate"
                               onclick="WdatePicker()" name="departTime"
                               value="<fmt:formatDate value="${s_flight.fromTime }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
                    </td>
                </tr>
                <tr height="40px;">
                    <td style="margin-left: 24px;"><input type="submit" value="搜索"/></td>
                    <td style="margin-left: 24px;">&nbsp;&nbsp;<input
                            type="button" value="重置" onclick="resetValue()"/></td>
                </tr>
            </table>
        </form>
    </div>
</div>
<div id="clock" style="height: 72px; text-align: center;"></div>
<script type="text/javascript">
    getDateTime();
</script>

<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1"
     role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 350px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">用户注册</h4>
            </div>
            <div class="modal-body">
                <table align="center">
                    <tr height="40px;">
                        <td>用户名：</td>
                        <td><input type="text" id="userName2" autocomplete="off" name="userName"/></td>
                    </tr>
                    <tr height="40px;">
                        <td>密码：</td>
                        <td><input type="password" id="pwd" name="password"/></td>
                    </tr>
                    <tr height="40px;">
                        <td>确认密码：</td>
                        <td><input type="password" id="pwd2"/></td>
                    </tr>
                    <tr height="40px;">
                        <td>邮件：</td>
                        <td><input type="text" id="email" autocomplete="off" name="email"/></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span id="error2" style="color: red;"></span></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="register()"
                        id="myform01" disabled="disabled" style="margin-left: -80px;">注册
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>