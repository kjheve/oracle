{
  const x = 10;
  const y = 20;

  const z = add(x, y);
  console.log(z);

  function add(x, y) {
    return x + y;
  }
}

console.log('--------------------');
// 함수 표현식에 함수 할당 받기
// case 1)
{
  const z = function(x, y) {
    return x + y;
  };
  
  // console.log(z(10, 20));
  // console.log(add(10, 20));

  console.log(add(z(10, 20), 30));
  
  function add(x, y) {
    return x + y;
  }
}

// case 2)
{
  const z = function(x, y) {
    return x + y;
  };

  console.log(add(z, 30));
  
  function add(x, y) {
    return x(10, 20) + y;
  }
}

