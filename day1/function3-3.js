// 3) 함수를 반환값으로 전달할 수 있다.

// Q----- ) 배열을 순회하는 기능

{
  function literate1X(arr) {
    for (let i = 0; i < arr.length; i++) {
      console.log(arr[i] * 1);
    }
  }

  function literate2X(arr) {
    for (let i = 0; i < arr.length; i++) {
      console.log(arr[i] * 2);
    }
  }

  function literate3X(arr) {
    for (let i = 0; i < arr.length; i++) {
      console.log(arr[i] * 3);
    }
  }
  // --------배열을 배수로 출력하는 함수를 각각 만들어야하는 상황----


  const arr = [1, 2, 3];

  // case 1)
  literate(arr, 1)();
  // or
  const x1 = literate(arr, 1);
  const x2 = literate(arr, 2);
  const x3 = literate(arr, 3);
  x1();
  x2();
  x3();


  // function literate(배열, 배수) {return function()}
  function literate(arr, x) {
    return function () {
      for (let i = 0; i < arr.length; i++) {
        console.log(arr[i] * x);
      }
    }
  }



  // --------------------------------------------------------

 
  // case 2)
  const a = literate(arr);
  a(1);
  a(2);
  a(3);
  // or
  literate(arr)(1);


  // function literate(배열) {return function(배수)}
  function literate(arr) {
    return function (x) {
      for (let i = 0; i < arr.length; i++) {
        console.log(arr[i] * x);
      }
    }
  }


  // -------------------------------------------

}