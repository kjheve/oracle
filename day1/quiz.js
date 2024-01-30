// 아래 문제를 함수 선언문, 함수 표현식, 화살표 함수로 정의하고
// 호출되어 실행되는 코드를 작성해 보이시오.

// 문제1)
// 두 수의 차이(절대값)를 구하는 함수 만들기 calculateDifference라는 이름의 함수를 정의해 보세요
// 이 함수는 두 개의 숫자를 매개변수로 받아 두 수의 차이를 반환해야 합니다.


// case 1) 함수 선언문
{
  let a = 10;
  let b = 20;

  function calculateDifference(x, y) {
    let result = x - y;
    if (result < 0) {
      result *= -1;
    }
    return result;
  }

  // let z = calculateDifference(a, b);
  // console.log(z);
  console.log(calculateDifference(a, b));
}
console.log('------------------------------');
// case 2) 함수 표현식
{
  let a = 10;
  let b = 20;
 
  let calculateDifference = function (x, y) {
    let result = x - y;
    if (result < 0) {
      result *= -1;
    }
    return result;
  }
  
  // let z = calculateDifference(a, b);
  // console.log(z);
  console.log(calculateDifference(a, b));
}
console.log('------------------------------');
// case 3) 화살표 함수
{
  let a = 10;
  let b = 20;
 
  let calculateDifference = (x, y) => {
    let result = x - y;
    if (result < 0) {
      result *= -1;
    }
    return result;
  };
  
  // let z = calculateDifference(a, b);
  // console.log(z);
  console.log(calculateDifference(a, b));
}

