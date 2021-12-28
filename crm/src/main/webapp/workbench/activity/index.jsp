<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName()
			+ ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<link rel="stylesheet" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript">

	$(function(){
		$("#addBtn").click(function (){
			/*
			* 时间组件*/
			$(".time").datetimepicker({
				minView:"month",
				language:"zh-CN",
				format:"yyyy-mm-dd",
				autoclose:true,
				todayBtn:true,
				pickerPosition:"bottom-left"
			})
			/*
			* userList,[{user1},{user2}]
			* 获取用户下拉列表框
			*/
			$.ajax({
				url:"workbench/activity/getUserList.do",
				type:"get",
				dataType:"json",
				success:function (data){
					var html=""
					$.each(data,function (i,n){
						html+="<option value="+n.id+">"+n.name+"</option>"
					})
					// alert(opt)
					$("#create-marketActivityOwner").html(html)
					$("#create-marketActivityOwner").val("${user.id}")
				}
			})
			$("#createActivityModal").modal("show")
		})
		//保存
		$("#saveBtn").click(function (){
			$.ajax({
				url:"workbench/activity/saveActivity.do",
				type:"post",
				data:{
					"owner":$("#create-marketActivityOwner").val(),
					"name":$("#create-marketActivityName").val(),
					"startDate":$("#create-startTime").val(),
					"endDate":$("#create-endTime").val(),
					"cost":$("#create-cost").val(),
					"description":$("#create-description").val(),
					"createBy":"${user.name}",
				},
				dataType: "json",
				success:function (data){
					//返回值，"success":true/false
					if(data.success){
						// alert("保存成功")
						//保存完后清空模态框
						$("#createActivityForm")[0].reset();
					}else{
						alert("保存失败")
					}
				}
			})
			$("#createActivityModal").modal("hide")
			//保存时间分页刷新
			pageList(1,2)
		})
		/**
		 * 分页操作
		 * 1.创建，修改，删除，查询按钮
		 * 2.插页组件
		 * 3.刚刚加载完毕的时候
		 *	传过去数据:
		 *  pageNO,页数
		 *	pageSize，每页大小
		 *	name:名称
		 *	owner:所有者
		 *	startTime:开始时间
		 *	endTime:结束时间
		 *	返回的数据
		 *	total：总条数
		 *	dataList：信息列表
		 */
		//点击市场活动刷新
		pageList(1,2);
		//查询按钮刷新
		$("#searchBtn").click(function (){
			//点击查询按钮，更新隐藏域的值
			$("#hidden-name").val($.trim($("#name").val()))
			$("#hidden-owner").val($.trim($("#owner").val()))
			$("#hidden-startTime").val($.trim($("#startTime").val()))
			$("#hidden-endTime").val($.trim($("#endTime").val()))
			pageList(1,2)
		})
		//全选框的实现
		$("#checkbox").click(function (){
			$("input[name='checkbox']").prop("checked",this.checked)
		})
		$("#pageBody").on("click",$("input[name='checkbox']:checked"),function (){
			$("input[name='checkbox']:checked").length==$("input[name='checkbox']").length?
					$("#checkbox").prop("checked",true):$("#checkbox").prop("checked",false)
		})

		//删除按钮
		$("#deleteBtn").click(function (){
			/**
			 * 提供的数据：activity的id数组
			 * 返回的数据：success：true/false
			 */
			var ids=$("input[name='checkbox']:checked")
			if(ids.length==0){
				alert("请选中市场活动")
			}
			else if(confirm("确定删除选中的市场活动吗")){
				var param="";

				for(var i=0;i<ids.length;i++){
					param+="id="+$(ids[i]).val()
					if(i!=ids.length-1){
						param+="&"
					}
				}
				alert(param)
				$.ajax({
					url:"workbench/activity/delete.do",
					dataType:"json",
					data:param,
					type:"post",
					success:function (data){
						if(data.success){
							//删除完刷新
							pageList(1,2)
						}else{
							alert("删除失败")
						}
					}
				})

			}
		})
		//修改操作
		$("#editBtn").click(function (){
			//选中的id
			var aid=$("input[name='checkbox']:checked")
			if(aid.length==0){
				alert("请先选中一项")
			}else if(aid.length>1){
				alert("只能编辑一项")
			}
			else{
				id=$(aid[0]).val()
				// alert(id)
				//下拉列表框和显示其他数据
				/**
				 * 提供的数据：
				 * aid，市场活动id
				 * 获得的数据：
				 * userList，用户列表
				 * activity：aid的activity
				 */
				$.ajax({
					url:"workbench/activity/getUserListAndActivity.do",
					data:{
						"id":id,
					},
					dataType:"json",
					type:"get",
					success:function (data){
						var html=""
						$.each(data.userList,function (i,n){
							html+="<option value='"+n.id+"'>"+n.name+"</option>"
						})
						$("#edit-marketActivityOwner").html(html)

						$("#edit-id").val(data.a.id)
						$("#edit-marketActivityOwner").val(data.a.owner)
						$("#edit-marketActivityName").val(data.a.name)
						$("#edit-startTime").val(data.a.startDate)
						$("#edit-endTime").val(data.a.endDate)
						$("#edit-cost").val(data.a.cost)
						$("#edit-describe").val(data.a.description)
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
				//显示模态框
				$("#editActivityModal").modal("show")
			}
			$("#updateBtn").click(function (){

			})
		})

		function pageList(pageNo,pageSize){
			//每一次刷新，都将全选框重置
			$("#checkbox").prop("checked",false)
			//没有点击查询按钮，就将隐藏域的值赋给真实值
			$("#name").val($("#hidden-name").val())
			$("#owner").val($("#hidden-owner").val())
			$("#startTime").val($("#hidden-startTime").val())
			$("#endTime").val($("#hidden-endTime").val())
			$.ajax({
				url:"workbench/activity/getPageList.do",
				dataType:"json",
				type:"get",
				data:{
					"pageNO":pageNo,
					"pageSize":pageSize,
					"name":$.trim($("#name").val()),
					"owner":$.trim($("#owner").val()),
					"startTime":$.trim($("#startTime").val()),
					"endTime":$.trim($("#endTime").val())
				},
				success:function (data){
					var html="";
					$.each(data.pageList,function (i,n){
						html+='<tr class="active">'
						html+='<td><input type="checkbox" name="checkbox" value="'+n.id+'"/></td>'
						html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'detail.html\';">'+n.name+'</a></td>'
						html+='<td>'+n.owner+'</td>'
						html+='<td>'+n.startDate+'</td>'
						html+='<td>'+n.endDate+'</td>'
						html+='<tr>'
					})
					$("#pageBody").html(html)

					//计算总页数
					var totalPages=data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1
					$("#activityPage").bs_pagination({
						currentPage:pageNo,//当前页码
						rowsPerPage:pageSize,//每页显示记录数
						maxRowsPerPage: 20,//每页最多显示记录数
						totalPages:totalPages,//总页数
						totalRows:data.total,//总记录条数
						visiblePageLinks: 3,//显示几个卡片

						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,
						showNext:true,
						showLast:true,

						//点击分页组件的时候触发
						onChangePage: function (event,data){
							pageList(data.currentPage,data.rowsPerPage)
						}
					})
				}
			})
		}
	});
	
</script>
</head>
<body>

	<%--	隐藏域保存查询的值--%>
	<input type="hidden" id="hidden-name">
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-startTime">
	<input type="hidden" id="hidden-endTime">

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="createActivityForm">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label " >开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label " >结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endTime">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<input type="hidden" id="edit-id">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startTime" value="2020-10-10">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime" value="2020-10-20">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" value="5,000">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="endTime">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkbox"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="pageBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>