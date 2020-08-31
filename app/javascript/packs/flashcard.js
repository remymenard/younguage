const submitButtonSwitchFlashcard = () => {
  document.querySelectorAll('.fc-submit-btn').forEach((submit_btn) => {
    submit_btn.addEventListener('click', (event) => {
      event.preventDefault();

      const flashcardResponse = document.getElementById('flashcard_response').value;
      document.querySelectorAll('#flashcard_response').forEach((input) => {
        input.value = flashcardResponse;
      });

      event.srcElement.parentElement.parentElement.parentElement.children[0].style.display = 'none';
      event.srcElement.parentElement.parentElement.parentElement.children[1].style.display = 'block';

    });
  });
}

const masteredSubmit = () => {
  document.querySelectorAll('.mastered-submit').forEach((btn) => {
    btn.addEventListener('click', (event) => {
      event.srcElement.parentElement.parentElement.parentElement[2].value = 'true';
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

displayFlashcards()
submitButtonSwitchFlashcard()
masteredSubmit()
