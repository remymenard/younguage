// document.addEventListener('turbolinks:load', () => displayWords());


const results = document.querySelectorAll('.translation');
const wordArray = Array.prototype.slice.call(results);
const input = document.querySelector('#query');
const words = document.querySelectorAll('.all-words')


const autocomplete = (e) => {

  results.forEach((result, index) => {
    words[index].classList.remove("hidden");
    if (!result.innerText.startsWith(input.value)){
      words[index].classList.add("hidden");
    }
  });
}

const displayWords = (event) => {
  input.addEventListener('keyup', autocomplete);
}
 // méthode qui me renvoit tout les mots qui commence par ce qui est écrit -> dans le controller (méthode ? show)
 //each sur tout les mots 'translation'
// choper les mots qui faut
