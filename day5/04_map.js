// Array.prototype.map() 

{
  const arr = [1, 2, 3];

  const result = arr.map((ele, idx, arr) => ele);
  // const result2 = arr.map((ele, idx, arr) => {
  //   return ele;
  // });
  // forEach와 다르게 반환을 한다.

  console.log(result);
}

{

  const persons = [
    {name : '홍길동', age : 30},
    {name : '홍길순', age : 20},
    {name : '홍길남', age : 40}
  ];

  // persons.map((ele, idx, arr) => {
  //   console.log(ele, idx, arr);
  //   // console.log(ele);
  // });

  // const result = persons.map((ele, idx, arr) => {
  //   return ele.age;
  // });
  
  const ageOfPerson = persons.map(ele => ele.age);
  console.log(ageOfPerson);
  const nameOfPerson = persons.map(ele => ele.name);
  console.log(nameOfPerson);


}