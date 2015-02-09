$ ->
  $(".cart table").on "click", ".minus", ->
    v = parseInt($(this).parent().find("input").val())
    v = 1 if v == 0
    $(this).parent().find("input").val(v - 1)

  $(".cart table").on "click", ".plus", ->
    v = parseInt($(this).parent().find("input").val())
    v = 98 if v == 99
    $(this).parent().find("input").val(v + 1)

  $(".cart").on "click", "[data-role=gen_specification]", (event) ->
    event.preventDefault()

    $form = $(this).parents "form"

    prev_action = $form.attr "action"
    $form.attr "action", "#{prev_action}.pdf"
    $form.attr "target", "_blank"
    $form.submit()
    $form.attr "action", prev_action
    $form.attr "target", "_self"
