const submitButtonSwitchFlashcard = () => {
  $('.fc-submit-btn').click(function () {
    //Some code
    const flashcardResponse = $('flashcard_response_recto').val();
    // console.log(flashcardResponse);

    document.querySelectorAll('#flashcard_response_verso').forEach((input) => {
      // console.log(input.value);
      input.value = flashcardResponse;
      // console.log(input.value);
    });

    event.srcElement.parentElement.parentElement.parentElement.children[0].style.display = 'none';
    event.srcElement.parentElement.parentElement.parentElement.children[1].style.display = 'block';
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

const congratulationsDisplayNone = () => {
  document.getElementById('congrats').style.display = 'none';
}

const displayFlashcards = () => {
  const unmasteredFlashcards = document.querySelectorAll('.flashcard-card[data-mastered="false"]');
  if (unmasteredFlashcards.length == 0) {
    congratulationsDisplay();
  } else {
    // congratulationsDisplayNone();
    unmasteredFlashcards[0].querySelector('.fc-recto').style.display = 'block';
  }
}


document.addEventListener('DOMContentLoaded', () => {
  displayFlashcards()
  submitButtonSwitchFlashcard()
  masteredSubmit()
})
