
// 문제6)
// 배열과 n배수 함수를 입력 받아 배열의 각 요소를 n배수하는 함수를 정의하고
// 실행됨을 보이시오.


// {
//   function f(arr, n) {
//     return function () {
//       for (let ele of arr) {
//         return ele * n;
//       }
//     }
//   }
//   let arr = [1, 2, 3];
//   console.log(f(arr, 3));
// }

{
  // quiz5.js의 함수
  function f(x) {
    return function f(n) {
      return x * n;
    }
  }

  function f2(arr, f) {
    let result = [];
    for (let ele of arr) {
      result.push(f(ele));
    }
    return result;
  }

  console.log(f2([1, 2, 3], f(2)));
  console.log('---')
  console.log(f2([1, 2, 3], f(3)));
  console.log('---');
  console.log(f2([1, 2, 3], f(4)));

}