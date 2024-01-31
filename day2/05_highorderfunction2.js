// 일반 for문
{
  const arr = [1, 2, 3];

  // case 1) for로 배열 순회와 그리고 처리할 방법 생각
  for (let i = 0; i < arr.length; i++) {
    console.log(arr[i] * 2);
  }

  console.log('----------------')

  // case 2) forEach에서 순회하니 처리할 방법만 생각
  arr.forEach(ele => console.log(ele*2));

  arr.forEach((ele, idx, arr) => console.log(ele*2));
  //         요소,인덱스번호,배열


  console.log('----------------')

  // case 2-2)
  const f = (ele, idx, arr) => console.log(ele*2);
  const f2 = function (ele, idx, arr) {
    console.log(ele*2)
  };
  function f3(ele, idx, arr) {
    console.log(ele*2)
  }


  arr.forEach(f);
  arr.forEach(f2);
  arr.forEach(f3);

  arr.forEach((ele, idx, arr) => console.log(ele*2)); // f자리 대신 f가 옴

  arr.forEach(function (ele, idx, arr) { // f2 대신 f2가 옴
    console.log(ele*2)
  });

  arr.forEach(f3);
}



