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
	<div class="container">
		<div class="row">
			<h1>SSM学生管理系统</h1>
		</div>
		<div class="row">
			<button class="btn btn-primary">新增</button>
			<button class="btn btn-danger">删除</button>
			<br> <br>
		</div>
		<div class="row">
			<table class="table table-bordered table-hover center">
				<thead>
					<tr class="center">
						<th>#</th>
						<th>学生名字</th>
						<th>学生性别</th>
						<th>学生年龄</th>
						<th>学生年级</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageInfo.list }" var="stu">
						<tr>
							<td>${stu.sid }</td>
							<td>${stu.sname }</td>
							<td>${stu.sex }</td>
							<td>${stu.age }</td>
							<td>${stu.grade.gname }</td>
							<td>
								<button type="button" class="btn btn-primary">修改</button>
								<button type="button" class="btn btn-danger">删除</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row center">
			<div class="note">当前第${pageInfo.pageNum }，共${pageInfo.pages }页，共${pageInfo.total }条记录</div>
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP }/studs?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage==true }">
						<li><a href="${APP }/studs?pn=${pageInfo.pageNum-1}">上一页</a></li>
					</c:if>

					<c:forEach items="${pageInfo.navigatepageNums }" var="showNum">
						<c:if test="${showNum==pageInfo.pageNum }">
							<li class="active"><a href="#">${showNum }</a></li>
						</c:if>
						<c:if test="${showNum!=pageInfo.pageNum }">
							<li><a href="${APP }/studs?pn=${showNum}">${showNum }</a></li>
						</c:if>
					</c:forEach>
					
					<c:if test="${pageInfo.hasNextPage==true }">
						<li><a href="${APP }/studs?pn=${pageInfo.pageNum+1}">下一页</a></li>
					</c:if>

					<li><a href="${APP }/studs?pn=${pageInfo.pages}">尾页</a></li>
				</ul>
			</nav>
		</div>
	</div>
</body>
</html>