$ ->
  $("[data-role=uploader]").on "click", "[data-role=upload_trigger]", (event) ->
    event.preventDefault()
    $("[data-role='uploader'] input[type=file]").click()

  $("[data-role=uploader]").on "change", "input[type=file]", ->
    $("[data-role=uploader] [data-role=remove_form] .busy").removeClass("hidden").show()
    $(this).parents("form").submit()

  $("[data-role=uploader]").on "click", "[data-role=remove_trigger]", (event) ->
    event.preventDefault()
    $("[data-role=uploader] [data-role=remove_form]").submit()
