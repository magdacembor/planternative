const initAutocomplete = () => {
  const input = document.getElementById("query");
  const resultsDiv = document.getElementById("autocomplete-suggestions");
  const navbar = document.querySelector(".navbar");

  if (input && resultsDiv && navbar && location.pathname === "/") {
    input.addEventListener("keyup", (event) => {
      resultsDiv.innerHTML = "";
      const searchString = event.currentTarget.value;
      const url = `/autocomplete/${searchString}`;
      fetch(url)
      .then(response => response.json())
      .then((data) => {
        let resultsList = "";
        if (searchString === "") {
          resultsDiv.style.display = "none";
        } else {
          resultsDiv.style.display = "";
        }
        if (data.length > 0) {
          const suggestedResults = data;
          suggestedResults.forEach((result) => {
            resultsList += `<a href="/products?query=${result}">\n`;
            resultsList += `<div class="autocomplete-suggestion">${result}</div>\n`;
            resultsList += `</a>\n`;
            resultsDiv.innerHTML = resultsList;
          });
        }
      });
    });
    input.addEventListener("focus", (event) => {
      resultsDiv.style.display = "";
    });
    navbar.addEventListener("click", (event) => {
      resultsDiv.style.display = "none";
    });
  }
}

export { initAutocomplete };
