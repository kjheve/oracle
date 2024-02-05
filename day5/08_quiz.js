const persons = [
  { name: '홍길동', age: 30, gender: '남' },
  { name: '홍길순', age: 20, gender: '여' },
  { name: '홍길선', age: 30, gender: '여' },
  { name: '홍길남', age: 40, gender: '남' }
];


// 문1) person배열에서 남성 이름을 나이 내림차순으로 콘솔에 출력해 보이시오. // 홍길동, 홍길남

const result = persons.filter(ele => ele.gender === '남')
.sort((a, b) => a.age - b.age)
.map(ele => ele.name);

console.log(result);