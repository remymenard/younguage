const YouTubeIframeLoader = require('youtube-iframe');
let player;

function loadPlayer() {
  YouTubeIframeLoader.load(function(YT) {
    player = new YT.Player('player', {
      autoplay: '1',
      events: {
        'onStateChange': onPlayerStateChange
      }
    });
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

var MarkersInit = function(markers) {
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
    marker = {};
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
var markers = [];

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
      var $container = $('#translations-box');
      var $scrollTo = $('.youtube-marker-current');

    $container.scrollTop(
        $scrollTo.offset().top - $container.offset().top + $container.scrollTop()
    );

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
  $("#translation").hide();
  player.playVideo();
})
}

loadPlayer();
addSpaces();
translateWords();
activateButton();
$(window).bind('beforeunload', function(){
  throw new Error('This is not an error. This is just to abort javascript');
});
// document.addEventListener('turbolinks:load', activateButton);
