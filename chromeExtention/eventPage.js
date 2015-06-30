// referred to http://stackoverflow.com/questions/6850276/how-to-convert-dataurl-to-file-object-in-javascript
function dataURLtoBlob(dataurl){
    var arr = dataurl.split(','),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);
    while(n--){
	u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {type:mime});
}


chrome.runtime.onMessage.addListener(function(request, sender, callback) {

    if(request.type == "0"){
	console.log("----- type 1 ---------");
	console.log("----- the searched word---------");
	console.log(request.word);
	console.log("----- the setence which includes the word ---------");
	console.log(request.sentence);
	var xhr = new XMLHttpRequest();
	xhr.open("GET", request.url, true);
	xhr.onload = function() {
	    callback(xhr.responseText);
	};
	xhr.onerror = function() {
	    callback("failure"); // to clean up the communication port.
	};
	xhr.send();
	return true; // prevents the callback from being called too early on return

    }else if(request.type == "1"){
	console.log("----- type 2 ---------");
	chrome.tabs.captureVisibleTab(function(dataurl) {
	    console.log("----- capture ---------");
	    console.log(dataurl.substring(0,100));
	    console.log(dataurl);

	    var blob = dataURLtoBlob(dataurl);
	    var fd = new FormData();
	    fd.append("picture", blob, "hello.jpg");
	    fd.append("word", request.word);
	    fd.append("sentence", request.sentence);
	    
	    var xhr = new XMLHttpRequest();
	    var req_url = "http://160.16.87.98:3005/posts/iphone";
	    xhr.open("POST", req_url, true);
	    xhr.onreadystatechange = function() {
	    	if (xhr.readyState == 4) {
	    	    console.log("----------- POST worked ---------------");
	    	    console.log(xhr.responseText);
	    	    callback(xhr.responseText);
	    	}
	    }
	    console.log("--- sending request --");
	    xhr.send(fd);
	});	
	return true;
    }else{
	return true;
    }
});
