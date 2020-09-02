const displayFromUkToFr = () => {
  document.querySelectorAll('.uk-fr').forEach((el) => {
    el.style.display = 'block';
  });
}

const hideFromUkToFr = () => {
  document.querySelectorAll('.uk-fr').forEach((el) => {
    el.style.display = 'none';
  });
}

const displayFromFrToUk = () => {
  document.querySelectorAll('.fr-uk').forEach((el) => {
    el.style.display = 'block';
  });
}

const hideFromFrToUk = () => {
  document.querySelectorAll('.fr-uk').forEach((el) => {
    el.style.display = 'none';
  });
}

const switchFromUkToFr = () => {
  document.getElementById('fr-uk-btn').addEventListener('click', (event) => {
    hideFromFrToUk();
    displayFromUkToFr();
  });
}

const switchFromFrToUk = () => {
  document.getElementById('uk-fr-btn').addEventListener('click', (event) => {
    hideFromUkToFr();
    displayFromFrToUk();
  });
}

switchFromUkToFr();
switchFromFrToUk();
