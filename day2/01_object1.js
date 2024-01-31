// 자바 스크립트에서 객체 만들기

// 1) class 문법 사용
{
  class Person {
    // 생성자 메소드
    constructor(name, age) {
      this.name = name;
      this.age = age;
    }

    // 인스턴스 메소드
    smile() {
      console.log(`${this.name}이 웃다`);
    }
    eat() {
      console.log(`${this.age}살 ${this.name}이 먹다`);
    }
  }

  const person = new Person('홍길동', 30);
  person.smile();
  person.eat();
}

// 2) 생성자 함수 사용 : 객체를 만들기 위한 함수
{
  function Person(name, age) {
    // 속성
    this.name = name;
    this.age = age;

    // 인스턴스 메소드
    this.smile = function() {
      console.log(`${this.name}이 웃다`);
    }
    this.eat = function() {
      console.log(`${this.age}살 ${this.name}이 먹다`);
    }
  }

  const person = new Person('홍길동', 30);
  person.smile();
  person.eat();
}

// 3) 객체 리터럴 : 1회성 객체 만들기

{
  // const person = {}; // 빈 객체
  const person = {
    name : '홍길동',
    age : 30,
    smile() {
      console.log('웃다');
    },
    eat() {
      console.log('먹다');
    }
  }
  // console.log(typeof(person));
  console.log(person.name, person.age);
  person.smile();
  person.eat();

  const person2 = {
    name : '홍길순',
    age : 20,
    smile() {
      console.log('웃다');
    },
    eat() {
      console.log('먹다');
    }
  }

  console.log(person2.name, person2.age);
  person2.smile();
  person2.eat();
}