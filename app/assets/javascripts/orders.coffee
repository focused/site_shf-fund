$ ->
  $(".cart table").on "click", ".minus", ->
    v = parseInt($(this).parent().find("input").val())
    v = 1 if v == 0
    $(this).parent().find("input").val(v - 1)

  $(".cart table").on "click", ".plus", ->
    v = parseInt($(this).parent().find("input").val())
    v = 98 if v == 99
    $(this).parent().find("input").val(v + 1)
