<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<html>
<head>
    <title>This is index page</title>

    <link rel="stylesheet" href="<%= ctx%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%= ctx%>/css/bootstrap-datetimepicker.css">
    <link rel="stylesheet" href="<%= ctx%>/css/bootstrapValidator.css">
    <link rel="stylesheet" href="<%= ctx%>/css/crm.css">
    <script src="<%= ctx%>/js/jquery-2.1.1.js"></script>
    <script src="<%= ctx%>/js/bootstrap.js"></script>
    <script src="<%= ctx%>/js/bootstrap-datetimepicker.js"></script>
    <script src="<%= ctx%>/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="<%= ctx%>/js/bootstrapValidator.js"></script>
    <script src="<%= ctx%>/js/bootstrapValidator.zh-CN.js"></script>

    <script type="text/javascript">
        $(function () {
            $('#registerForm').bootstrapValidator({
                message: '这个值没有被验证',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    'credential.username': {
                        message: '用户名还没有验证',
                        validators: {
                            notEmpty: {
                                message: '用户名不能为空'
                            },
                            stringLength: {
                                min: 3,
                                max: 16,
                                message: '用户名长度在3到16位之间'
                            }
                        }
                    },
                    'credential.password': {
                        message: '密码还没有验证',
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            },
                            stringLength: {
                                min: 6,
                                max: 16,
                                message: '密码长度在6到16之间'
                            },
                            different: {
                                field: 'credential.username',
                                message: '密码不能和用户名相同'
                            }
                        }
                    },
                    password_confirm: {
                        message: '密码重复还没有验证',
                        validators: {
                            notEmpty: {
                                message: '密码重复不能为空'
                            },
                            stringLength: {
                                min: 6,
                                max: 16,
                                message: '密码长度在6到16之间'
                            },
                            identical: {
                                field: 'credential.password',
                                message: '两次密码不同请重新输入'
                            }
                        }
                    },
                    'user.name': {
                        message: '真实姓名还没有验证',
                        validators: {
                            notEmpty: {
                                message: '真实姓名不能为空'
                            },
                            stringLength: {
                                min: 2,
                                max: 16,
                                message: '真实姓名长度在2到16位之间'
                            }
                        }
                    },
                    'user.gender': {
                        message: '性别还没有验证',
                        validators: {
                            notEmpty: {
                                message: '性别不能为空'
                            },
                            stringLength: {
                                min: 1,
                                max: 1,
                                message: '性别长度为1'
                            }
                        }
                    },
                    'user.address': {
                        //no need to validate
                    },
                    'user.mail': {
                        validators: {
                            notEmpty: {
                                message: '邮箱是必填项'
                            },
                            emailAddress: {
                                message: '邮箱格式不正确'
                            }
                        }
                    },
                    'user.phone': {
                        message: '电话还没有验证',
                        validators: {
                            notEmpty: {
                                message: '电话不能为空'
                            },
                            stringLength: {
                                min: 8,
                                max: 16,
                                message: '电话长度在8到16位之间'
                            }
                        }
                    },
                    'user.birthday': {
                        message: '生日还没有验证',
                        validators: {
                            notEmpty: {
                                message: '生日不能为空'
                            },
                            stringLength: {
                                min: 10,
                                max: 10,
                                message: '生日长度为10'
                            }
                        }
                    }
                }
            }).on('success.form.bv', function (e) {
                // Prevent form submission
                e.preventDefault();
                // Get the form instance
                var $form = $(e.target);
                // Get the BootstrapValidator instance
                var bv = $form.data('bootstrapValidator');
                // Use Ajax to submit form data
                $.post("<%= ctx%>/user/register.do", $form.serialize(), function (data) {
                    console.log(data)
                    if (data.Status == "ok") {
                        window.location.href = "<%= ctx%>/index.jsp";
                    }
                    else if (data.Status == "error") {
                        alert(data.Message);
                    }
                    else {
                        //alert("未知错误");
                        alert(data);
                    }
                });
            });
        });
    </script>
</head>
<body>
<form action="<%= ctx%>/user/register.do" method="post" id="registerForm">
    <div style="margin:0 auto; width:350px;">
        <div class="form-group form-inline">
            <label>&ensp;用户名&ensp;&emsp;</label>
            <input type="text" name="credential.username" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>&ensp;密&emsp;码&ensp;&emsp;</label>
            <input type="password" name="credential.password" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>确认密码&emsp;</label>
            <input type="password" name="password_confirm" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>真实姓名&emsp;</label>
            <input type="text" name="user.name" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>&ensp;性&emsp;别&ensp;&emsp;&emsp;&emsp;&emsp;</label>
            <input type="radio" name="user.gender" value="男">男&emsp;&emsp;
            <input type="radio" name="user.gender" value="女" checked>女
        </div>
        <div class="form-group form-inline">
            <label>&ensp;住&emsp;址&ensp;&emsp;</label>
            <input type="text" name="user.address" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>&ensp;邮&emsp;箱&ensp;&emsp;</label>
            <input type="text" name="user.mail" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>&ensp;电&emsp;话&ensp;&emsp;</label>
            <input type="text" name="user.phone" class="form-control" />
        </div>
        <div class="form-group form-inline">
            <label>&ensp;生&emsp;日&ensp;&emsp;</label>
            <input class="form_datetime form-control" type="text" name="user.birthday" value="1990-01-07" readonly>
        </div>

        <button type="submit" class="btn btn-primary">注册</button>
        <button type="reset" class="btn btn-default">重置</button>
    </div>
</form>
</body>
</html>