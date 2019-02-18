Blacklight.onLoad(function () {
  $('#permalink-copy-btn').on('click', function (e) {
    $('#permalink-text').select();
    document.execCommand("copy");
  })
  $('#permalink-text').on('keydown', function (e) {
    e.preventDefault();
    e.stopPropagation();
  })
})