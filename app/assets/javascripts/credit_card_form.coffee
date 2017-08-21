$(document).ready () ->
  # showError, stripeResponseErrors, submitHandler
  console.log 'Ready', $('.cc_form')

  style =
    base:
      color: '#32325d',
      lineHeight: '24px',
      fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
      fontSmoothing: 'antialiased',
      fontSize: '16px',
      '::placeholder':
        color: '#aab7c4'

    invalid:
      color: '#fa755a',
      iconColor: '#fa755a'


  try
    elements = stripeInstance.elements()
    card = elements.create 'card', {style: style}
    card.mount '#credit-card'
  catch e
    console.warn 'No stripe instance'

  $('.cc_form').on 'submit', (event) ->
    event.preventDefault()

    $form = $(event.target)

    $form.find("input[type=submit]").prop("disabled", true)

    if stripeInstance
      stripeInstance.createToken(card).then (resp) ->
        console.log resp

        stripeResponseHandler resp
    else
      showError "Failed to load credit card functionality. Please, reload your browser"

    return false


  stripeResponseHandler = (response) ->
    $form = $('.cc_form');

    if response.error
      console.log response.error.message
      showError response.error.message
      $form.find("input[type=submit]").prop("disabled", false)
    else
      console.log response
      token = response.token.id
      $form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token))
      $("[data-stripe=number]").remove()
      $("[data-stripe=cvv]").remove()
      $("[data-stripe=exp-year]").remove()
      $("[data-stripe=exp-month]").remove()
      $("[data-stripe=label]").remove()
      $form.get(0).submit()

    return false;


  showError = (message) ->
    if $("#flash-messages").size() < 1
      $('div.container.main div:first').prepend("<div id='flash-messages'></div>")

    $("#flash-messages")
      .html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>')

    $('.alert').delay(5000).fadeOut(3000)

    return false
