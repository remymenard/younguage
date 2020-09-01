document.addEventListener('turbolinks:load', () => scrollButton());

const scrollButton = () => {
   let lastScrollTop = 0;
  $(window).scroll(function(event){
     let st = $(this).scrollTop();
     if (st > lastScrollTop){
        // Scroll up
        $("#myBtn").addClass("d-none")
     } else {
        // Scroll down
        $("#myBtn").removeClass("d-none")
     }
     lastScrollTop = st;
  });
}
