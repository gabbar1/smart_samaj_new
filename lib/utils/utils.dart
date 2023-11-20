bool isNotEmptyCondition(condition) {
  return condition.toString().trim().toLowerCase() != 'null' &&
      condition.toString().trim() != '';
}