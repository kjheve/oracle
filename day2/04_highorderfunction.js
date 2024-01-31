// 고차함수 : 함수의 매개값으로 함수를 전달 받는 함수
//            또는 함수를 반환하는 함수

// 1) Array.prototype.forEach()

{
  const arr = [1, 2, 3];
  function multifly2x(x) {
    return x * 2;
  }

  const x = multifly2x; // 함수 객체 참조
  console.log(multifly2x(2));
  console.log(x(2));

  const y = multifly2x(2); // 함수 호출
  console.log(y);


  console.log(multifly2x);
  
console.log('--------------------------');
// ------------------------------------------


  function multifly2x_for(x) {
    console.log(x * 2);
  }
  arr.forEach(multifly2x_for);

  arr.forEach(function multifly2x_for(x) {
    console.log(x * 2);
  });

  arr.forEach( x => console.log(x * 2) );
  
}

{
  const arr = [1, 2, 3];
  arr.forEach((ele, idx, arr) => {
    console.log(ele, idx, arr)
  })
}