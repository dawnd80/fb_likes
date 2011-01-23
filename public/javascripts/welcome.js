$(document).ready(function() {
  FB.init({appId: '185076204847204', status: true, cookie: true, xfbml: true});
  FB.Event.subscribe('auth.login', function(response) { window.location.reload(); });
});