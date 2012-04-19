// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

replaceVideoTeaser = function (elem, video) {
    $(elem).hide();
    $(elem).parent().append($(video));
}

$(function(){
    $(".video-teaser").each(function(){
        $(this).append("<div class='video-teaser-icon'></div>");    
    });    
});

function fb_edge_create_callback(params) {
  return social_handler("type=like&act=inc");
}

function fb_edge_remove_callback(params) {
  return social_handler("type=like&act=dec");
}

function fb_comment_create_callback(params) {
  return social_handler("type=comment&act=inc");
}

function fb_comment_remove_callback(params) {
  return social_handler("type=comment&act=dec");
}

function gplusone_callback(params) {
  var act = params.state == 'on' ? "inc" : "dec" ;
  return social_handler("type=like&act=" + act);
}


function social_handler(params) {
  //alert('You liked: ' + document.URL + "/social_handler?" + params);
  $.get(document.URL + "/social_handler?" + params, function(data){});
  return true;
}
