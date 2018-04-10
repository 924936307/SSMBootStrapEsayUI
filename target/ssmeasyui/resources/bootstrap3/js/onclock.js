function getDateTime(){
	var date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth()+1<10 ? "0" +(date.getMonth()+1) : date.getMonth()+1;
	var day=date.getDate() <10 ? "0" + date.getDate() : date.getDate();
	var weekday=date.getDay();
	var week=new Array("星期天","星期一","星期二","星期三","星期四","星期五","星期六")
	var h=date.getHours()  <10 ? "0" + date.getHours() : date.getHours();
	var m=date.getMinutes() <10 ? "0" + date.getMinutes() : date.getMinutes();
	var s=date.getSeconds() <10 ? "0" + date.getSeconds() : date.getSeconds();
	if(h>12){
		h=h-12;
	if(h<10){
		h="0"+h;	
	}
	var sContent=year+"年"+month+"月"+day+"日"+"&nbsp;&nbsp;"+week[weekday]+"&nbsp;&nbsp;"+h+"时"+m+"分"+s+"秒"+"&nbsp;&nbsp;"+"pm";
	}else{
		var sContent=year+"年"+month+"月"+day+"日"+"&nbsp;&nbsp;"+week[weekday]+"&nbsp;&nbsp;"+h+"时"+m+"分"+s+"秒"+"&nbsp;&nbsp;"+"am";
		}
	document.getElementById("clock").innerHTML="<h3>"+sContent+"</h3>";
	setTimeout("getDateTime()",200);
}
