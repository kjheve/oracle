{
  let x = 10
  let y = 'a';

  let result = x / y;
  console.log(result);
}

{
  const arr = [1, 2, 3];
  console.log('--시작');
  console.log(arr[3]);
  console.log('--끝');
}

// {
//   console.log('--시작');
//   let x = y; // error 발생
//   console.log('--끝');
// }

{
  console.log('--시작');
  try {
    // 예외가 예상되는 코드
    let x = y; // error 발생
  } catch (err) { // 에러가 발생되는 객체를 생성해서 전달함
    // 예외가 발생됐을 때
    console.log(err); // 객체 생성된거 출력해봄
    console.log(typeof err); // 타입 정보 object
    console.log(Object.prototype.toString.call(err)); // 타입 상세 정보 [object Error]
    console.log(err.message); // y is not defined
    console.log(err.cause); // undefined
    console.log(err.toString()); // ReferenceError: y is not defined
  } finally {
    // 예외 유무 상관없이 실행될 코드
    console.log('나는 에러유무 없이 실행한다!');
  }
  
  console.log('--끝'); // 실행됨!
}