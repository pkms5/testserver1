<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<%@ include file="../includes/header.jsp" %>
	<style>
		.btn-primary{background:orange;border:orange !important;}
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
                     Read
                 </div>
                 <!-- /.panel-heading -->
                 <div class="panel-body">
                    <div class="form-group">
                    	<lable>no</lable>
                    	<input class="form-control" name="bno" value='<c:out value="${board.bno}"/>' readonly>
                    </div> 
                   	<div class="form-group">
                   		<label>Title</label>
                   		<input class="form-control" name="title" value='<c:out value="${board.title}"/>' readonly>
                   	</div>
                   	<div class="form-group">
                   		<label>Content</label>
                   		<textarea class="form-control" rows="10" name="content" readonly><c:out value="${board.content}"/></textarea>
                   	</div>
                   	<div class="form-group">
                   		<label>Writer</label>
                   		<input class="form-control" name="writer" value='<c:out value="${board.writer}"/>' readonly>
                   	</div>
                   	<button data-oper="modify" class="btn btn-default btn-primary">Modify</button>
                   	<button data-oper="list" class="btn btn-default btn-primary">List</button>
                   	
                   	<form id="operForm" action="/board/modify" method="get">
                   		<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                   		<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                   		<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'>
                   		<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                   		<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>'>

                   	</form>
                    
                 </div>
                 <!-- /.panel-body -->
             </div>
             <!-- /.panel -->
         </div>
         <!-- /.col-lg-12 -->
     </div>
     
    <!-- 댓글 목록 -----------------------------------------------------------------------------------------------> 
     <div class="row">
     	<div class="col-lg-12">
     		<div class="panel panel-default">
     			<div class="panel-heading">
     				<i class="fa fa-comments f-fw"></i> Reply
     				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
     			</div>
     			<div class="panel-body">
     				<ul class="chat">
     				
     				</ul>
     			</div>
     			<div class="panel-footer" style="height:50px;">					
				</div>     			
     		</div>
     	</div>
     </div>
     <!-- 댓글 목록.end --> 
    
    
    <!-- 댓글 등록 modal ----------------------------------------------------------------------------------------->    
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label> 
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
              </div>
      
            </div>
			<div class="modal-footer">
	        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
	        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
	        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
	        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
	      </div>          
      	  </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
	<!-- 댓글 등록 modal.end -->
    
    
    <script type="text/javascript" src="/resources/js/reply.js"></script>
    
    <script>
    	function showList(page){
    		var bnoValue='<c:out value="${board.bno}"/>'; //부모글 번호
    		replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){
    			console.log("replyCnt : "+replyCnt);
    			console.log("page : "+page);
    			//page가 -1이면 마지막 페이지로 이동
    			if(pageNum==-1){
    				pageNum=Math.ceil(replyCnt/10.0);
    				showList(pageNum);
    				return;
    			}
    			var str="";
    			// 댓글목록이 없으면 중지
    			if(list==null || list.length==0){
    				return;
    			}
    			for(var i=0,len=list.length || 0;i<len;i++){
    				str+="<li class='left clearfix' data-rno='"+list[i].rno+"' style='cursor:pointer'>";
    				str+="<div><div class='header'><strong class='primary-font'>["+list[i].rno+"] "+list[i].replyer+"</strong>";
    				str+=" <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
    				str+=" <p>"+list[i].reply+"</p></div></li>"  
    			}
    			$(".chat").html(str);
				showReplyPage(replyCnt,page);
    		});    		
    	}
    	function showReplyPage(replyCnt,pageNum){	
    		console.log("replyCnt ...... "+replyCnt);
    		
    		var endNum=Math.ceil(pageNum/10.0)*10; // 1.2.3 ... 10에서 10
    		var startNum=endNum-9; // 1.2.3 ... 10에서 1. 10-9==1
    		var prev=startNum!=1; //previous유무
    		var next=false; //next유무
    		// 댓글갯수가 endNum*10보다 작을 때(실제끝페이지가 계산으로 구한 마지막페이지보다 작을 때)
    		if(endNum*10>=replyCnt){
    			endNum=Math.ceil(replyCnt/10.0);//마지막페이지 변경
    		}
    		// 댓글갯수가 endNum*10보다 크면 next존재
    		if(endNum*10<replyCnt){
    			next=true;
    		}
    		var str="<ul class='pagination pull-right' style='margin:0 !important'>";
    		if(prev){
    			str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
    		}
    		for(var i=startNum;i<=endNum;i++){
    			var active=pageNum==i?"active":""; // page번호가 현재페이지 이면 active 설정
    			str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
    		}
    		if(next){
    			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
    		}
    		str+=" </ul>";
    		$(".panel-footer").html(str);
    	}
    
    
    
    	$(document).ready(function(){
    		/* 필요한 변수. 찾을 태그를 먼저 작성 *****************************************************/
    		var bnoValue='<c:out value="${board.bno}"/>'; //부모글 번호
    		var replyUL=$(".chat"); // 댓글목록 ul
    		
    		var modal = $(".modal"); // 모달창
    	    var modalInputReply = modal.find("input[name='reply']"); //댓글내용
    	    var modalInputReplyer = modal.find("input[name='replyer']"); //댓글작성자
    	    var modalInputReplyDate = modal.find("input[name='replyDate']"); //댓글작성일    	    
    	    var modalModBtn = $("#modalModBtn"); //수정버튼
    	    var modalRemoveBtn = $("#modalRemoveBtn"); //삭제버튼
    	    var modalRegisterBtn = $("#modalRegisterBtn"); //등록버튼    		
    		
    		var operForm=$("#operForm"); // modify, list버튼 처리 폼
    		
    	    var pageNum = 1; // 페이지번호 기본값
    	    var replyPageFooter = $(".panel-footer"); // 댓글페이징처리 번호가 출력되는 부분    
    	    
    	    
    	    showList(pageNum); //댓글목록 출력
    	    
    		
    		
    		/* modify button event 처리 *********************************************************/
    		$("button[data-oper='modify']").on("click",function(){
    			operForm.attr("action","/board/modify").submit();
    		});
    		/* list button event 처리 **********************************************************/
    		$("button[data-oper='list']").on("click",function(){
    			//$("#bno").remove();
    			operForm.attr("action","/board/list").submit();
    		});
    		/* 댓글 등록 button event 처리 ********************************************************/
    		$("#addReplyBtn").on("click",function(e){
    			modal.find("input").val(""); // input 태그 초기화
    			modalInputReplyDate.closest("div").hide(); // 댓글작성일 안보이게.
    			modal.find("button[id!='modalCloseBtn']").hide(); // close버튼만 남겨두고 모든 버튼 안보이게.
    			modalRegisterBtn.show(); //등록버튼만 다시 보이게.
    			modal.modal("show"); // modal창 띄우기.
    		});
    		/* 모달창 close버튼 event 처리 ******************************************************************/
    		$("#modalCloseBtn").on("click",function(){
    			modal.modal("hide");
    		});
    		/* 모달창 댓글 등록버튼 event 처리 ****************************************************************/
    		modalRegisterBtn.on("click",function(){
    			//서버에 전송할 데이터
    			var reply={
    					reply:modalInputReply.val(),
    					replyer:modalInputReplyer.val(),
    					bno:bnoValue
    			};
    			//댓글등록 함수 호출
    			replyService.add(reply,function(result){
    				alert(result); // controller에서 전달된 'success' 출력
    				modal.find("input").val(""); // input태그 초기화
    				modal.modal("hide"); // modal창 안보이게
    				
    				showList(1); // 댓글목록 갱신
    			});    			
    		});
    		/* 댓글 페이지번호 event 처리 ***********************************************************************/
    		// delegate.위임. li a 가 아직 생성되지 않아서 부모에게 event처리 위임
    		replyPageFooter.on("click","li a",function(a){
    			a.preventDefault(); // 클릭시 다른 페이지로 이동 방지.
    			var targetPageNum=$(this).attr("href");
    			pageNum=targetPageNum;
    			showList(pageNum);
    		});
    		/* 댓글 목록 event 처리 ****************************************************************************/
    		// delegate.위임. li가 아직 생성되지 않아서 부모에게 event처리 위임
    		$(".chat").on("click","li",function(e){
    			var rno=$(this).data("rno");
    			replyService.get(rno,function(reply){
    				modalInputReply.val(reply.reply);
    				modalInputReplyer.val(reply.replyer);
    				modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
    				modal.data("rno",reply.rno);//댓글번호. data-rno 생성됨
    				
    				modal.find("button[id!='modalCloseBtn']").hide();
    				modalModBtn.show();
    				modalRemoveBtn.show();
    				$(".modal").modal("show");
    			});    			
    		});
    		/* 댓글 수정 버튼 event처리 *************************************************************************/
    		modalModBtn.on("click",function(){
    			var reply={rno:modal.data("rno"),reply:modalInputReply.val(),replyer:modalInputReplyer.val()};
    			replyService.update(reply,function(result){
    				alert(result);
    				modal.modal("hide");
    				showList(pageNum);
    			});
    		})
    		/* 댓글 삭제 버튼 event처리 *************************************************************************/
    		modalRemoveBtn.on("click",function(){    
    			var rno=modal.data("rno");
    			replyService.remove(rno,function(result){
    				alert(result);
    				modal.modal("hide");
    				showList(pageNum);
    			});
    		})
    		
    	});
    </script>



<%@ include file="../includes/footer.jsp" %>