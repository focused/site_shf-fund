$ ->
  $("[data-role=gallery]").on "click", "[data-image-url]", ->
    $(".gallery > img").attr("src", $(this).data("imageUrl"))
