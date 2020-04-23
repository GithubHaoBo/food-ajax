<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>学生列表</title>
<%
	pageContext.setAttribute("APP", request.getContextPath());
%>
<script src="${APP }/static/js/jquery-3.4.1.min.js"></script>
<script src="${APP }/static/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${APP }/static/bootstrap/css/bootstrap.min.css">
<style>
table {
	font-size: 25px;
}

.center {
	text-align: center !important;
}
</style>
</head>
<body>

<!-- 学生修改 -->
<div class="modal fade" id="updStuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改学生</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal" id="myupdform">
		  <div class="form-group">
		    <label for="inputupdName" class="col-sm-2 control-label">姓名：</label>
		    <div class="col-sm-10">
		      <input type="text" name="sname" class="form-control" id="inputupdName" placeholder="输入名字">
		       <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputupdAge" class="col-sm-2 control-label">年龄：</label>
		    <div class="col-sm-10">
		      <input type="text" name="age" class="form-control" id="inputupdAge" placeholder="输入年龄">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputupdSex" class="col-sm-2 control-label">性别：</label>
		    <div class="col-sm-10">
		       <label class="radio-inline">
				  <input type="radio" name="sex" value="男"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="sex" value="女"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputupdGrade" class="col-sm-2 control-label">年级：</label>
		    <div class="col-sm-3">
		       <select class="form-control" name="gid"></select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="updStuFormBtn">修改</button>
      </div>
    </div>
  </div>
</div>

<!-- 学生添加 -->
<div class="modal fade" id="addStuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加学生</h4>
      </div>
      <div class="modal-body">
		<form class="form-horizontal" method="post" id="myform">
		  <div class="form-group">
		    <label for="inputName" class="col-sm-2 control-label">姓名：</label>
		    <div class="col-sm-10">
		      <input type="text" name="sname" class="form-control" id="inputName" placeholder="输入名字">
		       <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputAge" class="col-sm-2 control-label">年龄：</label>
		    <div class="col-sm-10">
		      <input type="text" name="age" class="form-control" id="inputAge" placeholder="输入年龄">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputAge" class="col-sm-2 control-label">性别：</label>
		    <div class="col-sm-10">
		       <label class="radio-inline">
				  <input type="radio" name="sex" value="男" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="sex" value="女"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="inputAge" class="col-sm-2 control-label">年级：</label>
		    <div class="col-sm-3">
		       <select class="form-control" name="gid"></select>
		    </div>
		  </div>
		  
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="addStuFormBtn">添加</button>
      </div>
    </div>
  </div>
</div>

<!-- 内容区 -->
	<div class="container">
		<div class="row center">
			<h1>SSM学生管理系统</h1>
		</div>
		<div class="row center">
			<button class="btn btn-primary" id="addStuBtn">新增</button>
			<button class="btn btn-danger" id="delMoreStuBtn">批量删除</button>
			<br> <br>
		</div>
		<div class="row">
			<table class="table table-bordered table-hover center" id="stu_table">
				<thead>
					<tr class="center">
						<th class="center"><input class='check-all' type="checkbox"/></th>
						<th class="center">ID</th>
						<th class="center">学生名字</th>
						<th class="center">学生性别</th>
						<th class="center">学生年龄</th>
						<th class="center">学生年级</th>
						<th class="center">操作</th>
					</tr>
				</thead>
				<tbody>

				</tbody>
			</table>
		</div>
		<div class="row center">
			<div class="note" id="page_info"></div>
			<nav aria-label="Page navigation" id="page_nav"></nav>
		</div>
	</div>

	<!-- ajax数据列表展示 -->
	<script type="text/javascript">
		var total=0;
		var current = 0;
		
		/* 页面加载外之后，发送ajax请求，得到分页数据 */
		$(function() {
			toPage(1);
		});
		
		function toPage(pn) {
			$.ajax({
				url:'${APP}/studs',
				data:"pn="+pn,
				type:"GET",
				success:function(data){
					console.log(data)
					/* 1.解析构建表格数据 */
					buildTable(data);
					/* 2.解析构建分页信息 */
					buildPageInfo(data)
					/* 3.解析构建分页导航信息 */
					buildPageNav(data)
				}
			})
		}
		
		//解析表格
		function buildTable(data) {
			$("#stu_table tbody").empty()	
			/* 1.从json取出员工员工数据 */
			var studs = data.map.pageInfo.list;
			/* 2.遍历获取 */
			$.each(studs,function(index,item){
				/* 分别获取各个属性，并填充到单元格 */
				var checkbox_item = $("<td></td>").append("<input class='check-item' type='checkbox'/>");
				var stuId = $("<td></td>").append(item.sid);
				var stuName = $("<td></td>").append(item.sname);
				var stuSex = $("<td></td>").append(item.sex);
				var stuAge = $("<td></td>").append(item.age);
				var stuGName = $("<td></td>").append(item.grade.gname);
				var editBtn = $('<button type="button" class="btn btn-primary updStuBtn">修改</button>')
				//为修改按钮添加自定义属性来存放ID
				editBtn.attr("stu-id",item.sid)
				var delBtn = $('<button type="button" class="btn btn-danger delStuBtn">删除</button>')
				//为修改按钮添加自定义属性来存放ID
				delBtn.attr("stu-id",item.sid)
				var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkbox_item)
					.append(stuId)
					.append(stuName)
					.append(stuSex)
					.append(stuAge)
					.append(stuGName)
					.append(btn)
					.appendTo("#stu_table tbody")
					
			})
		}
		
		//解析分页信息
		function buildPageInfo(data) {
			$("#page_info").empty()	
			$("#page_info").append("当前第"+data.map.pageInfo.pageNum +"页，共"+data.map.pageInfo.pages +"页，共"+data.map.pageInfo.total +"条记录")
			total=data.map.pageInfo.total
			current=data.map.pageInfo.pageNum
		}
		
		//解析分页导航
		function buildPageNav(data) {
			$("#page_nav").empty()
			var ul = $("<ul class='pagination'></ul>")
			
			var firstPage = $("<li></li>").append("<a>首页</a>")
			ul.append(firstPage)
			var prePage = $("<li></li>").append("<a>上一页</a>")
			ul.append(prePage)

			if(data.map.pageInfo.hasPreviousPage==false){
				$("firstPage").addClass("disabled")
				$("prePage").addClass("disabled")
			}else{
				firstPage.click(function(){
					toPage(1)
				})
				prePage.click(function(){
					toPage(data.map.pageInfo.prePage)
				})
			}
			
		
			$.each(data.map.pageInfo.navigatepageNums,function(index,item){
				var showPage = $("<li></li>").append($("<a>"+item+"</a>"))
				if(item==data.map.pageInfo.pageNum){
					showPage.addClass("active")
				}
				ul.append(showPage)
				showPage.click(function() {
					toPage(item)
				})
			})
			
			
			var nextPage = $("<li></li>").append("<a>下一页</a>")
			ul.append(nextPage)
			var lastPage = $("<li></li>").append("<a>尾页</a>")
			ul.append(lastPage)
			
			if(data.map.pageInfo.hasNextPage==false){
				$("nextPage").addClass("disabled")
				$("lastPage").addClass("disabled")
			}else{
				nextPage.click(function(){
					if (data.map.pageInfo.pageNum+1==data.map.pageInfo.pageNums) {
						toPage(data.map.pageInfo.pages)
					}else{
						toPage(data.map.pageInfo.pageNum+1)
					}
				})
				lastPage.click(function(){
					toPage(data.map.pageInfo.pages)
				})
			}
			
			
			$("#page_nav").append(ul)
		}
		
	</script>
	
	<!-- 获取数据 -->
	<script type="text/javascript">
	//获取年级数据
		function getGrades(ele) {
			//先清空下拉列表的原数据
			$(ele).empty()
			//再获取数据
			$.ajax({
				url:"${APP}/grades",
				type:"GET",
				success:function(data){
					console.log(data)
					$.each(data.map.grades,function(index,item){
						$(ele).append("<option value='"+item.gid+"'>"+item.gname+"</option>")
					})
				}
			})
		}
	
	//获取单个学生的数据
		function getOneStu(sid) {
			$.ajax({
				url:"${APP}/studs/"+sid,
				type:"GET",
				success:function(data){
					console.log(data)
					var stu = data.map.student
					$("#inputupdName").val(stu.sname)
					$("#inputupdAge").val(stu.age)
					$("#updStuModal input[name=sex]").val([stu.sex])
					$("#updStuModal select").val([stu.gid])
				}
			})
		}
	
	
	</script>

	<!-- 新增按钮 -->
	<script type="text/javascript">
	let flagaddAge = 0
	let flagaddName = 0
		$("#addStuBtn").click(function(){
			//先清空表单的数据
			$("#myform")[0].reset()
			$("#myform span").text("")
			$("#myform input").parent().removeClass("has-success has-error")
			/* 显示模态框之前先查询到年级信息 */
			getGrades("#addStuModal select");
			
			/* 调用用模态框 */
			$("#addStuModal").modal({
				/* 设置点击背景不取消模态 */
				backdrop:"static"
			})
		})
		
		
		//展示校验信息
		function show_validate_msg(ele,status,msg){
			//清除原有的样式
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next().text("")
			if("success"==status){
				$(ele).parent().addClass("has-success")
				$(ele).next().text(msg)
			}else if ("error"==status) {
				$(ele).parent().addClass("has-error")
				$(ele).next().text(msg)
			}
		}
		
		//验证姓名
		function checkName(){
			var sname = $("#inputName").val()
			//匹配3-8位字符或2-4汉字
			var regName = /(^[a-zA-Z0-9_-]{3,8})|(^[\u2E80-\u9FFF]{2,4})$/
			//测试
			if(!regName.test(sname)){
				show_validate_msg("#inputName","error","请输入3-8位数字和字母或2-4汉字")
			}else{
				$.ajax({
					url:"${APP}/checkStu",
					type:"GET",
					data:"sname="+sname,
					success:function(data){
						if (data.code==200) {
							show_validate_msg("#inputName","success","数据可用")
							return true
						} else {
							show_validate_msg("#inputName","error","姓名已存在")
							return false
						}
					}
				})
				
			}
		}
		$("#inputName").blur(checkName)
		
		//验证年龄
		function checkAge(){
			
			var sage = $("#inputAge").val().trim()
			if (isNaN(sage)||sage=="") {
				show_validate_msg("#inputAge","error","请输入数字")
				return false
			}else if(parseInt(sage)<10||parseInt(sage)>30){
				show_validate_msg("#inputAge","error","年龄需在10-30之间")
				return false
			}else{
				show_validate_msg("#inputAge","success","数据可用")
				return true
			}
		}
		$("#inputAge").blur(checkAge)
		
		/*校验方法*/
		function validate_form(){
			alert(checkName()+"---"+checkName())
			if (checkName()&&checkAge()) {
				return true;
			} else {
				return true;
			}
		}
		
		
		
		$("#addStuFormBtn").click(function(){
			/* 提交学生信息之前先对内容进行校验,失败的话不进行保存，直接返回 */
			if(1){
				/* 将表单信息提交到服务器  */
					$.ajax({
						url:"${APP}/studs",
						type:"POST",
						async:true,
						data:$("#myform").serialize(),
						success:function(data){
							console.log(data)
							$("#addStuModal").modal('hide')
							//按照总记录数跳转到最后一页
							toPage(total)
						}
					})
			}else{
				show_validate_msg("#inputName","error","请输入正确的数据")
				show_validate_msg("#inputAge","error","请输入正确的数据")
				return false;
			}
		}) 
		
	</script>

	<!-- 修改按钮 -->
	<script type="text/javascript">
	var flagupdName=0
	var flagupdAge=0
	
	$(document).on("click",".updStuBtn",function(){
		/* 显示模态框之前先查询到学生信息，并显示 */
		getGrades("#updStuModal select");
		getOneStu($(this).attr("stu-id"))
		//把当前学生的ID传给更新按钮
		$("#updStuFormBtn").attr("stu-id",$(this).attr("stu-id"))
		/* 调用用模态框 */
		$("#updStuModal").modal({
			/* 设置点击背景不取消模态 */
			backdrop:"static"
		})
	})
	
	//验证姓名
		$("#inputupdName").blur(function(){
			
			var sname = $("#inputupdName").val()
			//匹配3-8位字符或2-4汉字
			var regName = /(^[a-zA-Z0-9_-]{3,8})|(^[\u2E80-\u9FFF]{2,4})$/
			//测试
			if(!regName.test(sname)){
				show_validate_msg("#inputupdName","error","请输入3-8位数字和字母或2-4汉字")
			}else{
				$.ajax({
					url:"${APP}/checkStu",
					type:"GET",
					data:"sname="+sname,
					success:function(data){
						if (data.code==200) {
							show_validate_msg("#inputupdName","success","数据可用")
							flagupdName=1
						} else {
							show_validate_msg("#inputupdName","error","姓名已存在")
							flagupdName = 0
						}
					}
				})
				
			}
		})
		
		//验证年龄
		$("#inputupdAge").blur(function(){
			
			var sage = $("#inputupdAge").val().trim()
			if (isNaN(sage)||sage=="") {
				show_validate_msg("#inputupdAge","error","请输入数字")
				flagupdAge = 0
			}else if(parseInt(sage)<10||parseInt(sage)>30){
				show_validate_msg("#inputupdAge","error","年龄需在10-30之间")
				flagupdAge = 0
			}else{
				show_validate_msg("#inputupdAge","success","数据可用")
				flagupdAge=1
			}
		})
		
		/*校验方法*/
		function validate_form(){
			if (flagupdName==1&&flagupdAge==1) {
				return true;
			} else {
				return false
			}
		}
		
		
		
		$("#updStuFormBtn").click(function(){
			alert(flagupdName+"---"+flagupdAge)
			alert($("#myupdform").serialize())
			/* 提交学生信息之前先对内容进行校验,失败的话不进行保存，直接返回 */
			if(validate_form()){
				console.log($("#myupdform").serialize())
				/* 将表单信息提交到服务器  */
				$.ajax({
					url:"${APP}/studs/"+$(this).attr("stu-id"),
					//put请求修改信息
					type:"PUT",
					data:$("#myupdform").serialize(),
					success:function(data){
						console.log(data)
						$("#updStuModal").modal('hide')
						//按照总记录数跳转到最后一页
						toPage(current)
					}
				})
			}else{
				show_validate_msg("#inputupdName","error","请输入正确的数据")
				show_validate_msg("#inputupdAge","error","请输入正确的数据")
				return false;
			}
		}) 
	
	</script>

	<!-- 删除按钮 -->
	<script type="text/javascript">
	
	$(document).on("click",".delStuBtn",function(){
		var delname = $(this).parents("tr").find("td:eq(2)").text()
		if(confirm("确认删除【"+delname+"】")){
			$.ajax({
				url:"${APP}/studs/"+$(this).attr("stu-id"),
				type:"DELETE",
				success:function(data){
					alert(data.msg)
					//删除后回到当前页
					toPage(current)
				}
			})
		}
	})
	</script>
	
	<!-- 批量删除复选框 -->
	<script type="text/javascript">
	//全选按钮事件
		$(".check-all").click(function(){
			var status=$(this).prop("checked")
			$(".check-item").prop("checked",status)
		})	
		
		
		$(document).on("click",".check-item",function(){
			//判断当前页的选中状态个数是否等于所有个数
			var checkflag = $(".check-item:checked").length==$(".check-item").length
			$(".check-all").prop("checked",checkflag)
		})
		
	</script>

	<!-- 批量删除按钮 -->
	<script type="text/javascript">
		$("#delMoreStuBtn").click(function(){
			if ($(".check-item:checked").length==0) {
				alert("请勾选...")
			} else {
				var snames=""
					var sids=""
					$.each($(".check-item:checked"),function(){
							snames+=$(this).parents("tr").find("td:eq(2)").text() + ",";
							sids+=$(this).parents("tr").find("td:eq(1)").text() + "-";
					})
					snames = snames.substring(0, snames.length - 1);
					sids = sids.substring(0, sids.length - 1);
					if(confirm("确认删除【" + snames + "】吗?")) {
				            $.ajax({
				                url:"${APP}/studs/" + sids,
				                type:"DELETE",
				                success:function(data) {
				                    alert(data.msg);
				                    toPage(current);
				                }
				            });
				        }
			}
		})
	</script>
		
</body>
</html>