Blacklight.onLoad(function () {
  var ctrlDown = false

  $('#permalink-copy-btn').on('click', function (e) {
    $('#permalink-text').select();
    document.execCommand("copy");
  })
  $('#permalink-text').on('keydown', function (e) {
    if (e.keyCode == 17 || e.keyCode == 91) {
      ctrlDown = true
      return;
    }
    if (e.keyCode == 67 && ctrlDown) {
      return;
    }
    e.preventDefault();
    e.stopPropagation();
  }).on('keyup', function (e) {
    if (e.keyCode == 17 || e.keyCode == 91) {
      ctrlDown = false
    }
  })
})