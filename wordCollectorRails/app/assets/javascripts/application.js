// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function applySort(){
    console.log("--- I'm gonna send the rearranged ordered data ---");

    $.ajax({
	url: "/sort",
	type: "POST",
	data: $("tbody.words").sortable("serialize"),
	dataType: 'script'
    });
    location.reload();
}

var i = false;
function sortableToggle(){
    if(i){
	$("tbody.words").sortable("destroy");
	$( "tbody.words" ).selectable({
    	    filter: "tr",
    	    cancel: 'td.misc'
	});
    }else{
	$("tbody.words .ui-selected").removeClass("ui-selected");
	$("tbody.words").selectable( "destroy" );
	$("tbody.words").sortable().disableSelection();
    }
    $("#applySort").toggle();
    i = !i;
}

function changeCat(){
    var dest_id = $("#category").val();
    var selected = [];
    $('tbody tr.ui-selected').each(function(){
	selected.push($(this).find(".word").attr("post_id"));
    });

    $.ajax({
	type: "POST",
	url: "/hoge",
	data: JSON.stringify({selected: selected, dest_id: dest_id}),
	dataType: "json",
	contentType: "application/json",
	success: function(data){
    	    console.log(data);
	    location.reload();
	}
    })
}

var ready = function() {


    // pops up image
    $(".word img").hide();
    $(".word").mouseover(function(){
	$(this).find("img").show();
    })
    $(".word").mouseleave(function(){
	$(this).find("img").hide();
    })

    // jquery selectable ui 
    $( "tbody.words" ).selectable({
    	filter: "tr",
    	cancel: 'td.misc'
    });
    $("#applySort").hide();
};

$(document).ready(ready);
$(document).on('page:load', ready);
