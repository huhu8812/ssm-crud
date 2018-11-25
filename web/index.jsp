<%--
  Created by IntelliJ IDEA.
  User: huhu
  Date: 2018/10/21
  Time: 下午7:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径，
        不以/开始的相对路径，找资源，以当前路径为基准，容易出问题
        以/路径开始的，找资源，以服务器路径为基准-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- Modal -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>

<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn-primary" id="emp_add_model_btn">新增</button>
            <button class="btn-danger">删除</button>
        </div>
    </div>
    <!-- 表格 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <!-- 显示分页信息 -->

    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>

</div>

<script type="text/javascript">

    var totalRecord;

    $(function () {
        to_page(1)
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                console.log(result);
                build_emps_table(result);
                if (0 < pn <= result.extend.pageInfo.pages) {
                    build_page_info(result);
                }
                build_page_nav(result)

            }
        });
    };
    
    function build_emps_table(result) {
        // 清空table表格
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function(index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span><span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span><span>").addClass("glyphicon glyphicon-trash")).append("删除");

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    // 解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第"
            +result.extend.pageInfo.pageNum
            + "页，总共"+result.extend.pageInfo.pages
            + "页，共"+result.extend.pageInfo.total
            +"条记录");

        totalRecord = result.extend.pageInfo.total;
    }
    
    // 解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function(){
                to_page(1);
            })
            prePageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        };


        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("herf", "#"));


        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function(){
                to_page(result.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function(){
                to_page(result.extend.pageInfo.pages);
            })
        }

        // 添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        var navPageNums = result.extend.pageInfo.navigatepageNums;
        $.each(navPageNums, function(index, item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item)
            });
            ul.append(numLi);
        })
        // 添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

        // 把ul添加到nav
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area")
    }

    // 点击新增按钮 弹出模态框
    $("#emp_add_model_btn").click(function () {
        // 发ajax请求，查出部门信息，显示在下拉列表
        getDepts();

        function getDepts() {
            $.ajax({
                url: "/depts",
                type: "GET",
                success: function(result){
                    console.log(result);
                    $.each(result.extend.depts, function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                        optionEle.appendTo("#empAddModel select")
                    })
                }
            });
        }

        // 弹出模态框
        $("#empAddModel").modal({
            "backdrop": "static"
        })
    })

    function validate_add_form() {
        // 拿到药校验的数据，要使用正则表达式
        var empName = $("empName_add_input").val();
        var regName = /(^[A-Za-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        alert(regName.test(empName));
        return false;
    }

    $("#emp_save_btn").click(function () {
        //alert($("#empAddModel form").serialize())
        //先对要提交给服务器的数据进行校验
        if (!validate_add_form()){
            return false;
        }
        $.ajax({
            url: "${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
                alert(result.msg);
                // 1. 关闭模态框
                // 2. 跳转至最后一页
                $('#empAddModel').modal('hide');
                to_page(totalRecord);
            }
        })
    })

</script>
</body>
</html>
