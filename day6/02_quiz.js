// Array.prototype.reduce() 활용하기

const numbers = [3, 2, 3, 6, 1, 5];

// 문1) 배열 요소의 평균을 구하시오
{
  // 배열의 합
  const numbersSum = numbers.reduce((acc, curr, idx, arr) => {
    return acc + curr;
  }, 0);
  console.log(`배열의 합 : ${numbersSum}`);

  // 평균구하기
  const result = numbers.reduce((acc, curr, idx, arr) => {
    if (idx == arr.length - 1) { // 배열의 인덱스가 마지막 요소에 도달시
      return (acc + curr) / arr.length; // 평균값 계산 후 return
    } else {
      return acc + curr; // 배열의 길이와 안같으면 계속 더하기
    }
  }, 0);

  // 삼항 연산자로 변경
  const numsAvg = numbers.reduce((acc, curr, idx, arr) =>
    (idx == arr.length - 1) ? (acc + curr) / arr.length : acc + curr
    , 0);

  console.log(`평균 : ${result}`);
  console.log(`평균2 : ${numsAvg}`);

}



// 문2) 배열 요소중 최대값 구하기
{
  const result = numbers.reduce((acc, curr) =>
    (acc > curr) ? acc : curr);
  console.log(`배열 요소의 최대값 : ${result}`);

  const result2 = numbers.reduce((acc, curr) =>
    (acc > curr) ? acc : curr, 0);
  console.log(`배열 요소의 최대값2 : ${result2}`);
}

const fruits = ['banana', 'apple', 'orange', 'orange', 'apple']
// 문3) 과일의 갯수를 객체 리터럴로 출력하세요 ex {banana:1, apple:2, orange:2}
// 프로퍼티 키 : 프로퍼티 밸류
// 03_objectLitteral.js 를 보고 다시 이해
{
  // case 1) forEach문
  const obj = {};
  fruits.forEach((ele, idx) => {
    if (ele in obj) {
      obj[ele]++; // obj.ele는 안됨
    } else {
      obj[ele] = 1;
    }
  });
  console.log(obj);

  // case 2) reduce (chatGPT)
  const fruitCount = fruits.reduce((acc, curr) => {
    acc[curr] = (acc[curr] || 0) + 1; // 04_shorCircuit.js 참고
//                             0이면 false(Falsy)
    return acc; // 콜백 함수는 항상 누적된 값을 반환
  }, {});

  console.log(fruitCount); // { banana: 1, apple: 2, orange: 2 }
}
{
  // ★★★
  // fruits.reduce(
  //   (acc, curr, idx, arr)=>{}
  // 빈객체, 첫번째요소, 인덱스번호, 배열전체 
  //   , {} // 시작요소 표시
  // );
  const result =
  fruits.reduce(
    (acc, curr, idx, arr)=>{
      if( curr in acc ) {
        acc[curr]++;
      } else {
        acc[curr] = 1;
      }
      return acc; // 콜백 함수는 항상 누적된 값을 반환
    }
    , {}
  );
  console.log(result);

  // 삼항연산자로 변경
  const result2 = fruits.reduce(
    (acc, curr, idx, arr)=>{ ( curr in acc ) ? acc[curr]++ : acc[curr] = 1;
      return acc; // 콜백 함수는 항상 누적된 값을 반환
    }, {}
  );
  console.log(result2);
}