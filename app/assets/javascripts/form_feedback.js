$(document).ready(function () {
  $('#feedback-btn').click(function () {
    $('#feedback-container').toggle();
  })

  $('#feedback-form').submit(function (e) {
    e.preventDefault();
    if ($("input[name=feedback_type]").val() === '') {
      alert('Please select the type of feedback');
      return;
    }

    if ($('#comments').val() === '') {
      alert('Please add a comment');
      return;
    }

    $('#feedback-save-btn').attr("disabled", true);
    $('#feedback-save-btn').addClass("sending");
    $('#feedback-save-btn').text('Sending');
    $('#feedback-container .error').hide();

    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function (data) {
        $('#feedback-container .error').hide();
        $('#feedback-container').html('<div class="feedback-thankyou">Thank you for your feedback</div>');
      },
      error: function (err) {
        $('#feedback-container .error').show();
        $('#feedback-save-btn').attr("disabled", false);
        $('#feedback-save-btn').removeClass("sending");
        $('#feedback-save-btn').text('Send');
      }
    });
  })
})