const googleTranslate = require('free-google-translation');

let untranslated;
let translated;

const translation = (word) => {

untranslated = document.getElementById("untranslated");
translated = document.getElementById("translated");

let sourceLanguage = 'en';
let targetLanguage = 'fr';

googleTranslate(word, sourceLanguage, targetLanguage)
.then(function(response) {
    // console.log(response);
    untranslated.innerText = word
    translated.innerText = response
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
    translation(str)
});
  } catch (error) {
    console.log('no word to translate');
  }

}

const activateButton = () => {
  $("#cloud").click(function(e) {
    e.preventDefault();
    console.log(untranslated.innerText)
    console.log(translated.innerText)
    $.ajax({
        type: "POST",
        url: "/words",
        headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
        data: {
          word: untranslated.innerText,
          translation: translated.innerText
        },
        success: function(result) {
            alert('ok');
        },
        error: function(result) {
            alert('error');
        }
    });
});
}

document.addEventListener('turbolinks:load', translateWords);
document.addEventListener('turbolinks:load', activateButton);
