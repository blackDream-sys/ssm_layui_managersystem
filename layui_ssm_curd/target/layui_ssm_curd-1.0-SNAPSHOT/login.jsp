<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>账单管理系统-后台登录</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/css/xadmin.css">
    <script src="${pageContext.request.contextPath}/statics/layui/layui.js"></script>
</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">账单管理系统-管理登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" >
        <input name="loginName" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
        <hr class="hr20" >
    </form>
</div>

<script>
    layui.use(['form','jquery','layer'],function () {
        var form = layui.form;
        var $ = layui.jquery;
        var layer = layui.layer;

        //监听表单的提交事件
        form.on("submit(login)",function (data) {
            $.post("/user/login",data.field,function(result){
                console.log(result);
                //判断是否成功
                if(result.success){
                    //成功跳到index.jsp
                    location.href="/index";
                    //此处有个bug，密码输错也能登陆，只要用户名正确，密码不为空就可以登录，在userMapper里面
                    // 加上and pwd=pwd（#，{}），用户名和密码输正确的也显示用户名和密码错误
                    //以后在解决
                }else{
                    layer.msg("用户名密码错误，登录失败");
                }
            },"json");
            //禁止页面跳转
            return false;
        })

    });
</script>
<%--<script>
    layui.use(['form','jquery','layer'],function () {
        var form = layui.form;
        var $ = layui.jquery;
        var layer = layui.layer;
        form.on("submit(login)",function (data) {
            $.post("/user/login",data.field,function (result) {
                console.log(result);
                if (result.success){
                    location.href="/index";
                }else{
                    layer.msg("用户名密码错误，登录失败");
                }
            },"json");
        })
    });

</script>--%>

</body>
</html>