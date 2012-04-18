FB.init({status: true, cookie: true, xfbml: true});
  alert('fbinit');
  FB.Event.subscribe('edge.create',
    function(response) {
      alert('You liked the URL: ' + response);
    }
  );
  FB.Event.subscribe('edge.remove',
    function(response) {
      alert('You unliked the URL: ' + response);
    }
  );
};
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=152692304811046";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


(function() {
    var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
    po.src = 'https://apis.google.com/js/plusone.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
})();


window.twttr = (function (d,s,id) {
    var t, js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return; js=d.createElement(s); js.id=id;
    js.src="//platform.twitter.com/widgets.js"; fjs.parentNode.insertBefore(js, fjs);
    return window.twttr || (t = { _e: [], ready: function(f){ t._e.push(f) } });
  }(document, "script", "twitter-wjs"));
twttr.ready(function (twttr) {
    twttr.events.bind('tweet', function(event) {
      alert('You tweeted the URL: ' + document.url);
    });
});
