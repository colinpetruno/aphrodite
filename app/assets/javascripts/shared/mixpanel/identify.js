$(document).on("turbolinks:load", function() {
  if( $("body").data("first-visit") && Aphrodite.current_user) {
    mixpanel.alias(Aphrodite.current_user.id);
    mixpanel.people.set({
        "$email": Aphrodite.current_user.email,    // only special properties need the $
        "$created": Aphrodite.current_user.created_at
    });
  }

  if(Aphrodite.current_user) {
    mixpanel.identify(Aphrodite.current_user.email);
  }
});
