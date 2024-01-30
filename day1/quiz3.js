// 아래 문제를 함수 선언문, 함수 표현식, 화살표 함수로 정의하고
// 호출되어 실행되는 코드를 작성해 보이시오.

// 문제3)
// 배열의 모든 요소를 더하는 함수 만들기 sumArray라는 이름의 함수를 정의해보세요.
// 이 함수는 숫자로 이루어진 배열을 매개변수로 받아 그 합을 반환해야 합니다.


// case 1) 함수 선언문
{
  const arr = [1, 2, 3, 4, 5];

  function sumArray(arr) {
    let sum = 0;
    // for (let i = 0; i < arr.length; i++) {
    //   sum += arr[i]
    // }
    for(let ele of arr) { // for in은 객체순환 of는 배열순환
      sum += ele;
    }
    return sum;
  }
  console.log(sumArray(arr));
}

console.log('------------------------------');
// case 2) 함수 표현식
{
  const arr = [1, 2, 3, 4, 5];

  let sumArray = function (arr) {
    let sum = 0;
    for(let ele of arr) {
      sum += ele;
    }
    return sum;
  }
  console.log(sumArray(arr));
}

console.log('------------------------------');
// case 3) 화살표 함수
const arr = [1, 2, 3, 4, 5];

let sumArray = arr => {
  let sum = 0;
  for(let ele of arr) {
    sum += ele;
  }
  return sum;
}
console.log(sumArray(arr));