const removeElements = () => {
  $('svg').remove()
  console.log('called')
}

function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    console.log("called")
    done = true;
  }
}

window.addEventListener('load', removeElements);
