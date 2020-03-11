const initAutocomplete = () => {
  const input = document.getElementById("query");

  if (input && location.pathname === "/") {
    input.addEventListener("keyup", (event) => {
      const resultsDiv = document.getElementById("autocomplete-suggestions");
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
            resultsList += `<a href="/products/?query=${result}">\n`;
            resultsList += `<div class="autocomplete-suggestion">${result}</div>\n`;
            resultsList += `</a>\n`;
            resultsDiv.innerHTML = resultsList;
          });
        }
      });
    });
  }
}

export { initAutocomplete };
