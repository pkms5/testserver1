var replyService=(function(){
	function add(reply, callback, error){
	
		$.ajax({
			type: 'post', //전송방식
			url: '/replies/new', //서버주소
			data: JSON.stringify(reply), //서버로 전송되는 데이터
			contentType: 'application/json; charset=utf-8', //서버로 전송되는 데이터의 형식,
			success:function(result,status,xhr){
				//성공했을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 callback에 전달
				if(callback){
					callback(result); //함수호출
				}
			},
			error:function(xhr,status,er){
				//에러가 났을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 error에 전달. 실제 사용안하고 있음.
				if(error){
					error(er); //함수호출
				}
			}
		});
	
	}
	function getList(param, callback, error){
		var bno=param.bno;
		var page=param.page || -1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",function(data){
			if(callback){
				console.log(data.replyCnt);
				callback(data.replyCnt,data.list);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
			
	}
	function displayTime(timeValue){
		var today=new Date();//현재날짜시간
		var gap=today.getTime()-timeValue; //현재날짜시간과 댓글작성일시간의 차이
		var dateObj=new Date(timeValue);
		var str="";
		// gap이 24시간 미만이면 시:분:초 형식으로 출력
		if(gap<1000*60*60*24){
			var hh=dateObj.getHours();
			var mi=dateObj.getMinutes();
			var ss=dateObj.getSeconds();
			
			return [(hh>9?'':'0')+hh, ':', (mi>9?'':'0')+mi, ':', (ss>9?'':'0')+ss].join(''); // 배열을 요소를 모두 연결해서 리턴
		}else{
			var yy=dateObj.getFullYear();
			var mm=dateObj.getMonth()+1; 
			var dd=dateObj.getDate();
			
			return [yy,'/',(mm>9?'':'0')+mm, '/', (dd>9?'':'0')+dd].join('');
		}
	}
	function get(rno,callback,error){
		$.get("/replies/"+rno+".json",function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr,status,err){
			if(error){
				error();
			}
		});
	}
	function update(reply,callback,error){
		$.ajax({
			type: 'put', //전송방식
			url: '/replies/'+reply.rno, //서버주소
			data: JSON.stringify(reply), //서버로 전송되는 데이터
			contentType: 'application/json; charset=utf-8', //서버로 전송되는 데이터의 형식,
			success:function(result,status,xhr){
				//성공했을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 callback에 전달
				if(callback){
					callback(result); //함수호출
				}
			},
			error:function(xhr,status,er){
				//에러가 났을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 error에 전달. 실제 사용안하고 있음.
				if(error){
					error(er); //함수호출
				}
			}
		});
	}
	function remove(rno,callback,error){
		$.ajax({
			type: 'delete', //전송방식
			url: '/replies/'+rno, //서버주소			
			success:function(deleteResult,status,xhr){
				//성공했을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 callback에 전달
				if(callback){
					callback(deleteResult); //함수호출
				}
			},
			error:function(xhr,status,er){
				//에러가 났을 때 할 일. 외부에서 함수로 정의한 후 함수의 이름을 error에 전달. 실제 사용안하고 있음.
				if(error){
					error(er); //함수호출
				}
			}
		});
	}

	return {
		add:add,
		displayTime:displayTime,
		getList:getList,
		get:get,
		update:update,
		remove:remove		
	}; // 객체를 리턴
})();



