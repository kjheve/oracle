
// 고차함수 종합세트

const students = [
  { name: '김철수', gender: '남', height: 170, weight: 65, hobby: '축구' },
  { name: '이영희', gender: '여', height: 160, weight: 50, hobby: '독서' },
  { name: '박지민', gender: '여', height: 165, weight: 55, hobby: '영화감상' },
  { name: '최영수', gender: '남', height: 180, weight: 75, hobby: '등산' },
  { name: '김민지', gender: '여', height: 158, weight: 48, hobby: '요리' }
];

// 1-1. 모든 학생들의 이름을 콘솔에 출력해보세요.
{
  students.forEach(ele => {
    console.log(ele.name);
  });
}
// 1-2. 모든 학생들의 키와 몸무게를 콘솔에 출력해보세요.
{
  students.forEach(ele => {
    console.log(`키 : ${ele.height}, 몸무게 : ${ele.weight}`);
  });
}
// 2-1. 모든 학생들의 이름만 모은 새로운 배열을 만드세요.
{
  const stdNames = students.map(ele => ele.name);
  console.log(stdNames);
}
// 2-2. 모든 학생들의 키-몸무게를 이용해 BMI 지수를 계산한 새로운 배열을 만드세요. (BMI = 몸무게(kg) / 키(m)의 제곱)
{
  const stdBMI = students.map(ele => ele.weight / (ele.height * ele.height));
  console.log(stdBMI);
}
// 3-1. 키가 170cm 이상인 학생들만 모은 새로운 배열을 만드세요.
{
  console.log(students.filter(ele => ele.height >= 170).map(ele => ele.name));
}
// 3-2. 취미가 '독서'인 학생들만 모은 새로운 배열을 만드세요.
{
  console.log(students.filter(ele => ele.hobby === '독서').map(ele => ele.name));
}
// 4-1. 취미가 '축구'인 학생이 한 명이라도 있는지 확인하세요.
{
  console.log(students.some(ele => ele.hobby === '축구'));
}
// 4-2. 몸무게가 80kg 이상인 학생이 한 명이라도 있는지 확인하세요.
{
  console.log(students.some(ele => ele.weight >= 80));
}
// 5-1. 모든 학생의 키가 150cm 이상인지 확인하세요.
{
  console.log(students.every(ele => ele.height >= 150));
}
// 5-2. 모든 학생의 몸무게가 50kg 이상인지 확인하세요.
{
  console.log(students.every(ele => ele.weight >= 50));
}
// 6-1. 모든 학생의 키의 합을 구하세요.
{
  console.log(
    students.reduce((acc, curr) => { // accumulator, currentValue
      // console.log(ele.height);
      return acc + curr.height;
    }, 0)
  );
}
// 6-2. 모든 학생의 몸무게의 평균을 구하세요.
{
  console.log(
    students.reduce((acc, curr, idx, arr) => { // accumulator, currentValue
      acc = acc + curr.weight;
      if (idx === arr.length - 1) {
        return acc / arr.length;
      } else {
        return acc;
      }
    }, 0)
  );
}
// 7-1. 첫 번째로 '등산'이 취미인 학생을 찾으세요.
{
  console.log(students.find(ele => ele.hobby === '등산'));
}
// 7-2. 첫 번째로 몸무게가 60kg 이하인 학생을 찾으세요.
{
  console.log(students.find(ele => ele.weight <= 60));
}