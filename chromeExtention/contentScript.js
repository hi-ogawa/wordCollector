// dom for monitoring inputs to dictionary
$ext_div0 = $("<div>").attr("id", "ext_div0")
$input0 = $("<input>").attr("id", "word");
$input1 = $("<input>").attr("id", "sentence");

// dom for showing meanings/suggestions from dictionary
$ext_div1 = $("<div>").attr("id", "ext_div1");
$ext_ul = $("<ul>");

// adding all doms
$("body").append($ext_div0.append($input0)
                          .append($input1))
         .append($ext_div1.append($ext_ul));

$ext_div1.hide();
$ext_div1.click(function(){
    $input0.val("");
    $input1.val("");
    $ext_div1.hide();
});



var DELAY = 200, clicks = 0, timer = null;
$("body").on("mouseup", function(e){
    if(e.altKey || e.shiftKey){return; }
    clicks++;
    var w = window.getSelection().toString().trim();
    if(w == ""){return; }
    if(clicks === 1) {
        timer = setTimeout(function() {
    	    //// text selection / single click ///

	    $input0.val( $input0.val() + " " + w);
	    $input1.val( window.getSelection().getRangeAt(0).startContainer.parentNode.textContent );

    	    //// text selection / single click ///
            clicks = 0;
        }, DELAY);
    } else {
        clearTimeout(timer);
    	//// double click ///

	$input0.val( $input0.val() + " " + w);
	$input1.val( window.getSelection().getRangeAt(0).startContainer.parentNode.textContent );

    	//// double click ///
        clicks = 0;
    }
}).on("dblclick", function(e){
    e.preventDefault();
});


function lookUpWord(){
    console.log("--- LookUpWord ---");
    var voc = $input0.val().trim();
    var s = $input1.val().trim();
    if( voc == "" ){ return; }
    var req_url = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/"
                   + encodeURIComponent(voc) + "?key=c4c815db-b3ae-4d2f-8e31-2e556ec300bd";
    // using message exchange to avoid https limitation
    chrome.runtime.sendMessage({
	url: req_url,
	type: "0",
	word: voc,
	sentence: s
    }, function(responseText) {

	$ext_ul.empty();

	console.log("-- LookUpWord : got response --");
	console.log(responseText);

	if(responseText == "failure"){return;}

	var xml = $.parseXML(responseText);
	if( $(xml).find("dt").size() != 0 ){

	    // show the meanings
	    $(xml).find("dt").each(function(){
		$ext_ul.append(
		    $("<li>").text($(this).text()));
	    });

	}else{

	    // show the suggestions
	    $(xml).find("dt").each(function(){
		$ext_ul.append(
		    $("<li>").text($(this).text()));
	    });

	}

	$ext_div1.show();

	if($(".div-alc #alc").length != 0){
	    var l = "http://eow.alc.co.jp/search?q=" + voc;
	    $(".div-alc #alc").attr("src", l);
	    $(".div-alc #alc").load( function() {
		$( ".div-alc" ).scrollTop(350);
	    } );
	}
    });
}

function shootAndUpload(){
    console.log("--- shootAndUpload ---");
    console.log($input0.val().trim());
    chrome.runtime.sendMessage({
	type: "1",
	word: $input0.val().trim(),
	sentence: $input1.val().trim(),
    }, function(responseText) {
	console.log("-- shootAndUpload : got response --");
	console.log(responseText);
	if(responseText == "you got it uploaded\n"){
	    $ext_ul.prepend($("<li>").text("you got it."));
	    $input0.val("");
	    $input1.val("");
	}
	else{
	    $ext_ul.prepend($("<li>").text("not good."));
	}
    });
}


$(document).keydown(function (e) {
    console.log("--- keydone ---");
    if(e.altKey && e.shiftKey && e.which == 83){
	console.log("--- alt shift 83 ---");
	shootAndUpload();
	return;
    }
    if(e.altKey && e.which == 83)
	console.log("--- alt 83 ---");
	lookUpWord();
});
