// Array.prototype.find()
// Array.prototype.findIndex()
// Array.prototype.findLastIndex()

const persons = [
  { name: '홍길동', age: 30, gender: '남' },
  { name: '홍길순', age: 20, gender: '여' },
  { name: '홍길선', age: 30, gender: '여' },
  { name: '홍길남', age: 40, gender: '남' }
];

// 처음 발견된 나이가 20인 사람
const finded = persons.find(ele=> ele.age == 20);
console.log(finded);

// 앞에서부터 처음 발견된 나이 30인 사람의 위치
const findedIdxPerson = persons.findIndex(ele=> ele.age == 30);
console.log(findedIdxPerson);

// 뒤에서부터 처음 발견된 나이 30인 사람의 위치
const findedIdxPerson2 = persons.findLastIndex(ele=> ele.age == 30);
console.log(findedIdxPerson2);

