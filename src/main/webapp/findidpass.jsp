<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ include file="include/header.jsp" %>
		<div class="row">
			<div class="col-12">
				<div class="bg-white rg">
					<h1 class="text-center py-5">아이디 찾기</h1>
					<p class="text-center mb-5">아이디를 찾으시려면 이메일 주소를 입력하세요.</p>
					<form name="findidform" id="findidform" action="findidok" method="post">
						<ul class="registerul">
							<li class="d-flex py-4">
								<label for="usrid" class="col-2 text-right">이메일</label>
								<div class="col-4">
									<input type="text" name="useremail" id="useremail" placeholder="이메일"
										class="form-control">
								</div>
							</li>
							<li class="text-center pt-1 pb-5">
								<button type="reset" class="btn btn-warning py-2 px-5 mx-2">취소</button>
								<button type="submit" class="btn btn-success py-2 px-5 mx-2">전송</button>
							</li>
						</ul>
					</form>
					<h1 class="text-center py-5">비밀번호 찾기</h1>
					<p class="text-center mb-5">비밀번호를 찾으시려면 아이디와 이메일 주소를 입력하세요.</p>
					<form name="findpwdform" id="findpwdform" action="findpwdok" method="post">
						<ul class="registerul">
							<li class="d-flex py-4">
								<label for="usrid2" class="col-2 text-right">아이디</label>
								<div class="col-4">
									<input type="text" name="usrid2" id="usrid2" placeholder="아이디" class="form-control">
								</div>
							</li>
							<li class="d-flex py-4">
								<label for="useremail" class="col-2 text-right">이메일</label>
								<div class="col-4">
									<input type="text" name="useremail" id="useremail" placeholder="이메일"
										class="form-control">
								</div>
							</li>
							<li class="text-center pt-1 pb-5">
								<button type="reset" class="btn btn-warning py-2 px-5 mx-2">취소</button>
								<button type="submit" class="btn btn-success py-2 px-5 mx-2">전송</button>
							</li>
						</ul>
					</form>
				</div>
			</div>
		</div>
		</div>
		<%@ include file="include/footer.jsp" %>

			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
				function execDaumPostcode() {
					new daum.Postcode({
						oncomplete: function (data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== '' && data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("extraAddress").value = extraAddr;

							} else {
								document.getElementById("extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postcode').value = data.zonecode;
							document.getElementById("address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress").focus();
						}
					}).open();
				}
			</script>