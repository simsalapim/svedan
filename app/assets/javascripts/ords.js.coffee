# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $('.new_ord input').on 'blur', (e) ->
    if !$.contains($('.new_ord')[0], e.relatedTarget)
      $('.new_ord .form-group').slideUp('fast')

  $('.new_ord .input-group input:first').on 'click', ->
    $('.new_ord .form-group').slideDown('fast')

  resetNewWordForm = (callback)->
    $('#ord_swedish').val('')
    $('#ord_english').val('')
    $('.new_ord .form-group').slideUp('fast', callback)

  sayThanks = ->
    oldText = $('.tagline').text()
    $('.tagline').animate 'top': '50px', opacity: 0, ->
      $('.tagline').text('Tack!')
      $('.tagline').animate 'top': '0px', opacity: 1, ->
        $('.tagline').delay(1000).animate 'top': '50px', opacity: 0, ->
          $('.tagline').text(oldText)
          $('.tagline').animate 'top': '0px', opacity: 1


  $.fn.validatePresence = ->
    console.log(this)
    if !this.val().trim().length
      this.animate(left : '10px',  100)
          .animate(left : '-10px', 100)
          .animate(left : '10px',  100)
          .animate(left : '0px',   100)
      false
    else
      true

  $('.new_ord').on 'submit', (e)->
    # The * operator performs eager evaluation instead of short circuiting like &&
    if !!($('#ord_swedish').validatePresence() * $('#ord_english').validatePresence())
        e.preventDefault()

  $('.new_ord').on 'ajax:success', (e, data, status, xhr) ->
    sayThanks()
    resetNewWordForm ->
      $("#ords").prepend(data)
      $("#ords :first").css('display', 'none').slideDown()
      $('.new_ord .form-group').slideUp('fast')
