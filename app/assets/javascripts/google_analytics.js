$(document).ready(function() {

  // UNIVERSAL TRACKING CODE FROM GA WEBSITE

  (function(i,s,o,g,r,a,m){
    i['GoogleAnalyticsObject']=r;

    i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)
    },

    i[r].l=1*new Date();

    a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];
    a.async=1;
    a.src=g;
    m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  // Point our running instance to the appropriate GA property definition
  ga('create', google_analytics_web_property_id, 'columbia.edu');

  // FOR LOCALHOST DEVELOPMENT USE THIS LINE INSTEAD
//  ga('create', google_analytics_web_property_id, 'none');

  // This sends the a normal page-view to Google Analytics.
  // It runs once on page load.
  ga('send', 'pageview');

  $('body').on('submit', function(event) {
    var advanced = (event.target.getElementsByClassName("advanced_search_button").length == 1)
    var basic = (event.target.getElementsByClassName("basic_search_button").length == 1)
    var action = ""
    var label = ""
    var category = "Search"
    if (advanced) {
      action = "Advanced Search Submit"
      e = document.getElementById('advanced_operator')
      field_name = e.options[e.selectedIndex].text
      label += field_name + ' of '
      fields = event.target.getElementsByClassName("advanced_search_row")
      var i;
      for (i=0; i<fields.length; i+=1) {
        e = document.getElementById('adv_'+(i+1)+'_field')
        field = $(fields[i]).find("option[selected=selected]")
        field_name = e.options[e.selectedIndex].text
        value = $(field).parent().parent().next().find('input').val()
        if (value != "") {
          if (i>0){
            label += ' & '
          }
          label += field_name + ':' + value
        }
      }
    }
    else if (basic) {
      action = "Basic Search Submit"
      value = $(this).find('.search_q').val()
      field_name = $(this).find('btn.dropdown-toggle').text().trim()
      label = field_name + ': ' + value + ' '
    }
    else{
      return
    }

    console.log("ga('send','event','"+category+"','"+action+"','"+label+"')")
    ga('send', 'event', category, action, label, {useBeacon: true});

  });

  $('body').on('click', 'a[data-ga-category]', function(event) {
    // Gather up values at time of click, not at first load, to allow
    // for ajax updates to, e.g., href labels or targets

    var href   = $(this).attr("href");
    var target = $(this).attr("target");
    var text   = $(this).text();

    // The GA Category/Action may be given at a higher DOM level,
    // e.g., at the root of an html menu/list of links, or a container div,

    var category = $(this).closest("[data-ga-category]").data("ga-category") || "Outbound Link";
    var action = $(this).closest("[data-ga-action]").data("ga-action") || "Click";
    var label = $(this).data("ga-label") || text;

    var open_new_window = false

    // Offsite links will open a new window unless it is a download link

    if ((this.hostname && this.hostname !== location.hostname) && action != "Download Click"){
      open_new_window = true;
    }

    if (open_new_window){
      event.preventDefault(); // don't open the link yet
    }

    console.log("ga('send','event','"+category+"','"+action+"','"+label+"')")
    ga('send', 'event', category, action, label, {useBeacon: true});

    if (open_new_window){
      setTimeout(function() { // now wait 300 milliseconds...
        window.open(href, (!target ? "_blank" : target)); // ...and open in new blank window
      },300)
    }
  });


  $(this).bind('copy', function() {
    var selectedText = "";
    if (window.getSelection) {
        selectedText = window.getSelection().toString()
    } else if (document.selection && document.selection.type != "Control") {
        selectedText = document.selection.createRange().text
    }
    if (selectedText.length > 0) {
      // console.log('copy event')
      // What GA category/action/label do we want to log this event as?
    }
    return true;
  }); 

});
