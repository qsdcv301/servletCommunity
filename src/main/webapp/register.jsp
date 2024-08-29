<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ include file="include/header.jsp" %>
		<div class="row">
			<div class="col-12">
				<div class="bg-white">
					<h1 class="text-center py-5">회원가입</h1>
					<p class="text-center mb-5">환영 합니다</p>
					<form action="registerok" name="registerform" id="registerform" method="post">
						<ul class="registerul">
							<li class="d-flex py-4"><label class="col-2 text-right">아이디</label>
								<div class="col-4">
									<input type="text" class="form-control" name="usrid" id="userid"
										placeholder="아이디" />
								</div>
							</li>
							<li class="d-flex py-4"><label class="col-2 text-right">비밀번호</label>
								<div class="col-4">
									<input type="password" class="form-control" name="usrpass" id="userpass"
										placeholder="비밀번호" />
								</div>
							</li>
							<li class="d-flex py-4"><label class="col-2 text-right">비밀번호 확인</label>
								<div class="col-4">
									<input type="password" class="form-control" name="reusrpass" id="reuserpass"
										placeholder="비밀번호 확인" />
								</div>
							</li>
							<li class="d-flex py-4"><label class="col-2 text-right">이름</label>
								<div class="col-4">
									<input type="text" class="form-control" name="username" id="username"
										placeholder="이름" />
								</div>
							</li>
							<li class="d-flex py-4">
								<label for="" class="col-2 text-right">이메일</label>
								<div class="col-3">
									<input type="text" id="emailid" class="form-control">
								</div>
								<span>@</span>
								<div class="col-3">
									<select id="emailDomain" class="form-control emailgroup">
										<option value="">도메인 선택</option>
										<option value="naver.com" selected>naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="daum.net">daum.net</option>
										<option value="act">직접입력</option>
									</select>
									<input type="hidden" name="email" id="email">
								</div>
								<div class="col-3">
									<input type="text" id="emailDomain2" class="form-control emailgroup">
								</div>
							</li>
							<li class="d-flex py-4">
								<label for="" class="col-2 text-right">전화번호</label>
								<div class="col-2">
									<input type="text" id="tel1" class="form-control">
								</div>
								-
								<div class="col-2">
									<input type="text" id="tel2" class="form-control">
								</div>
								-
								<div class="col-2">
									<input type="text" id="tel3" class="form-control">
								</div>
								<input type="hidden" name="tel" id="tel" />
							</li>
							<li class="d-flex py-4"><label class="col-2 text-right">우편번호</label>
								<div class="col-10 row mb-4">
									<div class="col-3 mb-3">
										<input type="text" id="userpost" class="form-control" name="userpost"
											placeholder="우편번호" readonly>
									</div>
									<div class="col-3">
										<button type="button" onclick="execDaumPostcode()"
											class="btn btn-secondary">우편번호</button>
									</div>
									<div class="col-6 mb-3"></div>
									<div class="col-12 mb-3">
										<input type="text" id="addr1" class="form-control" name="useraddr1"
											placeholder="주소" readonly>
									</div>
									<div class="col-12 mb-3">
										<input type="text" id="addr2" class="form-control" name="useraddr2"
											placeholder="상세주소">
									</div>
									<div class="col-6 mb-3">
										<input type="text" id="addrexc" class="form-control" name="useraddrexc"
											placeholder="참고항목">
									</div>
								</div>
							</li>
							<li class="text-center pt-1 pb-5">
								<button type="reset" class="reset btn btn-warning py-2 px-5 mx-2">취소</button>
								<button type="submit" class="submit btn btn-success py-2 px-5 mx-2">회원가입</button>
							</li>
						</ul>
					</form>
				</div>
			</div>
		</div>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
							document.getElementById("addrexc").value = extraAddr;

						} else {
							document.getElementById("addrexc").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('userpost').value = data.zonecode;
						document.getElementById("addr1").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("addr2").focus();
					}
				}).open();
			}
		</script>
		<%@ include file="include/footer.jsp" %>