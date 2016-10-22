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
            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd",
                autoclose: true,
                todayBtn: true,
                todayHighlight: true,
                showMeridian: true,
                pickerPosition: "bottom-left",
                language: 'zh-CN',//中文，需要引用zh-CN.js包
                startView: 2,//月视图
                minView: 2//日期时间选择器所能够提供的最精确的时间选择视图
            });

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
                        },
                        remote: {
                            url: '/user/isUsernameValid.do',
                            message: '用户已存在',
                            delay :  2000,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST'//请求方式
                            /**自定义提交数据，默认值提交当前input value
                             *  data: function(validator) {
                               return {
                                   password: $('[name="passwordNameAttributeInYourForm"]').val(),
                                   whatever: $('[name="whateverNameAttributeInYourForm"]').val()
                               };
                            }
                             */
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
                $.post("<%= ctx%>/user/registerUser.do", $form.serialize(), function (data) {
                    console.log(data)
                    if (data.Status == "ok") {
                        window.location.href = "<%= ctx%>/index.jsp";
                    }
                    else if (data.Status == "error") {
                        alert(data.Message);
                    }
                    else {
                        //alert("未知错误");
                        //alert(data);
                    }
                });
            });
        });
    </script>
</head>
<body>
<form id="registerForm">
    <div style="margin:0 auto; width:350px;">
        <h1 class="text-danger text-center">用户注册</h1>
        <br>
        <div class="form-group form-inline">
            &ensp;用户名&ensp;&emsp;
            <input type="text" name="credential.username" class="form-control" />
        </div>
        <div class="form-group form-inline">
            &ensp;密&emsp;码&ensp;&emsp;
            <input type="password" name="credential.password" class="form-control" />
        </div>
        <div class="form-group form-inline">
            确认密码&emsp;
            <input type="password" name="password_confirm" class="form-control" />
        </div>
        <div class="form-group form-inline">
            真实姓名&emsp;
            <input type="text" name="user.name" class="form-control" />
        </div>
        <div class="form-group form-inline">
            &ensp;性&emsp;别&ensp;&emsp;&emsp;&emsp;&emsp;
            <input type="radio" name="user.gender" value="男">男&emsp;&emsp;
            <input type="radio" name="user.gender" value="女" checked>女
        </div>
        <div class="form-group form-inline">
            &ensp;住&emsp;址&ensp;&emsp;
            <input type="text" name="user.address" class="form-control" />
        </div>
        <div class="form-group form-inline">
           &ensp;邮&emsp;箱&ensp;&emsp;
            <input type="text" name="user.mail" class="form-control" />
        </div>
        <div class="form-group form-inline">
            &ensp;电&emsp;话&ensp;&emsp;
            <input type="text" name="user.phone" class="form-control" />
        </div>
        <div class="form-group form-inline">
            &ensp;生&emsp;日&ensp;&emsp;
            <input class="form_datetime form-control" type="text" name="user.birthday" value="1990-01-07" readonly>
        </div>
        &emsp;&emsp;&emsp;&emsp;&emsp;
        <button type="submit" class="btn btn-primary">注册</button>&emsp;&emsp;&emsp;
        <button type="reset" class="btn btn-default">重置</button>
    </div>
</form>
</body>
</html>