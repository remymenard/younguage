const stickers = document.querySelectorAll(".sticker");
const form = document.querySelector('.topics-form');

const ColorStickerOnClick = () => {

  stickers.forEach((sticker) => {
    sticker.addEventListener('click', (event) => {
      const topic = event.srcElement.innerText;
      if ($(`input#${topic}`).length > 0) {
        $(`input#${topic}`).remove();
        sticker.classList.remove(`${topic}`)
        console.log('test')
      } else {
        sticker.classList.add(`${topic}`);
        form.insertAdjacentHTML('beforeend', `<input id="${topic}" class="topicInput" name="${topic}" type="hidden" value="true">`);
      }
    });
  });
}

ColorStickerOnClick()
