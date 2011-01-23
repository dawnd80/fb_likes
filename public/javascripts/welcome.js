$(document).ready(function() {
  FB.init({appId: $('#fb-app-id').text(), status: true, cookie: true, xfbml: true});
  FB.Event.subscribe('auth.login', function(response) { window.location.href = $('#callback-url').text(); });
  
  $("a#logout").click(function(e){
    FB.logout(function(r) {
      console.log('logging out fb');
      window.location.href = $(this).attr('callback');
    });
    return false;
  });
});
