// Array.prototype.forEach()

const arr = [1, 2, 3];

const x2 = function(value) {
  return console.log(value * 2);
}
arr.forEach(x2);

console.log('------------------');

arr.forEach(function(value) {
  return console.log(value * 2);
});

console.log('------------------');

arr.forEach((value) => console.log(value * 2));

