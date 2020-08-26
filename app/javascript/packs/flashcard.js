document.addEventListener('turbolinks:load', () => displayFlashcards());

const flashcardSubmitButton = (i, list) => {
  if(i <= list) {
    document.querySelector(`#flashcard-${i} #fc-recto`).style.display = 'block';
    const submitButton = document.querySelector(`#flashcard-${i} #fc-submit-btn`);
    submitButton.addEventListener('click', (event) => {
      event.preventDefault();
      const flashcardResponse = document.querySelector(`#flashcard-${i} #fc-recto #flashcard_response`).value;
      document.querySelector(`#flashcard-${i} #fc-verso #flashcard_response`).value = flashcardResponse;
      document.querySelector(`#flashcard-${i} #fc-recto`).style.display = 'none';
      document.querySelector(`#flashcard-${i} #fc-verso`).style.display = 'block';
    });

    document.querySelectorAll(`#flashcard-${i} .fc-btn`).forEach((btn) => {
      btn.addEventListener('click', (event) => {
        event.preventDefault();
        document.querySelector(`#flashcard-${i} #fc-verso`).style.display = 'none';
        i += 1;
        flashcardSubmitButton(i, list);
      });
    });
  } else {
    document.getElementById('congrats').style.display = 'block';
  }
}

const displayFlashcards = () => {
  let i = 1;
  const list = document.getElementById('flashcards-list').dataset.listSize;
  flashcardSubmitButton(i, list);
}

export { displayFlashcards };
