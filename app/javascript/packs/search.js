// document.addEventListener('turbolinks:load', () => displayWords());



// const wordArray = Array.prototype.slice.call(translations);
const input = document.querySelector('#query');
const words = document.querySelectorAll('.all-words')


const autocomplete = (e) => {

  const translations = document.querySelectorAll('.translation');
  const unstranslated = document.querySelectorAll('.word');
  unstranslated.forEach((result, index) => {
    words[index].classList.remove("hidden");
    console.log(translations[index].innerText.trim());
    if(input.value != "") {

      if (!result.innerText.startsWith(input.value)){
        words[index].classList.add("hidden");
      }
    }

  });
}

const displayWords = (event) => {
  input.addEventListener('keyup', autocomplete);
}

displayWords();
 // méthode qui me renvoit tout les mots qui commence par ce qui est écrit -> dans le controller (méthode ? show)
 //each sur tout les mots 'translation'
// choper les mots qui faut
