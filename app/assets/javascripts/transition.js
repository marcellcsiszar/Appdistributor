jQuery(document).on("page:fetch", function() {
  //scroll to top
  jQuery("html, body").animate({ scrollTop: 0 }, "slow");
  // add .loading to div with #load (could be in base.php)
    jQuery("#load").addClass('loading');
  //fade out content, target whatever you want
  jQuery('div.content').animate({ opacity: 0  });
});

jQuery(document).on("page:restore", function() {
  //fade in content
  jQuery('div.content').animate({ opacity: 1 });
  //remove .loading
 jQuery("#load").removeClass('loading');
});