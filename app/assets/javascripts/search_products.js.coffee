$(document).on "keyup", "#search", (e) ->
  unless $(this).val() is ""
    $("#submit_tag").removeAttr "disabled"
  else
    $("#submit_tag").attr "disabled", "disabled"
  return
