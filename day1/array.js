// 배열

//  1) 빈 배열 생성
const arr = [];

// 2) 요소 추가
arr.push(1);
arr.push(2);
arr.push(3);

console.log(arr);

// 3) 요소 길이
console.log('요소의 길이 : ' + arr.length);

// 4) 요소의 순환
for (let i = 0; i < arr.length; i++) {
  console.log(arr[i]);
}
// for ~ of (자바에서 for-each문)
for (let ele of arr) {
  console.log(ele);
}

// 5) 요소 삭제
arr.pop(); // 제일 나중 요소를 반환하면서 삭제
console.log(arr);
const ele = arr.pop();
console.log(ele); // 반환된거 확인
console.log(arr);

arr.push(2, 3, 4, 5); // 다시 추가
console.log(arr);
// 특정 인덱스 요소 삭제
delete arr[2];
console.log(arr);

// .at()
console.log(arr[1]);
console.log(arr.at(1));
console.log(arr.at(-4));