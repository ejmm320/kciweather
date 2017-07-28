$(document).ready ->
  # Clear form fields in order to get random weather
  $("#wrandom_btn").on "click", (event)->
    $("#weather_country").val("")
    $("#weather_city").val("")
    event.preventDefault()
    $("form#new_weather").submit()

  # Check presence of City
  $("#wplace_btn").on "click", (event)->
    event.preventDefault()  
    if $("#weather_city").val() == ""
      $("#weather_city").parent().append ->
        "<p class='alert alert-danger'>Please Provide a City</p>"
    else
      $("form#new_weather").submit()