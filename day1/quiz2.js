// 아래 문제를 함수 선언문, 함수 표현식, 화살표 함수로 정의하고
// 호출되어 실행되는 코드를 작성해 보이시오.

// 문제2)
// 문자열 결합 함수 만들기 concatStrings라는 이름의 함수를 정의해보세요.
// 이 함수는 두 개의 문자열을 매개변수로 받아 하나의 문자열로 합쳐 반환해야 합니다.


// case 1) 함수 선언문
{
  function concatStrings(x, y) {
    return x + y;
  }
  console.log(concatStrings('hello', 'world'));
}
console.log('------------------------------');
// case 2) 함수 표현식
{
  let concatStrings = function(x, y) {
    return x + y;
  }
  console.log(concatStrings('hello', 'world'));
}

console.log('------------------------------');
// case 3) 화살표 함수
let concatStrings = (x, y) => x + y;
console.log(concatStrings('hello', 'world'));

