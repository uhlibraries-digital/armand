Blacklight.onLoad(function () {
  $('.sidebar .profile-logout a').click(function (e) {
    e.stopPropagation();
    e.preventDetault();
  })
})