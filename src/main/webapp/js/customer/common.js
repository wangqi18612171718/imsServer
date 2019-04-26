function formatterdate(createtime) {
	if(createtime!=null){
		if(createtime=="-62135798400000"){
			return "";
		}else{
			var date = new Date(createtime);
			return date.getFullYear() + "-" + (date.getMonth() + 1) + "-"+ date.getDate();
		}
	}else{
		return "";
	}
}

function formatdate(createtime) {
	if(createtime!=null){
		var date = new Date(createtime);
		return date.getFullYear() + "/" + (date.getMonth() + 1) + "/"+ date.getDate();
	}else{
		return "";
	}
}