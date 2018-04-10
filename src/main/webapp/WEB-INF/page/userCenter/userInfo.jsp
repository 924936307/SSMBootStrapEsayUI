<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    function checkLogin(flightId) {
        if ('${user}' == '') {
            alert("请先登录，然后购票");
        } else {
            window.location.href = '${pageContext.request.contextPath}/ticket/preTicketOrder?flightId='
                + flightId;
        }
    }
    function update01() {
        var pwd3 = false;
        var trueName3 = false;
        var email3 = false;
        var sfz3 = false;
        var phone3 = false;

        // 验证用户名
        $("#userName").focus(function () {
            $("#error2").html("用户名不可更改！！！");
        });
        // 验证密码
        $("#password").mouseout(function () {
            validate($(this));
        });
        // 验证身份证
        $("#sfz").mouseout(function () {
            validate($(this));
        });

        // 验证邮箱
        $("#email").mouseout(function () {
            validate($(this));
        });
        // 验证手机号码
        $("#phone").mouseout(function () {
            validate($(this));
        });
        // 提交表单
        $("#save01").submit(function () {
            var flag = true;
            $(this).find("button").each(function (i, ele) {
                if (!validate($(ele))) {
                    flag = false;
                }
            });
            return flag;
        });
    }
    //验证方法
    function validate($dom) {
        var v = $dom.val();
        var id = $dom.attr("id");
        var flag = true;
        switch (id) {
            case "password":
                $("#error2").html("");
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
                    //alert(pwd3);
                    checkSubmit();
                }
                break;
            case "sfz":
                $("#error2").html("");
                var reg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("身份证为必填项");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (reg.test(v) == false) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("身份证格式错误，有18个字符");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    sfz3 = true;
                    //alert(sfz3)
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
                        .html("邮箱格式不正确，请重新输入");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    email3 = true;
                    //	alert(email3);
                    checkSubmit();
                }
                break;
            case "phone":
                $("#error2").html("");
                var reg = /^1+\d{10}$/;
                if (v == "") {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("手机号码是必填项");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else if (reg.test(v) == false) {
                    $("#error2").removeClass().addClass("register_prompt_error")
                        .html("手机格式不正确，请重新输入");
                    $dom.removeClass().addClass(
                        "register_input register_input_Blur");
                    flag = false;
                } else {
                    $("#error2").removeClass().addClass("register_prompt_ok");
                    $dom.removeClass().addClass("register_input");
                    phone3 = true;
                    //alert(phone3);
                    checkSubmit();
                }
                break;
            default:
                break;
        }
        return flag;
    }
    function checkSubmit() {
        if (pwd3 && phone3 && email3 && sfz3) {
            $("#save01").removeAttr("disabled");

        }
    }
    function save() {
        var userName = $("#userName").val();
        var password = $("#password").val();
        var trueName = $("#trueName").val();
        var sex = $("#sex").val();
        var sfz = $("#sfz").val();
        var email = $("#email").val();
        var phone = $("#phone").val();
        if (trueName == null || trueName == "") {
            document.getElementById("error2").innerHTML = "真实姓名不能为空！";
            return;
        }

        if (sex == null || sex == "") {
            document.getElementById("error2").innerHTML = "请选择性别！";
            return;
        }
        $
            .post(
                "${pageContext.request.contextPath}/user/save",
                {
                    'id': '${user.id}',
                    'username': userName,
                    'password': password,
                    'truename': trueName,
                    'sex': sex,
                    'sfz': sfz,
                    'email': email,
                    'phone': phone
                },
                function (result) {
                    var result = eval('(' + result + ')');
                    if (result.error) {
                        document.getElementById("error2").innerHTML = result.error;
                    } else {
                        alert("修改成功！");
                        window.location.href = "${pageContext.request.contextPath}/user/showUserInfo";
                    }
                });
    }
</script>
<style type="text/css">
    th {
        text-align: center;
    }
</style>
<div style="padding-left: 10px;">
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px;">用户信息</div>
        <table class="table" style="text-align: center;">
            <thead>
            <tr style="text-align: center;">
                <th>编号</th>
                <th>用户名</th>
                <th>密码</th>
                <th>真实姓名</th>
                <th>性别</th>
                <th>邮件</th>
                <th>联系电话</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${user.id }</td>
                <td>${user.username }</td>
                <td>${user.password }</td>
                <td>${user.truename }</td>
                <td>${user.sex }</td>
                <td>${user.email }</td>
                <td>${user.phone }</td>
                <td><input type="button" value="修改" data-toggle="modal"
                           data-target="#myModal" onclick="update01()"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>


<div class="modal fade " id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 450px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">用户信息修改</h4>
            </div>
            <div class="modal-body">
                <form method="post"
                      action="${pageContext.request.contextPath}/TicketOrderSys/user/save">
                    <table align="center">
                        <tr height="40px;">
                            <td width="100px;">用户名：</td>
                            <td><input type="text" id="username" name="username"
                                       value="${user.userName }" readonly="readonly"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>密码：</td>
                            <td><input type="text" id="password" name="password"
                                       value="${user.password }"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>真实姓名：</td>
                            <td><input type="text" id="truename" name="truename"
                                       value="${user.trueName }"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>性别：</td>
                            <td><select style="width: 170px;" id="sex" name="sex">
                                <option value="">请选择..</option>
                                <option value="男" ${'男'==user.sex?'selected':'' }>男</option>
                                <option value="女" ${'女'==user.sex?'selected':'' }>女</option>
                            </select></td>
                        </tr>
                        <tr height="40px;">
                            <td>身份证：</td>
                            <td><input type="text" id="sfz" name="sfz"
                                       value="${user.sfz }"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>邮件：</td>
                            <td><input type="text" id="email" name="email"
                                       value="${user.email }"/></td>
                        </tr>
                        <tr height="40px;">
                            <td>联系电话：</td>
                            <td><input type="text" id="phone" name="phone"
                                       value="${user.phone }"/></td>
                        </tr>
                        <tr>
                            <td colspan="2"><span id="error2" style="color: red"></span></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
                <button id="save01" type="button" class="btn btn-primary"
                        onclick="save()" disabled="disabled">保存
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>