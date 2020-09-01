

const ColorStickerOnClick = () => {
  const stickers = document.querySelectorAll(".sticker");
  const form = document.querySelector('.topics-form');

  stickers.forEach((sticker) => {
    sticker.addEventListener('click', (event) => {
      const topic = event.srcElement.innerText;
      if ($(`#${topic}`).length > 0) {
        $(`#${topic}`).remove();
        sticker.classList.remove(`${topic}`)
      } else {
        sticker.classList.add(`${topic}`);
        form.insertAdjacentHTML('beforeend', `<input id="${topic}" name="${topic}" type="hidden" value="true">`);
      }
    });
  });

}

ColorStickerOnClick()
