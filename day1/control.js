// 제어문
// 1~10까지의 짝수합 홀수합을 구하시오

let sumOfEven = 0; // 짝수합
let sumOfOdd = 0; // 홀수합
for(let i=1; i<=10; i++) {
  if (i%2 == 1) {
    sumOfOdd += i;
  } else {
    sumOfEven += i;
  }
}
console.log('짝수합 : ' + sumOfEven);
console.log('홀수합 : ' + sumOfOdd);
