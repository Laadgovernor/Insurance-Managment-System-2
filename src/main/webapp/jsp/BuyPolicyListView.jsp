<%@page import="in.co.insurance.mgt.util.DataUtility"%>
<%@page import="in.co.insurance.mgt.ctl.BuyPolicyCtl"%>
<%@page import="in.co.insurance.mgt.bean.BuyPolicyBean"%>
<%@page import="in.co.insurance.mgt.bean.PolicyBean"%>
<%@page import="in.co.insurance.mgt.ctl.PolicyListCtl"%>
<%@page import="in.co.insurance.mgt.ctl.PolicyCtl"%>
<%@page import="java.security.Policy"%>
<%@page import="in.co.insurance.mgt.bean.SubCategoryBean"%>
<%@page import="in.co.insurance.mgt.ctl.SubCategoryListCtl"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.insurance.mgt.bean.CategoryBean"%>
<%@page import="in.co.insurance.mgt.ctl.CategoryListCtl"%>
<%@page import="in.co.insurance.mgt.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Policy Payment Lists</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<nav aria-label="breadcrumb" style="margin-left: 10px;">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="<%=IMSView.WELCOME_CTL%>">Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">My Policy List</li>
		</ol>
	</nav>
<form action="<%=IMSView.BUY_POLICY_LIST_CTL%>" method="post">
	<div class="card" style="margin: 10px;">
		<h5 class="card-header"
			style="height: 50px; font-size: 25px; background-color: #18334f; color: white;">My Policy List</h5>
		<div class="card-body">
			<div class="row">
			<%if(userBean.getRoleId()==1){ %>
				<div class="col">
					<input type="text" name="name" class="form-control"
						placeholder=" Search By Name" aria-label="Search By Name"
						value="<%=ServletUtility.getParameter("name", request)%>">
				</div>
			<%}%>
			
				<div class="col">
					<input type="text" name="categoryName" class="form-control"
						placeholder=" Search By Category Name" aria-label="Search By Name"
						value="<%=ServletUtility.getParameter("categoryName", request)%>">
				</div>
			
				<div class="col">
					<input type="text" name="policyName" class="form-control"
						placeholder=" Search By Policy Name" aria-label="Search By Name"
						value="<%=ServletUtility.getParameter("policyName", request)%>">
				</div>
				
				<div class="col">
					<input type="text" name="status" class="form-control"
						placeholder=" Search By Status" aria-label="Search By Name"
						value="<%=ServletUtility.getParameter("status", request)%>">
				</div>
			
				<div class="col">
					<input type="submit" class="btn btn-primary btn btn-info"
						name="operation" value="<%=PolicyListCtl.OP_SEARCH%>">
				</div>
			</div>
			<b><font color="red"><%=ServletUtility.getErrorMessage(request)%></font></b>
			<b><font color="green"><%=ServletUtility.getSuccessMessage(request)%></font></b>
			<br>

			<table class="table table-sm table-bordered">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">User Name</th>
						<th scope="col">Email</th>
						<th scope="col">Contact No</th>
						<th scope="col">Gender</th>
						<th scope="col">Category</th>
						<th scope="col">Sub Category</th>
						<th scope="col">Name</th>
						<th scope="col">Sum Assured</th>
						<th scope="col">Premium</th>
						<th scope="col">Tenure</th>
						<%if(userLoggedIn){%>
						<th scope="col">Status</th>
						<th scope="col">Report</th>
						<%} %>
					</tr>
				</thead>
				<tbody>
					<%
					int pageNo = ServletUtility.getPageNo(request);
					int pageSize = ServletUtility.getPageSize(request);
					int index = ((pageNo - 1) * pageSize) + 1;
					int size = ServletUtility.getSize(request);
					BuyPolicyBean bean = null;
					List list = ServletUtility.getList(request);
					Iterator<BuyPolicyBean> it = list.iterator();
					while (it.hasNext()) {
						bean = it.next();
					%>
					<tr>
						
						<td scope="row"><%=index++%></td>
							<td scope="row"><%=bean.getUserName()%></td>
							<td scope="row"><%=bean.getEmail()%></td>
							<td scope="row"><%=bean.getContactNo()%></td>
							<td scope="row"><%=bean.getGender()%></td>
							<td scope="row"><%=bean.getCategoryName()%></td>
							<td scope="row"><%=bean.getSubCategoryName()%></td>
						<td scope="row"><%=bean.getPolicyName()%></td>
						<td scope="row"><%=bean.getSumAssured()%></td>
						<td scope="row"><%=bean.getPremium()%></td>
						<td scope="row"><%=bean.getTenure()%></td>
						<%if(userBean.getRoleId()==2){%>
						<td><%=bean.getStatus()%></td>	
						<%}else{%>
							<%if(bean.getStatus().equals("Pending")){ %>	
						<td><a href="<%=IMSView.BUY_POLICY_LIST_CTL%>?id=<%=bean.getId()%>&status=Activate">Activate</a>|<a href="<%=IMSView.BUY_POLICY_LIST_CTL%>?id=<%=bean.getId()%>&status=Canceled" >Canceled</a></td>
						<%}else{%>
						<td><%=bean.getStatus()%></td>
						<%} %>
						<%} %>
						

						
						
						
						
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<div class="clearfix">
			<nav aria-label="Page navigation example float-end">
				<ul class="pagination justify-content-end">
					<li class="page-item disabled"><input type="submit" name="operation"
								class="page-link"
								value="<%=BuyPolicyCtl.OP_PREVIOUS%>"
								<%=(pageNo == 1) ? "disabled" : ""%>></li>
					<% int count=DataUtility.getInt(String.valueOf(size/10));%>
								<% for(int i=1;i<=count+1;i++){%>
								<% if(i==pageNo){%>	
								<li class="page-item active"><a class="page-link activate" href="<%=IMSView.BUY_POLICY_LIST_CTL%>?pageNo=<%=i%>"><%=i%></a></li>
								<%}else{%>
								<li class="page-item"><a class="page-link" href="<%=IMSView.BUY_POLICY_LIST_CTL%>?pageNo=<%=i%>"><%=i%></a></li>
								<%} %>
								<%}%>
					<li class="page-item"><input type="submit" name="operation"
								class="page-link"
								value="<%=BuyPolicyCtl.OP_NEXT%>"
								<%=((list.size() < pageSize) || size==pageNo*pageSize) ? "disabled" : ""%>></li>
				</ul>
			</nav>
			</div>
		</div>
	</div>
	<input type="hidden" name="pageNo" value="<%=pageNo%>"> <input
				type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>
	<%@ include file="Footer.jsp"%>
</body>
</html>