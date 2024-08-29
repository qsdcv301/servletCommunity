$(function () {
    $("#rid").change(function () {
        if ($(this).is(":checked")) {
            alert("게임방, 관공서등 공공기관에서는 사용하지 마세요.");
        }
    });

    const userIdFromCookie = getCookie('userid');
    if (userIdFromCookie) {
        $("#userid").val(userIdFromCookie);
    }


    /*** 회원가입 스크립트 **/
    $("#emailDomain2").hide();
    $("#emailDomain").change(function () {
        if ($(this).val() === 'act') {
            $("#emailDomain2").show().val("");
            $("#emailDomain2").focus();
            $("#emailDomain").attr("readonly", true);
        } else {
            $("#emailDomain2").hide();
            $("#emailDomain").attr("readonly", false);
        }
    });

    $.validator.setDefaults({
        onkeyup: false,
        onclick: false,
        onfocusout: false,
        showErrors: function (errorMap, errorList) {
            if (this.numberOfInvalids()) {
                alert(errorList[0].message);
            }
        }
    });

    $('#loginform').validate({
        debug: false,
        rules: {
            userid: "required",
            userpass: "required"
        },
        messages: {
            userid: "아이디를 입력하세요.",
            userpass: "비밀번호를 입력하세요."
        }
    });

    $('#registerform').validate({
        rules: {
            usrid: {
                required: true,
                minlength: 3,
                maxlength: 9
            },
            usrpass: { required: true, minlength: 5 },
            username: { required: true },

            reuserpass: { required: true, equalTo: "#usrpass" },
            emailid: { required: true },
            emailDomain: {
                require_from_group: [1, ".emailgroup"]
            },
            emailDomain2: {
                require_from_group: [1, ".emailgroup"]
            }

        },
        messages: {
            usrid: {
                required: '필수 입력 항목입니다.',
                minlength: '{0}글자 이상 입력하세요.',
                maxlength: '아이디가 너무 길어요. {0}자 이하로 입력하세요.'
            },
            usrpass: '비밀번호를 입력하세요.',
            username: '이름을 입력하세요.',
            reuserpass: '비밀번호가 맞지 않습니다.',
            emailid: '이메일을 입력하세요.',
            emailDomain: '이메일을 입력하세요.',
            emailDomain2: '이메일을 입력하세요.'
        },
        submitHandler: function (form) {
            const email = $('#emailid').val() + "@" + ($("#emailDomain").val() === 'act' ?
                $('#emailDomain2').val() :
                $('#emailDomain').val());
            $("#email").val(email);
            const tel = $("#tel1").val() + "-" + $("#tel2").val() + "-" + $("#tel3").val();
            $("#tel").val(tel);

            form.submit();
        }
    });

});

function setCookie(name, value, exp) {
    const date = new Date();
    date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000); // 쿠키 유효 기간 설정
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}

function getCookie(name) {
    const value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value ? value[2] : null;
}

function delCookie(name) {
    document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
}