$(window).on("scroll", function() {
  var ajaxStopper = false;
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0) {
      var page = $(".record-box").attr('data-page');
      if(page == "last" || ajaxStopper){return}
      ajaxStopper = true;
      $(".loader-container").removeClass("d-none")
      var url = "/infinite_scrolling?page=" + page
      setTimeout(function() {
        $.ajax({
           url: url
        }).always(function(){
           ajaxStopper = false;
        })
      }, 500);
  }
});