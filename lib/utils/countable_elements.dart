String elements(int num) {
  var remains100 = num % 100;
  var remains10 = num % 10;
  bool exception = remains100 > 10 && remains100 < 20;
  if (exception || remains10 >= 5 || remains10 == 0) {
    return '$num записей';
  } else if (remains10 == 1) {
    return '$num запись';
  } else if (remains10 > 1 && remains10 < 5) {
    return '$num записи';
  }
  return '$num запись';
}
