# formatItem = (data) ->
#   "<div>#{data.id} - #{data.text}</div>"

# formatTag = (data) ->
#   "<a class='active-tag-link'><span class='label light_blue'>#{data.text}</span></a>"


$ ->
  $("[data-role=extra_categories_receiver] [data-role=extra_categories_form] select").select2(
    # templateResult: formatItem
    # templateSelection: formatTag
    minimumInputLength: 2
    width: '100%'
  )

  $("[data-role=extra_categories_receiver]").on "click", "[data-role=apply]", (event) ->
    event.preventDefault()
    $("[data-role=extra_categories_receiver] [data-role=extra_categories_form] .busy").removeClass("hidden").show()
    $("[data-role=extra_categories_receiver] [data-role=extra_categories_form]").submit()

  $("[data-role=extra_categories_receiver]").on "click", "[data-role=reset]", (event) ->
    event.preventDefault()
    current_category_ids = $("[data-role=extra_categories_receiver] [data-role=extra_categories_form] input[name=current_category_ids]").val()
    $("[data-role=extra_categories_receiver] [data-role=extra_categories_form] select").select2("val", current_category_ids.split(","))

