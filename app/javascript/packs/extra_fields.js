
$(document).ready(function() {
  const addButton = document.getElementById("add-descricao");
  addButton.addEventListener("click", function() {
    const addButton = document.getElementById("add-descricao");
    const formGroup = document.querySelector(".form-group");

    function getPreviousValue() {
      const previousInput = document.getElementById("despesa_descricao")
      if (previousInput) {
        return previousInput.value;
      }
      return "";
    }

    const label = document.createElement("label");
    label.textContent = "Descrição";
    label.setAttribute("for", "descricao");
    label.classList.add("mr-2"); 

    const input = document.createElement("input");
    input.setAttribute("type", "text");
    input.setAttribute("name", "despesa[descricao][]");
    input.setAttribute("class", "form-control mt-2");
    input.setAttribute("required", true);
    input.value = getPreviousValue();

    const label2 = document.createElement("label");
    label2.textContent = "Valor";
    label2.setAttribute("for", "valor");
    label2.classList.add("mr-2"); 

    const input2 = document.createElement("input");
    input2.setAttribute("type", "text");
    input2.setAttribute("name", "despesa[valor][]");
    input2.setAttribute("class", "form-control mt-2");
    input2.setAttribute("required", true);

    const label3 = document.createElement("label");
    label3.textContent = "Date";
    label3.setAttribute("for", "date");
    label3.classList.add("mr-2"); 

    const input3 = document.createElement("input");
    input3.setAttribute("type", "date");
    input3.setAttribute("name", "despesa[date][]");
    input3.setAttribute("class", "form-control mt-2");

    const hr = document.createElement("hr")
    const removeButton = document.createElement("button");
    removeButton.textContent = "Remove";
    removeButton.classList.add("btn", "btn-danger", "mt-2");

    removeButton.addEventListener("click", function() {
      formGroup.removeChild(label);
      formGroup.removeChild(input);
      formGroup.removeChild(label2);
      formGroup.removeChild(input2);
      formGroup.removeChild(label3);
      formGroup.removeChild(input3);
      formGroup.removeChild(hr);
      formGroup.removeChild(removeButton);
    });

    formGroup.insertBefore(label, addButton);
    formGroup.insertBefore(input, addButton);
    formGroup.insertBefore(label2, addButton);
    formGroup.insertBefore(input2, addButton);
    formGroup.insertBefore(label3, addButton);
    formGroup.insertBefore(input3, addButton);
    formGroup.insertBefore(hr, addButton);
    addButton.insertAdjacentElement("afterend", removeButton);
  });
});
