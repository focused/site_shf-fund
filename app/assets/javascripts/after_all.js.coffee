//= require_self

$ ->
  $("[data-role=slider]").slick
    # fade: true
    speed: 500
    autoplay: true
    autoplaySpeed: 3000
    arrows: false
    infinite: true
    slidesToShow: 1
    slidesToScroll: 1
    centerMode: true
    centerPadding: '60px'
    variableWidth: true
    dots: true
    cssEase: 'linear'
    # slide: 'div'

  # $("[data-role=slider]")
  #   .animate
  #     opacity: 1
  #   , 1000, "swing", -> $(this).css("overflow", "visible")



