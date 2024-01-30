// Array.prototype.splice()

// splice() 

// 인수가 1개인 경우 splice(시작) 
// 시작 인덱스부터 끝까지 요소를 반환하고 원래 배열의 요소를 제거
{
  const arr = [1, 2, 3, 4, 5];

  arr.splice(2);
  console.log(arr);
}

// 인수가 2개인 경우 splice(시작, x) 
// 시작 인덱스부터, x개 제거
{ 
  const arr = [1, 2, 3, 4, 5];
  arr.splice(2, 2);
  console.log(arr);
}

// 인수가 3개인 경우 splice(시작, x, y) 
// 시작 인덱스부터, x개 제거하고 제거된 위치에 y 삽입
{ 
  const arr = [1, 2, 3, 4, 5];
  arr.splice(2, 2, 10);
  console.log(arr);
}

// 인수가 4개인 경우 splice(시작, x, y, z) 
// 시작 인덱스부터, x개 제거하고 제거된 위치에 y, z 삽입
{ 
  const arr = [1, 2, 3, 4, 5];
  arr.splice(2, 2, 10, 11);
  console.log(arr);
}
