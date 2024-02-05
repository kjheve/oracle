// ★선택요소 변수로 받기
const $formula = document.getElementById('formula'); // 계산결과 필드
const $btns = document.querySelectorAll('.btn'); // btn(버튼) 전부 선택
const $allClear = document.getElementById('all-clear'); // AC 버튼
const $result = document.getElementById('result'); // = 버튼
const $wrap = document.querySelector('.wrap'); // $btns를 감싸고있는 .wrap 태그

// console.log(Object.prototype.toString.call($btns));
// 2. ★$btns nodeList 목록들을 click 했을 때 $formula에 값 추가
$btns.forEach(ele => ele.addEventListener('click', evt => {
    // console.log(evt);
    // btns의 값이 'AC' 그리고 '='이 아닐 때
    if (evt.target.textContent !== 'AC' && evt.target.outerText !== '=') {
      $formula.value += evt.target.textContent; // $formula.value = $formula.value + evt.target.textContent
      $formula.style.color = 'inherit';
    }
    // 계산필드 자릿수 25초과시 '자리수 초과' 멘트 출력
    if ($formula.value.length > 25) {
      $formula.value = '자리수 초과';
      $formula.style.color = 'red';
      // 자리수 초과시 AC버튼 빼고 클릭 안되게
      $btns.forEach(ele => {
        if (ele.target != 'AC' && ele.id !== 'all-clear') {
          ele.classList.add('err');
        }
      });
    }
  }));

// 5. ★AC(all clear)버튼을 클릭하면 계산결과 필드 초기화
$allClear.addEventListener('click', evt => {
  // 계산필드 초기화
  $formula.value = '';
  // 에러시 color 속성이 바뀌었던걸 .wrap의 color 속성으로 되돌림
  $formula.style.color = 'inherit';
  // 에러시 버튼 비활성화 했던거 다시 활성화
  $btns.forEach(ele => {
    ele.classList.remove('err');
  });
});

// 3. ★'='클릭시 결과필드에 계산결과 나타냄
$result.addEventListener('click', evt => {
  try { // 예외처리
    // case 1) ▶ eval()함수 이용
    // if ($formula.value) {
    //   $formula.value = eval($formula.value); // 1. window.eval()함수로 계산
    //   $formula.style.color = 'blue'; // 결과값 파란색으로 변경
    // }
    // case 2) ▶ Function 생성자 이용
    if ($formula.value) {
      // Function 생성자를 사용하여 문자열을 함수로 변환하고 실행
      var calculate = new Function('return ' + $formula.value);
      $formula.value = calculate();
      $formula.style.color = 'blue';
    }
  } catch(error) { // 4. 예외시 문구 출력
    $formula.value = 'Error'; // 계산결과 필드에 에러 문구 출력
    $formula.style.color = 'red'; // 폰트색상 red
    // AC버튼 빼고 버튼 비활성화
    $btns.forEach(ele => {
      if (ele.target != 'AC' && ele.id !== 'all-clear') {
        ele.classList.add('err');
      }
    });
  }
});

// 6. ★각 버튼 클릭한 색상만 배경 색상이 노란색으로 변경
$wrap.addEventListener('click', evt => { // $wrap 영역 중
  $btns.forEach(ele => {
    if (evt.target === ele) { // 버튼을 누른거면 add('on')
      ele.classList.add('on'); // 해당 btn 태그 속성 class이름 on 추가
    } else {
      ele.classList.remove('on'); // wrap 영역에서 click 안된것들은 class이름 on 제거
    }
  });
});