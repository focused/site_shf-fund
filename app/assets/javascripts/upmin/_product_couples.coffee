# formatItem = (data) ->
#   "<div>#{data.id} - #{data.text}</div>"

# formatTag = (data) ->
#   "<a class='active-tag-link'><span class='label light_blue'>#{data.text}</span></a>"


$ ->
  $("[data-role=receiver] [data-role=product_couples_form] select").select2(
    # templateResult: formatItem
    # templateSelection: formatTag
    minimumInputLength: 2
    width: '100%'
  )

  $("[data-role=receiver]").on "click", "[data-role=apply]", (event) ->
    event.preventDefault()
    $("[data-role=receiver] [data-role=product_couples_form] .busy").removeClass("hidden").show()
    $("[data-role=receiver] [data-role=product_couples_form]").submit()

  $("[data-role=receiver]").on "click", "[data-role=reset]", (event) ->
    event.preventDefault()
    current_couple_ids = $("[data-role=receiver] [data-role=product_couples_form] input[name=current_couple_ids]").val()
    $("[data-role=receiver] [data-role=product_couples_form] select").select2("val", current_couple_ids.split(","))

