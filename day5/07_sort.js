// Array.prototype.sort() 
// 유니코드 기준으로 정렬 됨




{

  let str = '0'; // 숫자 0의 유니코드 값 48
  let str2 = '9'; // 숫자 0의 유니코드값 57
  let str3 = 'a'; // 문자 a의 유니코드값 97
  let str4 = 'A'; // 문자 a의 유니코드값 65
  console.log(str.charCodeAt(0));
  console.log(str2.charCodeAt(0));
  console.log(str3.charCodeAt(0));
  console.log(str4.charCodeAt(0));

  // 배열로 유니코드 확인하기
  const ch = ['0', '9', 'a', 'z', 'A', 'Z', '가', 'ㅎ'];
  ch.forEach(ele => console.log(ele.charCodeAt(0)));
  console.log(ch.sort());

  // 정렬방법을 제공하지 않으면 기본적으로 유니코드 크기로 정렬함
  const arr = [3, 1, 11, 2];
  console.log(arr.sort()); // [1, 11, 2, 3]으로 정렬됨


  const sortArray = arr.sort(function (a, b) {
    return a - b; // 오름차순
  });
  console.log(sortArray);

  // 화살표함수 사용
  const sortArray2 = arr.sort((a, b) => a - b); // 오름차순
  console.log(sortArray2);
  const sortArray3 = arr.sort((a, b) => b - a); // 내림차순
  console.log(sortArray3);






}




{
  
  const persons = [
    { name: '홍길동', age: 30, gender: '남' },
    { name: '홍길순', age: 20, gender: '여' },
    { name: '홍길선', age: 30, gender: '여' },
    { name: '홍길남', age: 40, gender: '남' }
  ];

 

 // 정렬 전
 console.log(persons);

 // 나이 오름차순으로 배열 요소 정렬
 persons.sort((a, b) => {
  return a.age - b.age;
 });

 // 정렬 후
 console.log(persons);

 // 나이 내림차순으로 배열 요소 정렬
 persons.sort((a, b) => b.age - a.age );

 // 정렬 후
 console.log(persons);

}