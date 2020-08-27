document.addEventListener('turbolinks:load', () => {displayFlashcards(), submitButtonSwitchFlashcard(), masteredSubmit()});

const submitButtonSwitchFlashcard = () => {
  document.querySelectorAll('.fc-submit-btn').forEach((submit_btn) => {
    submit_btn.addEventListener('click', (event) => {
      event.preventDefault();

      document.querySelectorAll('.flashcard_response').forEach((el) => {
        el.addEventListener('click', (event) => {
          console.log(event);
        });
      });

      const response = event.srcElement.parentElement.children[2].innerText;
      // console.log(response);
      event.srcElement.parentElement.parentElement.parentElement.children[1].children[1][2].innerText = response;
      event.srcElement.parentElement.parentElement.parentElement.children[0].style.display = 'none';
      event.srcElement.parentElement.parentElement.parentElement.children[1].style.display = 'block';
    });
  });
}

const masteredSubmit = () => {
  document.querySelectorAll('.mastered-submit').forEach((btn) => {
    btn.addEventListener('click', (event) => {
      console.log(event);
      event.srcElement.parentElement.children[4].children[0].value = 'true';
    });
  });
}

const congratulationsDisplay = () => {
  document.getElementById('congrats').style.display = 'block';
}

const displayFlashcards = () => {
  const unmasteredFlashcards = document.querySelectorAll('.flashcard-card[data-mastered="false"]');
  if (unmasteredFlashcards.length == 0) {
    congratulationsDisplay();
  } else {
    unmasteredFlashcards[0].querySelector('.fc-recto').style.display = 'block';
  }
}

export { displayFlashcards };
