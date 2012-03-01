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

