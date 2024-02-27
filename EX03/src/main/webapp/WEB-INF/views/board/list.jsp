<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<%@ include file="../includes/header.jsp" %>
<style>
	@media screen and (max-width:768px){		
		select[name='type']{
			display:inline !important;
			width:30% !important;
		}
		input[name='keyword']{
			display:inline !important;
			width:45% !important;
		}
		#searchForm button{
			display:inline !important;
			width:22% !important;
		}
	}
</style>

	<div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Board</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    
    <div class="row">
         <div class="col-lg-12">
             <div class="panel panel-default">
                 <div class="panel-heading">
                     List
                     <Button id="regBtn" type="button" class="btn btn-xs btn-primary pull-right">Register</Button>
                 </div>
                 <!-- /.panel-heading -->
                 <div class="panel-body">
                     <table width="100%" class="table table-striped table-bordered table-hover">
                         <thead>
                             <tr>
                                 <th>#번호</th>
                                 <th>제목</th>
                                 <th>작성자</th>
                                 <th>작성일</th>
                                 <th>수정일</th>
                             </tr>
                         </thead>
                         <c:forEach items="${list}" var="board">
                         <tr>
                         	<td><c:out value="${board.bno}"/></td>
                         	<td width="50%">
                         		<a class="move" href='<c:out value="${board.bno}"/>'>
                         			<c:out value="${board.title}"></c:out>
                         		</a>
                         	</td>
                         	<td>${board.writer}</td>
                         	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
                         	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
                         </tr>	
                         </c:forEach>
                       
                     </table>
                     <!-- /.table-responsive -->
                     
                     <!-- form 태그 --------------------------------------------------------------------------->
                     <form id="actionForm" method="get">
                     	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                     	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                     	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
                     	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
                     </form>
                     <!-- form 태그.end -->
                                
                                
                     <!-- Search Form ------------------------------------------------------------------------> 
                     <div class="row">
                     	<div class="col-lg-12">
                     		<form id="searchForm" method="get" class="form-inline">                      			               			
                     			<select name="type" class="form-control">
                     				<option value="">--</option>
                     				<option value="T">제목</option> 
                     				<option value="C">내용</option> 
                     				<option value="W">작성자</option> 
                     				<option value="TC">제목&내용</option>                      				
                     			</select>                     			
                     			<input name="keyword" class="form-control">
                     			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                     			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">	                     			
                     			<button class="btn btn-default">Search</button>	            			
                     		</form>
                     	</div>                     
                     </div>
                     
                     <!-- Search Form.end -->          
                                
                                          
                     <!-- paging ------------------------------------------------------------------------------>
                     <div class="pull-right">
                     	<ul class="pagination">
                     		<c:if test="${pageMaker.prev}">
                   			<li class="paginate_button previous">
                   				<a href="${pageMaker.startPage-1}">Previous</a>
                   			</li>
                     		</c:if>
                     		
                     		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                     		<li class="paginate_button ${pageMaker.cri.pageNum==num ? 'active' : ''}">
                   				<a href="${num}">${num}</a>
                   			</li>
                     		</c:forEach>
                     		
                     		
                     		<c:if test="${pageMaker.next}">
                   			<li class="paginate_button next">
                   				<a href="${pageMaker.endPage+1}">Next</a>
                   			</li>
                     		</c:if>
                     	</ul>
                     </div>
                     <!-- page.end -->
                     
                     
                     <!-- Modal  추가 -------------------------------------------------------------------------->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>							
						</div>
						
					</div>
					<!-- /.modal -->
                     
                     
                     
                 </div>
                 <!-- /.panel-body -->
             </div>
             <!-- /.panel -->
         </div>
         <!-- /.col-lg-12 -->
     </div>
    
    <script>
    	$(document).ready(function(){
    		var result='<c:out value="${result}"/>';
    		
    		checkModal(result); //function call
    		
    		function checkModal(result){
    			//result가 없으면 중지
    			if(result===''){
    				return;
    			}
    			//result가 0보다 크면 modal창 출력
    			if(parseInt(result)>0){
    				$(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다.");
    			}
    			$("#myModal").modal("show");
    		}
    		  		
    		
    		/* 등록버튼 event 처리 ***********************************************************/
    		$("#regBtn").on("click",function(){
    			self.location="/board/register";
    		});
    		
    		
    		var actionForm=$("#actionForm");
    		/* 페이지번호 event 처리 **********************************************************/    		
    		$(".paginate_button a").on("click",function(e){
    			e.preventDefault(); // 링크 클릭시 다른 페이지로 넘어가는 것 방지.
    			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
    			actionForm.submit();    			
    		});
    		
    		/* 제목 클릭시 event 처리 *********************************************************/
    		$(".move").on("click",function(e){
    			e.preventDefault(); // 링크 클릭시 다른 페이지로 넘어가는 것 방지.
    			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
    			actionForm.attr("action","/board/get");
    			actionForm.submit();
    		});
    		
    		
    	});
    </script>



<%@ include file="../includes/footer.jsp" %>