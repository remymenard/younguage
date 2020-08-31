document.addEventListener('turbolinks:load', () => displayWords());

const results = document.querySelectorAll('.translation');

const input = document.querySelector('.search');

const drawResponseList = (data) => {
  results.innerHTML = '';
  data.words.forEach((word) => {
    results.insertAdjacentHTML('beforeend', `<li>${word}</li>`);
  });
};

const autocomplete = (e) => {
  fetch('/words', { headers: { accept: "application/json" }})
    .then(response => response.json())
    .then(data => drawResponseList(data));
};
const displayWords = (event) => {
  input.addEventListener('keyup', autocomplete);

}
 // méthode qui me renvoit tout les mots qui commence par ce qui est écrit -> dans le controller (méthode ? show)
 //each sur tout les mots 'translation'
// choper les mots qui faut
