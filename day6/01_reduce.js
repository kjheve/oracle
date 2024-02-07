// const array1 = [1, 2, 3, 4];

// // 0 + 1 + 2 + 3 + 4
// const initialValue = 0;
// const sumWithInitial = array1.reduce(
//   (accumulator, currentValue) => accumulator + currentValue,
//   initialValue,
// );

// console.log(sumWithInitial);
// // Expected output: 10

//case 1) 초기값을 안 준 경우  `reduce(f)` : initial값이 없으면 배열의 첫번째를 초기값으로 설정
{
  const arr = [1, 2, 3];
  //타입을 알아야 객체에 접근할 수 있다.
  // console.log(typeof arr); //객체 타입확인
  // console.log(Object.prototype.toString.call(arr)) //객체의 구체적인 타입 확인
  // console.dir(arr);

  //reduce --> 배열의 요소를 누적시킨다. 4개의 인자를 받는다
  // arr.reduce(()=>{})
  const result = arr.reduce((acc, ele, idx, self) => {
    console.log(acc, ele, idx, self);
    return acc + ele;
  });
  console.log(result);
}
//case2) 초기값을 준 경우   `reduce(f,i)
{
  const arr = [1, 2, 3];
  const result = arr.reduce((acc, ele, idx, self) => {
    console.log(acc, ele, idx, self)
    return acc + ele;
  }, 10);//여기 0은 초기값
  console.log(result)
}

{
  const arr = ['a','b','c'];

  const result = arr.reduce((acc,ele) => acc + ele);

  console.log(result);
}
{ //모든 사람의 나이를 합하기
let people = [
  { name: 'John', age: 21 },
  { name: 'Jane', age: 24 },
  { name: 'Smith', age: 27 },
  { name: 'Doe', age: 30 }
];

//case 1. map사용해서 나이만 추출하기
console.log(people.map(ele => ele.age)) // [21,24,27,30] //people.map(ele => ele.age): 자체가 배열이기 때문에 고차함수 사용가능
const sumOfage = people.map(ele=>ele.age).reduce((acc,ele)=>acc+ele);
console.log(`나이 총합은 ${sumOfage}입니다.`)

//case 2. for문사용
let sum = 0;
for(let ele of people){
  sum += ele.age;
}
console.log(`나이 총합은 ${sumOfage}입니다.`)
}