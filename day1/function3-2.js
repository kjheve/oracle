// 2) 함수를 매개값으로 받을 수 있다.

{
  const f1 = function (arr, f) {
    for (let i = 0; i < arr.length; i++) {
      console.log(f(arr[i]));
    }
  };

  const f2 = function (x) {
    return x * 2;
  };

  const arr = [1,2,3];

  f3(arr, f1, f2);

  function f3(arr, f1, f2){
    f1(arr,f2);
  }
}