MENU_WRAPPER_PATH = "[data-role='catalog_menu'] .wrapper"


openMenuItem = ->
  $(this).find(".submenu").show()

closeMenuItems = ->
  $("[data-role='catalog_menu'] .wrapper .submenu").hide()




$ ->
  $menuActivator = $("#{MENU_WRAPPER_PATH}")

  $menuActivator.on "mouseover", openMenuItem

  $menuActivator.on "mouseout", closeMenuItems
