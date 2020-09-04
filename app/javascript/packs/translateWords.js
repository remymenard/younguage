const googleTranslate = require('free-google-translation');
import Highlighter from 'web-highlighter';
const highlighter = new Highlighter({
  style: {
    className: 'highlight'
}
});


let untranslated;
let translated;

let isAddedToFlashCards = false;

const resetState = () => {
  translated.style.color = "rgb(255,255,255)";
  $(".icon-container").removeClass("saved").addClass("not-saved");
  isAddedToFlashCards = false;
}

const translation = (word) => {

untranslated = document.getElementById("untranslated");
translated = document.getElementById("translated");

let sourceLanguage = 'en';
let targetLanguage = 'fr';

googleTranslate(word, sourceLanguage, targetLanguage)
.then(function(response) {
    // console.log(response);
    resetState();
    untranslated.innerText = word
    translated.innerText = response
  $("#translation").show();
}).catch(function () {
  alert("Google Traduction n'est pas accessible actuellement.")
});
}

const addSpaces = () => {
  let all_p = document.querySelectorAll("h2, h1, p");
  all_p.forEach(paragraph => {
    // console.log(paragraph);
    paragraph.innerText = " " + paragraph.innerText + " "
  });
}

const translateWords = () => {
  addSpaces();
  try {
    let s;
  $('#content').click(function(e) {
    s = window.getSelection();
    var range = s.getRangeAt(0);
    var node = s.anchorNode;

    while (range.toString().indexOf(' ') != 0 && range.startOffset != 0) {
        range.setStart(node, (range.startOffset - 1));
    }
    range.setStart(node, range.startOffset + 1);

    do {
        range.setEnd(node, range.endOffset + 1);
    } while (range.toString().indexOf(' ') == -1 && range.toString().trim() != '' && range.endOffset < range.endContainer.length);

    var str = range.toString().trim();
    // alert(str);
    str = str.replace(/\.|!|\?|,|\(|\)|:/g, '')
    highlighter.removeAll()
    highlighter.fromRange(range)
    translation(str)
});
  } catch (error) {
    console.log('no word to translate');
  }

}

const close = () => {
  resetState();
  $("#translation").hide();
}

const startAutoClose = () => {
  setTimeout(function() { close(); }, 1000);
}

const activateButton = () => {
  $("#cloud").click(function(e) {
    e.preventDefault();
    if (!isAddedToFlashCards) {
      $.ajax({
          type: "POST",
          url: "/words",
          headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
          data: {
            word: untranslated.innerText,
            translation: translated.innerText
          },
          success: function(text) {
            if(text.saved) {
              console.log('perfect')
              $(".icon-container").removeClass("not-saved").addClass("saved");
                untranslated.innerText = "Traduction"
                translated.style.color = "rgb(101,255,144)";
                translated.innerHTML = "enregistrée"
                isAddedToFlashCards = true;
                startAutoClose();
            }
            else {
              $('#premium-pop-up').show();
            }
              // $("#translation").hide();
          },
          error: function() {
              alert("Could not save your flashcard on our servers, try again later. Sorry :'(");
          }
      });
    }
});

$("#cross").click(function (e) {
  e.preventDefault();
  resetState();
  close();
})

$(".plus-tard").click(function (e) {
  e.preventDefault();
  $('#premium-pop-up').hide();
  resetState();
  close();
})
}

translateWords();
activateButton();
// document.addEventListener('turbolinks:load', translateWords);
// document.addEventListener('turbolinks:load', activateButton);
