export var inputmask = new Inputmask({
  alias: "currency",
  prefix: "R$ ",
  groupSeparator: ",",
  radixPoint: ".",
  digits: 2,
  autoGroup: true,
  digitsOptional: false,
  placeholder: "0",
  rightAlign: false,
  removeMaskOnSubmit: true,
  unmaskAsNumber: true,
  allowMinus: false
});