$(document).ready(function () {
  $('#feedback-btn').click(function () {
    $('#feedback-container').toggle();
  })

  $('#feedback-form').submit(function (e) {
    if ($("input[name=feedback_type]").val() === '') {
      alert('Please select the type of feedback');
      e.preventDefault();
      return;
    }

    if ($('#comments').val() === '') {
      alert('Please add a comment');
      e.preventDefault();
      return;
    }

    $('#feedback-save-btn').text('Thank you')
    $('#feedback-save-btn').attr("disabled", true)
  })
})