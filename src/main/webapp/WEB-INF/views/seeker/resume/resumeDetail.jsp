<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                    <!-- 제목 input -->
                    <div class="title-container">
                        <div class="form-floating mb-3">
                            <div class="title-container">${resumeDetail.resume_title}<div>
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
                                                <img id="profileImage" src="/image/resume/${resumeDetail.profile_savname}" style="width: 137px; height: 176px;" class="mb-3" onclick="document.getElementById('profileOrgNameFile').click();" />
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
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <!-- 이름 -->
                                                <div class="form-floating mb-3">
                                                    <div name="name" id="name" class="form-control">${member.member_name}</div>
                                                    <label for="name" class="form-label">이름</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <!-- 생년월일 -->
                                                <div class="form-floating mb-3">
                                                    <div name="dob" id="dob" class="form-control">${member.member_birth}</div>
                                                    <label for="dob" class="form-label">생년월일</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <!-- 이메일 -->
                                                <div class="form-floating mb-3">
                                                    <div name="email" id="email" class="form-control">${member.member_email}</div>
                                                    <label for="email" class="form-label">이메일</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <!-- 성별 -->
                                                <div class="form-floating mb-3">
                                                    <div name="gender" id="gender" class="form-control">${member.member_sex}</div>
                                                    <label for="gender" class="form-label">성별</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <!-- 휴대폰번호 -->
                                                <div class="form-floating mb-3">
                                                    <div name="phone" id="phone" class="form-control" style="--bs-focus-ring-color: rgba(var(--bs-success-rgb), .25)">${member.member_hp}</div>
                                                    <label for="phone" class="form-label">휴대폰번호</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="mb-3" style="position: relative;">
                                                    <div class="mb-3 grid text-center form-floating" id="addressDiv">
                                                        <div name="petAddress" id="sample6_address" class="form-control float-start">${member.member_loc}</div>
                                                        <label for="sample6_address">주소</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="item-container">
                        <!-- 원하는 연봉 input -->
                        <div class="form-floating mb-3">
                            <div id="resume_money" class="form-control">${resumeDetail.resume_money}</div>
                            <label for="resume_money">희망연봉</label>
                        </div>
                        <!-- 희망근무지역 input -->
                        <div class="form-floating mb-3">
                            <input type="hidden" value="${loc.loc_detail_code_num}" id="detail_code_num" name="detail_code_num"/>
                            <div id="detail_code_name" name="detail_code_name" class="form-control">
                                <c:forEach items="${locNameList}" var="locName" varStatus="loop">
                                    ${locName.detail_name}
                                    <c:if test="${!loop.last}"> <!-- 마지막 아이템이 아닌 경우에만 공백을 추가 -->
                                        &nbsp;
                                    </c:if>
                                </c:forEach>
                            </div>
                            <label for="detail_code_name">희망 근무지역</label>
                        </div>


                        <!-- 업무능력 input -->
                        <div class="form-floating mb-3">
                            <div id="resume_skill" class="form-control">${resumeDetail.resume_skill}</div>
                            <label for="resume_skill">업무능력</label>
                        </div>
                    </div>


                    <!-- 경력 섹션 -->
                    <c:forEach items="${resumeDetail.careerDTOList}" var="career">
                        <div class="item-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                                <p class="fs-6 fw-bold text-dark mb-0 custom-text-style">경력</p>
                            </div>
                            <div id="careerContainer">
                                <div class="careerBlock">
                                    <div class="row g-2">
                                        <div class="form-floating mb-3 col-sm-6">
                                            <div name="careerDTOList[0].career_company" id="career_company0" class="form-control">${career.career_company}</div>
                                            <label for="career_company0">회사명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <div type="text" name="careerDTOList[0].career_date" id="career_date0" class="form-control">${career.career_date}</div>
                                            <label for="career_date0">경력기간</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <div type="text" name="careerDTOList[0].business_type" id="business_type0" class="form-control">
                                                <c:forEach items="${workNameList}" var="work" varStatus="loop">
                                                    ${work.detail_name}
                                                </c:forEach>
                                            </div>
                                            <label for="career_date0">경력기간</label>
                                        </div>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <div name="careerDTOList[0].career_work" id="career_work0" class="form-control" style="width: auto; height: 137px">${career.career_work}</div>
                                        <label for="career_work0">담당업무</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>



                    <!-- 자격증 섹션 -->
                    <c:forEach items="${resumeDetail.certificateDTOList}" var="certificate">
                        <div class="item-container">
                            <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                                <p class="fs-6 fw-bold text-dark mb-0 custom-text-style">자격증</p>
                            </div>
                            <div id="certificateContainer">
                                <div class="certificateBlock">
                                    <div class="row g-2">
                                        <div class="form-floating mb-3 col-sm-6">
                                            <div type="text" name="certificateDTOList[0].cer_name" id="cer_name0" class="form-control">${certificate.cer_name}</div>
                                            <label for="cer_name0">자격증명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <div type="text" name="certificateDTOList[0].cer_issuer" id="cer_issuer0" class="form-control">${certificate.cer_issuer}</div>
                                            <label for="cer_issuer0">발급처</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <fmt:formatDate value="${certificate.cer_date}" pattern="yyyy/MM/dd" var="formattedDate" />
                                            <div type="date" name="certificateDTOList[0].cer_date" id="cer_date0" class="form-control">${formattedDate}</div>
                                            <label for="cer_date0">취득일자</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>


                    <!-- 언어 섹션 -->
                    <div class="item-container">
                        <div class="col-sm-12 d-flex align-items-center justify-content-between mb-5">
                            <p class="fs-6 fw-bold text-dark custom-text-style">언어</p>
                        </div>
                        <c:forEach items="${resumeDetail.languageDTOList}" var="language" varStatus="loof">
                            <div id="languageContainer">
                                <div class="languageBlock">
                                    <div class="row g-2">
                                        <div class="form-floating mb-3 col-sm-6">
                                            <div name="languageDTOList[0].lang_name" id="lang_name0" class="form-control">${language.lang_name}</div>
                                            <label for="lang_name0">언어명</label>
                                        </div>
                                        <div class="form-floating mb-3 col-sm">
                                            <div name="lang_level0" id="lang_level0" class="form-control">${language.lang_level}</div>
                                            <label for="lang_level0">회화능력</label>
                                        </div>
                                    </div>
                                    <c:forEach items="${resumeDetail.languageCertificateDTOList}" var="languageCertificate">
                                        <%-- 언어, 언어자격증 동일한 것끼리 분류하기 위한 조건문 --%>
                                        <c:if test="${languageCertificate.lang_no == language.lang_no}">
                                            <%-- 어학 자격증 --%>
                                            <div id="langCerContainer">
                                                <div class="langCerBlock">
                                                    <div class="row g-3">
                                                        <div class="form-floating mb-6 col-sm-6">
                                                            <div name="languageCertificateDTOList[0].lang_cer_exam" id="lang_cer_exam0" class="form-control">${languageCertificate.lang_cer_exam}</div>
                                                            <label for="lang_cer_exam0">어학 자격증명</label>
                                                        </div>
                                                        <div class="form-floating mb-3 col-sm">
                                                            <div name="languageCertificateDTOList[0].lang_cer_grade" id="lang_cer_grade0" class="form-control">${languageCertificate.lang_cer_grade}</div>
                                                            <label for="lang_cer_grade0">등급 및 점수</label>
                                                        </div>
                                                        <div class="form-floating mb-3 col-sm">
                                                            <fmt:formatDate value="${languageCertificate.lang_cer_date}" pattern="yyyy/MM/dd" var="formattedDate" />
                                                            <div name="languageCertificateDTOList[0].lang_cer_date" id="lang_cer_date0" class="form-control">${formattedDate}</div>
                                                            <label for="lang_cer_date0">취득일자</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- 마지막 루프가 아닌 경우에만 공백 추가 --%>
                                            <c:if test="${not loof.last}">
                                                <div class="mb-5"></div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${resumeDetail.resume_orgname != null || resumeDetail.resume_url != null}">
                        <!-- 첨부파일 및 URL input -->
                        <div class="end-container">
                            <c:if test="${resumeDetail.resume_orgname != null}">
                                <div class="col-sm-12 d-flex align-items-center justify-content-between">
                                    <p class="fs-6 fw-bold text-dark mb-5 custom-text-style">기타 첨부파일</p>
                                </div>
                                <div class="form-floating mb-3">
                                    <div name="resumeOrgNameFile" id="resumeOrgNameFile" class="form-control">${resumeDetail.resume_orgname}</div>
                                    <label for="resumeOrgNameFile">첨부파일</label>
                                </div>
                            </c:if>
                            <c:if test="${resumeDetail.resume_url != null}">
                                <div class="form-floating mb-5">
                                    <div name="resume_url" id="resume_url" class="form-control">${resumeDetail.resume_url}</div>
                                    <label for="resume_url">URL</label>
                                </div>
                            </c:if>
                        </div>
                    </c:if>

                    <div class="d-flex justify-content-center py-5">
                        <div><a href="${cPath }/seeker/resumeModify/${resumeDetail.resume_no}"><button type="button" class="btn btn-primary btn-md mx-3" style="border: none;">수정</button></a></div>
                        <div><a href="${cPath }/seeker/resumeDelete?resume_no=${resumeDetail.resume_no}&lang_no=${resumeDetail.languageCertificateDTOList[0].lang_no}"><button type="button" class="btn btn-primary btn-md" style="border: none;">삭제</button></a></div>
                    </div>
                    </div><%--얘 어딘가에서 짝을 잃어버린듯--%>
                    </div><%--얘 어딘가에서 짝을 잃어버린듯--%>
                </div>
            </div>
        </div>
    </section>
</main>
<%-- Footer --%>
<%@ include file="../../layout/layoutFooter.jsp"%>

<%-- Bootstrap cdn --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
