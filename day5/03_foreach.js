// 고차함수 forEach 복습


// foreach   컨트롤 + 스페이스시
// array.forEach(element => {
  
// });

const array = ['a', 'b', 'c'];

// array.forEach(element => {
//   console.log(element)
// });

array.forEach((element, idx, arr) => {
  element = element.toUpperCase(); // 대문자로 변환시키기
  console.log(element, idx, arr);
});


// 반환값이 없기 때문에
const result = array.forEach((element, idx, arr) => {
  element = element.toUpperCase(); // 대문자로 변환시키기
  console.log(element, idx, arr);
});
console.log(result); // 무의미함 undefined




