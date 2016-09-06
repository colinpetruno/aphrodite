$(document).on("turbolinks:load", function() {
  var pageName = $("body").data("current-page");
  mixpanel.track("Page View", {"Page Name": pageName });
});
