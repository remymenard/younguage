import Highlighter from 'web-highlighter';
const highlighter = new Highlighter({
  style: {
    className: 'highlight'
}
});


const YouTubeIframeLoader = require('youtube-iframe');
let player;
let markers = []
let $container = $('#translations-box');

function loadPlayer() {
  YouTubeIframeLoader.load(function(YT) {
    player = new YT.Player('player', {
      events: {
        'onStateChange': onPlayerStateChange
      }
    });
  setTimeout(function() {
    player.mute();
    player.playVideo(); }, 1000);

  });
}

function onPlayerStateChange(event) {
  var Update;
  if (event.data == YT.PlayerState.PLAYING) {
    Update = setInterval(function() {
      UpdateMarkers()
    }, 100);
  } else {
    clearInterval(Update);
  }
}

var MarkersInit = function() {
  var elements = document.querySelectorAll('.youtube-marker');
  Array.prototype.forEach.call(elements, function(el, i) {
    var time_start = el.dataset.start;
    var time_end = el.dataset.end;
    var id = el.dataset.id;;
    if (id >= 1) {
      id = id - 1;
    } else {
      id = 0;
    }
    let marker = {};
    marker.time_start = time_start;
    marker.time_end = time_end;
    marker.dom = el;
    if (typeof(markers[id]) === 'undefined') {
      markers[id] = [];
    }
    markers[id].push(marker);
  });
}

// On Ready

document.onreadystatechange = () => {
  if (document.readyState === 'complete') {

    MarkersInit(markers);

    var elements = document.querySelectorAll('.youtube-marker');
    Array.prototype.forEach.call(elements, function(el, i) {
      el.onclick = function() {
        var pos = el.dataset.start;
        // player.seekTo(pos);
        player.pauseVideo();
      }
    });

  } // Document Complete
}; // Document Ready State Change

function UpdateMarkers() {
  var current_time = player.getCurrentTime();
  var j = 0; // NOTE: to extend for several players
  markers[j].forEach(function(marker, i) {

    if (current_time >= marker.time_start && current_time <= marker.time_end) {
      marker.dom.classList.add("youtube-marker-current");
      let $scrollTo = $('.youtube-marker-current');
      try {
        $container.scrollTop(
        $scrollTo.offset().top - $container.offset().top + $container.scrollTop()
        );
      } catch (error) {
        return;
      }


    } else {
      marker.dom.classList.remove("youtube-marker-current");
    }
  });
}


const googleTranslate = require('free-google-translation');

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
  let all_p = document.querySelectorAll("span");
  all_p.forEach(paragraph => {
    // console.log(paragraph);
    paragraph.innerText = " " + paragraph.innerText + " "
  });
}

const translateWords = () => {
  // addSpaces();
  try {
    let s;
  $('.youtube-marker').click(function(e) {
    player.pauseVideo();
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
    // highlight();
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
  player.playVideo();
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
          success: function() {
            $(".icon-container").removeClass("not-saved").addClass("saved");
              untranslated.innerText = "Traduction"
              translated.style.color = "rgb(101,255,144)";
              translated.innerHTML = "enregistrée"
              isAddedToFlashCards = true;
              startAutoClose();
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
  close();
})
}
function loadAll() {
  if (document.body.contains(document.getElementById('player'))) {
    loadPlayer();
    addSpaces();
    translateWords();
    activateButton();
  }
}

loadAll();
