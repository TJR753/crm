<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName()
            + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script src="webjars/jquery/3.1.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="webjars/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body>
    $.ajax({
    url:"",
    data:"",
    dataType:"",
    type:"get",
    success:function (data){

    }
    })

    //获取时间组件
    $(".time").datetimepicker({
    minView:"month",
    language:"zh-CN",
    format:"yyyy-mm-dd",
    autoclose:true,
    todayBtn:true,
    pickerPosition:"bottom-left"
    })
http://127.0.0.1:8080/crm/login.jsp
</body>
</html>
