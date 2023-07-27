
$(document).ready(function() {
  const addButton = document.getElementById("add-descricao");
  addButton.addEventListener("click", function() {
    const addButton = document.getElementById("add-descricao");
    const formGroup = document.querySelector(".form-group");

    const label = document.createElement("label");
    label.textContent = "Descrição";
    label.setAttribute("for", "descricao");
    label.classList.add("mr-2"); 

    const input = document.createElement("input");
    input.setAttribute("type", "text");
    input.setAttribute("name", "despesa[descricao][]");
    input.setAttribute("class", "form-control mt-2");
    input.setAttribute("required", true);

    const label2 = document.createElement("label");
    label2.textContent = "Valor";
    label2.setAttribute("for", "valor");
    label2.classList.add("mr-2"); 

    const input2 = document.createElement("input");
    input2.setAttribute("type", "text");
    input2.setAttribute("name", "despesa[valor][]");
    input2.setAttribute("class", "form-control mt-2");
    input2.setAttribute("required", true);

    const hr = document.createElement("hr")

    formGroup.insertBefore(label, addButton);
    formGroup.insertBefore(input, addButton);
    formGroup.insertBefore(label2, addButton);
    formGroup.insertBefore(input2, addButton);
    formGroup.insertBefore(hr, addButton);
  });
});
