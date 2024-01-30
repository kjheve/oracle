// 자료형
let x = 10;
console.log(typeof(x)); // number

let y = 3.14;
console.log(typeof(y)); // number

let myname = '홍길동'; // ("""), ('') 동일
console.log(typeof(myname)); // string

let flag = true; // or false
console.log(typeof(flag)); // boolean

// 불리언(boolean)
// true, false 이외 아래 값도 암묵적으로 boolean값으로 표기됨
// falsy : 거짓으로 여겨지는 값
// 요소가 없는거 ex) 0, "", [], {}, undefined, null, NaN
flag = 0;
console.log( flag ? '참' : '거짓');
flag = "";
console.log( flag ? '참' : '거짓');
//truety : 참으로 여겨지는 값
// ex) 0이 아닌 숫자, "ㅎ"(문자열에 값이 있는거),
//     요소가 있는 배열, 속성이 있는 객체
flag = "1";
console.log( flag ? '참' : '거짓');
flag = "ㅋ";
console.log( flag ? '참' : '거짓');


// undefined : 변수 선언후 초기화 하지 않은 상태
let z;
console.log(typeof(z)); // undefined


// null : 값이 없음을 명시적으로 표현
let nz = null;
console.log(typeof(nz)); // object



