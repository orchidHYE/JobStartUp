<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cPath" value="<%=request.getContextPath() %>"/>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="${cPath}/css/resume/form.css" type="text/css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Start Up</title>
</head>
<body>
<header>
    <%@ include file="../../layout/layoutNav.jsp"%>
    <div  id="top" data-wow-duration="1s" data-wow-delay="0.5s">
        <div class="header-text" data-wow-duration="1s" data-wow-delay="1s"></div>
    </div>
</header>
<main>
    <section class="py-5">
        <div class="container px-5 my-5">
            <div class="row gx-5 justify-content-center custom-padding">
                <div class="col-lg-10">
                    <form action="${cPath}/seeker/resumeWrite" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="member_no" id="member_no" value="13"/>
                        <!-- 제목 input -->
                        <div class="title-container">
                            <div class="form-floating mb-3">
                                <input type="text" name="resume_title" id="resume_title" class="form-control" value="${member.member_name}의 이력서" style="color: #a8a8a8" onfocus="titleClick(this)"/>
                                <label for="resume_title"></label>
                                <div style="font-size: 13px; color: #a8a8a8; margin: 5px 0px 0px 10px;">* 제목 미기재시 '${member.member_name}의 이력서'로 자동 저장됩니다.</div>
                            </div>
                        </div>
                        <!-- 프로필사진 input -->
                        <div class="item-container">
                            <div class="mb-3">
                                <label for="profileOrgNameFile" class="form-label"></label>
                                <div class="row">
                                    <div class="col-md-2">
                                        <!-- 이미지와 파일 입력 필드 -->
                                        <div class="row" style="position: relative;">
                                            <div class="col-md-12">
                                                <div style="position: relative;">
                                                    <img id="profileImage" src="/img/default_profile.jpg" style="width: 137px; height: 176px;" class="mb-3" onclick="document.getElementById('profileOrgNameFile').click();" />
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <input type="file" name="profileOrgNameFile" id="profileOrgNameFile" class="form-control" accept="image/*" onchange="displayProfileImage(this)" style="display: none;" />
                                            </div>
                                            <div class="col-md-12">
                                                <span id="imageWarningText" style="color: red;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-10" style="padding: 10px;">
                                        <div class="row">
                                            <div class="row mt-1">
                                                <div class="col-md-4">
                                                    <!-- 이름 -->
                                                    <div class="form-floating mb-3">
                                                        <input type="text" name="name" id="name" class="form-control" value="${member.member_name}"/>
                                                        <label for="name" class="form-label">이름</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <!-- 생년월일 -->
                                                    <div class="form-floating mb-3">
                                                        <input type="text" name="dob" id="dob" class="form-control" value="${member.member_birth}"/>
                                                        <label for="dob" class="form-label">생년월일</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <!-- 이메일 -->
                                                    <div class="form-floating mb-3">
                                                        <input type="text" name="email" id="email" class="form-control" value="${member.member_email}"/>
                                                        <label for="email" class="form-label">이메일</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-4">
                                                <div class="col-md-4">
                                                    <!-- 성별 -->
                                                    <div class="form-floating mb-3">
                                                        <c:choose>
                                                            <c:when test="${member.member_sex eq 'female'}">
                                                                <c:set var="genderLabel" value="여성" />
                                                            </c:when>
                                                            <c:when test="${member.member_sex eq 'male'}">
                                                                <c:set var="genderLabel" value="남성" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="genderLabel" value="기타" />
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <input type="text" name="gender" id="gender" class="form-control" value="${member.member_sex}"/>
                                                        <label for="gender" class="form-label">성별</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <!-- 휴대폰번호 -->
                                                    <div class="form-floating mb-3">
                                                        <input type="text" name="phone" id="phone" class="form-control" value="${member.member_hp}"/>
                                                        <label for="phone" class="form-label">휴대폰번호</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="mb-3" style="position: relative;">
                                                        <div class="mb-3 grid text-center form-floating" id="addressDiv">
                                                            <input type="text" name="petAddress" id="sample6_address" class="form-control float-start" value="${member.member_loc}">
                                                            <label for="sample6_address">주소</label>
                                                        </div>
                                                        <div class="mb-1 grid text-center form-floating" id="detailAddressDiv">
                                                            <input type="hidden" name="petAddress" id="sample6_detailAddress" class="form-control float-start">
                                                            <input type="hidden" id="daumPostcodeButton" class="btn btn-light" onclick="sample6_execDaumPostcode()" />
                                                            <img src="${cPath}/img/glasses.png" alt="" style="width: 20px; cursor: pointer; position: absolute; top: -55px; right: 15px;" onclick="document.getElementById('daumPostcodeButton').click();" />
                                                        </div>
                                                        <input type="hidden" name="petAddressEct" id="sample6_postcode" placeholder="우편번호">
                                                        <input type="hidden" name="petAddressEct" id="sample6_extraAddress" placeholder="참고항목">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item-container">
                            <!-- 학력 -->
                            <div class="form-floating mb-3">
                                <input type="text" name="" id="education" class="form-control"/>
                                <label for="education">최종학력</label>
                            </div>


                            <!-- 희망 연봉 -->
                            <div class="form-floating mb-3">
                                <input type="text" name="resume_money" id="resume_money" class="form-control"/>
                                <label for="resume_money">희망연봉</label>
                            </div>

                            <!-- 업무능력 input -->
                            <div class="form-floating mb-3">
                                <input type="text" name="resume_skill" id="resume_skill" class="form-control"/>
                                <label for="resume_skill">업무능력</label>
                            </div>

                            <%-- 희망 근무지역 --%>
                            <div id="locationContainer">
                                <div class="locationBlock">
                                    <div class="col-md-12">
                                        <div class="row form-floating mb-3">
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <select id="upperLoc" name="upperLoc" class="form-control" onchange="loadLowerLoc()">
                                                        <option value="">지역 분류를 선택해주세요.</option>
                                                        <c:forEach items="${upperLoc}" var="upLoc">
                                                            <option value="${upLoc.detail_code_num}">${upLoc.detail_name}</option>
                                                        </c:forEach>
                                                    </select>

                                                    <label for="upperLoc">희망근무지역</label>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <select id="lowerLoc" name="lowerLoc" class="form-control">
                                                        <option value=""></option>
                                                        <c:forEach items="${lowerLoc}" var="loLoc">
                                                            <option value="${loLoc.detail_code_num}" data-name="${loLoc.detail_name}">${loLoc.detail_name}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <label for="upperLoc"></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="border: none;">
                                        <div class="col-sm-0"></div>
                                        <div class="col-sm-12">
                                            <span id="selectionResult"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 경력 섹션 -->
                        <div class="item-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                                <p class="fs-6 fw-bold text-dark mb-0 custom-text-style">경력</p>
                                <button class="addFieldButton border-0 fs-6 fw-bolder text-primary mb-0 custom-text-style" data-section="career" data-basename="careerDTOList" type="button" style="background-color: transparent;">+ 추가</button>
                            </div>
                            <div id="careerContainer">
                                <div class="careerBlock">
                                    <div class="row g-2 form-floating ">
                                        <div class="form-floating mb-3 col-sm-4">
                                            <input type="text" name="careerDTOList[0].career_company" id="career_company0" class="form-control custom-underline"/>
                                            <label for="career_company0">회사명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm-4">
                                            <input type="text" name="careerDTOList[0].career_date" id="career_date0" class="form-control"/>
                                            <label for="career_date0">경력기간</label>
                                        </div>
                                        <div class="col-sm-2 ">
                                            <div class="form-floating mb-3 col-sm">
                                                <select id="business_type_code_up0" name="business_type_code_up" onchange="loadBusinessTypeCodeUp(0)" required>
                                                    <option value="">선택</option>
                                                    <c:forEach items="${upperJob}" var="upJob">
                                                        <option value="${upJob.detail_code_num}">${upJob.detail_name}</option>
                                                    </c:forEach>
                                                </select>
                                                <label for="business_type_code_up0">경력직무</label>
                                            </div>
                                        </div>
                                        <div class="col-2 form-floating mb-3">
                                            <div class="col-sm">
                                                <select id="business_type_code0" name="careerDTOList[0].business_type" required>
                                                    <option value="">선택</option>
                                                    <c:forEach items="${lowerJob}" var="loJob">
                                                        <option value="${loJob.detail_code_num}">${loJob.detail_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <textarea name="careerDTOList[0].career_work" id="career_work0" class="form-control" style="width: 942px; height: 137px"></textarea>
                                        <label for="career_work0">담당업무</label>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- 자격증 섹션 -->
                        <div class="item-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                                <p class="fs-6 fw-bold text-dark mb-0 custom-text-style">자격증</p>
                                <button class="addFieldButton border-0 fs-6 fw-bolder text-primary mb-0 custom-text-style" data-section="certificate" data-basename="certificateDTOList" type="button" style="background-color: transparent;">+ 추가</button>
                            </div>
                            <div id="certificateContainer">
                                <div class="certificateBlock">
                                    <div class="row g-2">
                                        <div class="form-floating mb-3 col-sm-6">
                                            <input type="text" name="certificateDTOList[0].cer_name" id="cer_name0" class="form-control"/>
                                            <label for="cer_name0">자격증명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <input type="text" name="certificateDTOList[0].cer_issuer" id="cer_issuer0" class="form-control"/>
                                            <label for="cer_issuer0">발급처</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <input type="date" name="certificateDTOList[0].cer_date" id="cer_date0" class="form-control"/>
                                            <label for="cer_date0">취득일자</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- 언어 섹션 -->
                        <div class="item-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                                <p class="fs-6 fw-bold text-dark custom-text-style">언어</p>
                                <button class="addFieldButton border-0 fs-6 fw-bolder text-primary custom-text-style" data-section="language" data-basename="languageDTOList" type="button" style="background-color: transparent;">+ 추가</button>
                            </div>
                            <div id="languageContainer">
                                <div class="languageBlock">
                                    <div class="row g-2">
                                        <div class="form-floating mb-3 col-sm-6">
                                            <input type="text" name="languageDTOList[0].lang_name" id="lang_name0" class="form-control selectLevel"/>
                                            <label for="lang_name0">언어명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <select name="languageDTOList[0].lang_level" id="lang_level0" class="form-control">
                                                <option value="수준">수준</option>
                                                <option value="유창함">유창함</option>
                                                <option value="비즈니스 회화">비즈니스 회화</option>
                                                <option value="일상회화">일상회화</option>
                                            </select>
                                            <label for="lang_level0">회화능력</label>
                                        </div>
                                    </div>
                                    <%-- 어학 자격증 --%>
                                    <button class="addFieldButton border-0 fs-6 fw-bolder text-primary custom-text-style" data-section="langCer" data-basename="languageCertificateDTOList" type="button" style="background-color: transparent;">+ 추가</button>
                                    <div id="langCerContainer">
                                        <div class="langCerBlock">
                                            <div class="row g-3">
                                                <div class="form-floating mb-6 col-sm-6">
                                                    <input type="text" name="languageCertificateDTOList[0].lang_cer_exam" id="lang_cer_exam0" class="form-control"/>
                                                    <label for="lang_cer_exam0">어학 자격증명</label>
                                                </div>
                                                <div class="form-floating mb-3 col-sm">
                                                    <input type="text" name="languageCertificateDTOList[0].lang_cer_grade" id="lang_cer_grade0" class="form-control"/>
                                                    <label for="lang_cer_grade0">등급 및 점수</label>
                                                </div>
                                                <div class="form-floating mb-3 col-sm">
                                                    <input type="date" name="languageCertificateDTOList[0].lang_cer_date" id="lang_cer_date0" class="form-control"/>
                                                    <label for="lang_cer_date0">취득일자</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <!-- 첨부파일 및 URL -->
                        <div class="end-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between">
                                <p class="fs-6 fw-bold text-dark mb-5 custom-text-style">기타 첨부파일</p>
                            </div>
                            <div class="mb-3">
                                <label for="resumeOrgNameFile" class="form-label"></label>
                                <input type="file" name="resumeOrgNameFile" id="resumeOrgNameFile" class="form-control"/>
                            </div>
                            <div class="form-floating mb-5">
                                <input type="text" name="resume_url" id="resume_url" class="form-control"/>
                                <label for="resume_url">URL</label>
                            </div>
                        </div>

                        <div class="d-flex justify-content-center">
                            <button type="button" name="cancelBtn" id="cancelBtn" class="btn btn-primary btn-md mx-3" style="background-color:transparent; color:#0d6efd" >취소</button>
                            <input type="submit" name="submitBtn" id="submitBtn" value="등록" class="btn btn-primary btn-md" style="border: none;" >
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<%@ include file="../../layout/layoutFooter.jsp"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%--우편API--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    var genderInput = document.getElementById("gender");
    genderInput.value = "${genderLabel}";

    document.addEventListener("DOMContentLoaded", function () {
        const addButtons = document.getElementsByClassName("addFieldButton");
        Array.from(addButtons).forEach(button => {
            button.addEventListener("click", addField);
        });
        // const addButtons = document.querySelectorAll(".addFieldButton");
        // addButtons.forEach(button => {
        //     button.addEventListener("click", addField);
        // });

        function addField(event) {
            const section = event.currentTarget.getAttribute('data-section');
            console.log("section:", section);
            const baseName = event.currentTarget.getAttribute('data-basename');
            console.log("baseName:", baseName);
            const container = $("#" + section + "Container");
            console.log("container:", container);
            const count = container.find("." + section + "Block").length;
            console.log("count:", count);

            var nextIndex = 0;

            let newBlock = document.createElement("div");
            newBlock.className = section + "Block";

            // Depending on the section, adjust the innerHTML
            switch (section) {
                case "location":
                    newBlock.innerHTML =
                        '<div class="form-floating mb-3">' +
                        '<input type="text" name="' + baseName + '[' + count + '].loc_detail_code_num" id="loc_detail_code_num' + count + '" class="form-control"/>' +
                        '<label for="loc_detail_code_num' + count + '">희망근무지역 ' +  (count+1) + '</label>' +
                        '</div>';
                    break;
                case "career":
                    newBlock.innerHTML =
                        '<div class="row g-2">' +
                        '<div class="form-floating mb-3 col-sm-4">' +
                        '<input type="text" name="' + baseName + '[' + count + '].career_company" id="career_company' + count + '" class="form-control"/>' +
                        '<label for="career_company' + count + '">회사명' + (count + 1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm-4">' +
                        '<input type="text" name="' + baseName + '[' + count + '].career_date" id="career_date' + count + '" class="form-control"/>' +
                        '<label for="career_date' + count + '">경력기간' + (count + 1) + '</label>' +
                        '</div>' +
                        '<div class="col-sm-2 ">' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<select id="business_type_code_up' + count + '" name="business_type_code_up" onchange="loadBusinessTypeCodeUp(' + count + ')" required>' +
                        '<option value="">선택' +
                        '</option>' +
                        '<c:forEach items="${upperJob}" var="upJob">' +
                        '<option value="${upJob.detail_code_num}">${upJob.detail_name}' +
                        '</option>' +
                        '</c:forEach>' +
                        '</select>' +
                        '</div class="col-2 form-floating mb-3">' +
                        '<label for="business_type' + count + '">경력직무' + '</label>' +
                        '<div class="col-sm">' +
                        '<select id="business_type_code' + count + '" name="' + baseName + '[' + count + '].business_type" required>' +
                        '<option value="">선택' + '</option>' +
                        '<c:forEach items="${lowerJob}" var="loJob">' +
                        '<option value="${loJob.detail_code_num}">${loJob.detail_name}' + '</option>' +
                        '</c:forEach>' +
                        '</select>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="form-floating mb-3">' +
                        '<textarea name="' + baseName + '[' + count + '].career_work" id="career_work' + count + '" class="form-control" style="width: 942px; height: 137px">' + '</textarea>' +
                        '<label for="career_work' + count + '">담당업무' + (count + 1) + '</label>' +
                        '</div>' ;
                    break;
                case "certificate":
                    newBlock.innerHTML =
                        '<div class="row g-2">' +
                        '<div class="form-floating mb-3 col-sm-6">' +
                        '<input type="text" name="' + baseName + '[' + count + '].cer_name" id="cer_name' + count + '" class="form-control"/>' +
                        '<label for="cer_name' + count + '">자격증명' +  (count+1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<input type="text" name="' + baseName + '[' + count + '].cer_issuer" id="cer_issuer' + count + '" class="form-control"/>' +
                        '<label for="cer_issuer' + count + '">발급처' +  (count+1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<input type="date" name="' + baseName + '[' + count + '].cer_date" id="cer_date' + count + '" class="form-control"/>' +
                        '<label for="cer_date' + count + '">취득일자' +  (count+1) + '</label>' +
                        '</div>' +
                        '</div>';
                    break;
                case "language":
                    newBlock.innerHTML =
                        '<div class="row g-2">' +
                        '<div class="form-floating mb-3 col-sm-6">' +
                        '<input type="text" name="' + baseName + '[' + count + '].lang_name" id="lang_name' + count + '" class="form-control"/>' +
                        '<label for="lang_name' + count + '">언어명' +  (count+1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<select name="' + baseName + '[' + count + '].lang_level" id="lang_level' + count + '" class="form-control"/>' +
                        '<option value="수준">' + '수준'+
                        '</option>' +
                        '<option value="유창함">' + '유창함'+
                        '</option>' +
                        '<option value="비즈니스 회화"">' + '비즈니스 회화'+
                        '</option>' +
                        '<option value="일상회화">' + '일상회화'+
                        '</option>' +
                        '</select>' +
                        '<label for="lang_level' + count + '">회화능력' +  (count+1) + '</label>' +
                        '</div>' +
                        '</div>';
                    break;
                case "langCer":
                    newBlock.innerHTML =
                        '<div class="row g-3">' +
                        '<div class="form-floating mb-3 col-sm-6">' +
                        '<input type="text" name="' + baseName + '[' + count + '].lang_cer_exam" id="lang_cer_exam' + count + '" class="form-control"/>' +
                        '<label for="lang_cer_exam' + count + '">자격증명' +  (count+1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<input type="text" name="' + baseName + '[' + count + '].lang_cer_grade" id="lang_cer_grade' + count + '" class="form-control"/>' +
                        '<label for="lang_cer_grade' + count + '">등급 및 점수' +  (count+1) + '</label>' +
                        '</div>' +
                        '<div class="form-floating mb-3 col-sm">' +
                        '<input type="date" name="' + baseName + '[' + count + '].lang_cer_date" id="lang_cer_date' + count + '" class="form-control"/>' +
                        '<label for="lang_cer_date' + count + '">취득일자' + (count+1) + '</label>' +
                        '</div>' +
                        '</div>';
                    break;

            }
            container.append(newBlock);
        }
    });

    /*프로필 사진 미리보기*/
    function displayProfileImage(input) {
        var imageElement = document.getElementById('profileImage');
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                imageElement.src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            imageElement.src = "/img/default_profile.jpg";
        }
    }

    /*프로필 이미지 클릭시 사진선택*/
    function displayProfileImage(input) {
        var imageChangeText = document.getElementById('imageChangeText');

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function(e) {
                document.getElementById('profileImage').src = e.target.result;
                imageChangeText.textContent = '사진 변경';
            };

            reader.readAsDataURL(input.files[0]);
        }
    }

    function titleClick(y){
        if (y.defaultValue==y.value) {
            y.value = "";
        }
    }

    function sample6_execDaumPostcode() {
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
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;

                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();

    }

    function loadBusinessTypeCodeUp(count) {
        var upperLocValue = document.getElementById("business_type_code_up" + count).value;
        var lowerLocSelect = document.getElementById("business_type_code" + count);

        fetch('/seeker/getBusiness_type_code_up?business_type_code_up=' + upperLocValue)
            .then(response => response.json())
            .then(data => {
                console.log(data);
                lowerLocSelect.innerHTML = "<option value=''>선택</option>";
                data.forEach(type_code => {
                    var option = document.createElement("option");
                    option.value = type_code.detail_code_num;
                    option.text = type_code.detail_name;
                    lowerLocSelect.appendChild(option);
                });
            })
            .catch(error => console.error('Error:', error));
    }
</script>
<script>

    function loadLowerLoc() {
        var upperLocSelect = $("#upperLoc");
        var lowerLocSelect = $("#lowerLoc");
        var selectedUpperLoc = upperLocSelect.val();
        var selectedLowerLoc = lowerLocSelect.val();

        if (selectedUpperLoc) {
            $.ajax({
                type: "GET",
                url: "/seeker/getLowerLoc?upperLoc=" + selectedUpperLoc,
                success: function (data) {
                    var lowerLocSelect = $("#lowerLoc");
                    lowerLocSelect.empty();
                    lowerLocSelect.append($("<option>").text("선택"));

                    $.each(data, function (index, item) {
                        lowerLocSelect.append($("<option>").attr("value", item.detail_code_num).text(item.detail_name));
                    });
                }
            });
        }

        if (selectedLowerLoc) {
            updateSelectionResult(selectedUpperLoc, selectedLowerLoc);
        }
    }

    // 선택한 지역을 저장할 배열
    var selectedLocations = [];

    // lowerLoc 선택 이벤트 리스너
    document.getElementById("lowerLoc").addEventListener("change", function () {
        var upperLocSelect = document.getElementById("upperLoc");
        var lowerLocSelect = document.getElementById("lowerLoc");
        var upperLocValue = upperLocSelect.value;
        var lowerLocValue = lowerLocSelect.value;

        if (upperLocValue && lowerLocValue) {
            var upperLocText = upperLocSelect.options[upperLocSelect.selectedIndex].text;
            var lowerLocText = lowerLocSelect.options[lowerLocSelect.selectedIndex].text;
            var locDetailCode = lowerLocSelect.value;

            // 선택한 지역 정보를 배열에 추가
            selectedLocations.push({ code: locDetailCode, name: upperLocText + ' ' + lowerLocText });

            // 결과 창 업데이트
            updateSelectionResult(selectedLocations);

            // 선택 상자 초기화
            upperLocSelect.value = "";
            lowerLocSelect.value = "";
        }
    });

    function updateSelectionResult(locations) {
        var selectionResult = document.getElementById("selectionResult");
        selectionResult.innerHTML = ""; // 이전 내용 초기화

        // 최대 5개까지만 허용
        if (locations.length > 5) {
            alert("희망 근무지역은 최대 5개까지 선택 가능합니다.");
            locations = locations.slice(0, 5); // 최대 5개까지만 유지
        }

        // 중복을 방지하기 위한 Set을 사용
        var selectedLowerLocsSet = new Set();

        locations.forEach(function (location, index) {
            // 중복을 확인
            if (selectedLowerLocsSet.has(location.code)) {
                alert("이미 선택된 지역입니다.");
                return; // 중복된 경우 추가하지 않고 종료
            }

            // 중복이 아닌 경우 추가
            selectedLowerLocsSet.add(location.code);

            // 새로운 선택 항목을 추가
            var span = document.createElement("span");
            span.className = "selected-location"; // 간격을 주기 위한 클래스 추가

            // 스타일 추가
            span.style.marginRight = "15px"; // 간격을 조절할 값

            // 위치 정보 추가
            span.innerHTML = '<input type="hidden" name="resumeLocDTOList[' + index + '].loc_detail_code_num" value="' + location.code + '" class="form-control"/>' + location.name;

            // X 버튼 추가
            var closeButton = document.createElement("button");
            closeButton.className = "remove-location-button";
            closeButton.innerHTML = "X";
            closeButton.onclick = function() {
                // 요소 제거
                selectedLowerLocsSet.delete(location.code);
                locations.splice(index, 1);
                updateSelectionResult(locations);
            };

            // span에 X 버튼 추가
            span.appendChild(closeButton);

            selectionResult.appendChild(span);
        });
    }

</script>
</body>
</html>
