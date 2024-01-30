// 아래 문제를 함수 선언문, 함수 표현식, 화살표 함수로 정의하고
// 호출되어 실행되는 코드를 작성해 보이시오.

// 문제5)
// n배수 함수를 반환하는 함수를 정의하고 실행됨을 보이시오
// 정수 1개를 매개값으로 전달하면 n배수된 값으로 반환해야 합니다.



// case 1) 함수 선언문
{
  function f(x) {
    return function mul(n) {
      console.log(x * n);
    }
  }

  f(5)(2);
}

{
  function f(x) {
    return function f(n) {
      return x * n;
    }
  }

  console.log(f(5)(2));
}


console.log('------------------------------');
// case 2) 함수 표현식

{
  let f = function (x) {
    return function f(n) {
      return x * n;
    }
  }

  console.log(f(5)(2));
}


console.log('------------------------------');
// case 3) 화살표 함수
{
  let f = x => {
    return function f(n) {
      return x * n;
    }
  }

  console.log(f(5)(2));
}