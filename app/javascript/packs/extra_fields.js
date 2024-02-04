
$(document).ready(function() {
  const addButton = document.getElementById("add-descricao");

  const removeButton = document.createElement("button");
  removeButton.textContent = "Remove";
  removeButton.classList.add("btn", "btn-danger", "mt-2");
  
  addButton.addEventListener("click", function() {
    const addButton = document.getElementById("add-descricao");
    const formGroup = document.querySelector(".form-group");
    var clonedRow = $(".fields:last").clone();

    $(".fields:last").after(clonedRow);
  });
});
