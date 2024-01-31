// const arr = [1, 2, 3];

// arr.forEach(ele => console.log(ele*2));

// [1, 2, 3].forEach(ele => console(ele*3));

// -----------------------------------------------------

// ★★ Array 함수
// forEach, filter, map, sort ★★
// -----------------------------------------------------

// const persons = [
//   {},
//   {},
//   {}
// ];


const persons = [
  { name: '홍길동', age: 30, gender: '남' },
  { name: '홍길서', age: 20, gender: '여' },
  { name: '홍길남', age: 10, gender: '남' }
];


console.log('-------1)---------');
//  1) 나이 합을 구하시오
// let sum = 0;
// for (let i = 0; persons.length; i++) {
//   sum += persons[i].age
// }

let sumOfage = 0;
persons.forEach( (ele, idx, arr) => {
  sumOfage += ele.age;
});
console.log(sumOfage);


console.log('-------2)---------');
//  2) 남자는 몇명?
// let cnt = 0;
// for (let i = 0; persons.length; i++) {
//   if (persons[i].gender == '남') {
//     cnt++;
//   }
// }

const result = persons.filter((ele, idx, arr) => ele.gender == '남');
console.log(result.length);


console.log('-------3)---------');
//  3) 최연소 자의 이름은?
const age = persons.map(ele => ele.age).sort()[0];
console.log(age);

const minAgeName = persons.filter(ele => ele.age == 10)[0].name;
console.log(minAgeName);



console.log('-------4)---------');
//  4) 나이 오름차순으로 이름을 출력하시오.
// console.log(persons.sort());

// 오름차순
const result2 = persons.sort( (first, second) => {
  return first.age - second.age
});
console.log(result2);
result2.forEach(ele => console.log(ele.name));

console.log('----------------');
// 내림차순
const result3 = persons.sort( (first, second) => second.age - first.age );
console.log(result3);
result3.forEach(ele => console.log(ele.name));