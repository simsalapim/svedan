class Quiz
  constructor: (@wordId) ->
    @attemptTemplate = Handlebars.compile($("#attempt-template").html())

  attempt: (answer) ->
    $.post "/ords/#{@wordId}/attempt", answer: answer, (resp) =>
      $("#attempts").prepend(@attemptTemplate(resp))
      $("#attempts .attempt:first").slideDown("fast")
      #if resp.successful
      #  $('.submit-attempt').animate opacity: 0, ->
      #else
      #  $('.submit-attempt').animate opacity: 0, ->
      #    $(this).val('hej')
      @nextQuestion()

  fitWord: (word) ->
    if $('#quiz-question').is(':empty')
      $('#quiz-question').text(word)
      width = @_getWidth(word)
      $('#quiz-question').css(width: "#{width}px")
    else
      $('#quiz-question').html('&nbsp;')
      newWidth = @_getWidth(word)
      $('#quiz-question').animate width: "#{newWidth}px", ->
        $('#quiz-question').text(word)

  _getWidth: (word) ->
    $('#measurement').text(word)
    $('#measurement').width()


  nextQuestion: ->
    $.getJSON 'ords/next_question', (data) =>
      $('#answer').val('')
      @wordId = data.id
      console.log(data.swedish)
      @fitWord(data.english)


$ ->
  window.quiz = new Quiz()
  quiz.nextQuestion()
  $('#answer').focus()

  $('form.quiz').on 'submit', (e) =>
    e.preventDefault()
    if $('#answer').validatePresence()
      quiz.attempt($('#answer').val())