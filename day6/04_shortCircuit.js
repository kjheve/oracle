{
  console.log(true || true);    // true
  console.log(true || false);   // true
  console.log(false || true);   // true
  console.log(false || false);  // false
}
{
  console.log(false || 1);      // 1
  console.log(true || 1);       // true
  console.log(false && 1);      // false
  console.log(true && 1);       // 1
}
{
  console.log(false || 0);      // 0
  console.log(true || 0);       // true
  console.log(false && 0);      // false
  console.log(true && 0);       // 0
}
{
  const obj = {'name' : '홍길동', 'age' : 30};
  console.log(obj['name'] || 0); // 홍길동
  console.log(obj['gender'] || 0); // 0

  console.log(obj['age'] && obj['age']++); // 30  // &&면 뒤에것도 평가를 하고 ||했을 때 앞에께 참이면 뒤에꺼는 평가를 안함
  console.log(obj['age']);      // 31
  console.log(obj['age'] || 0); // 31
}