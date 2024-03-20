<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cPath" value="<%=request.getContextPath() %>"/>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <%-- 레이아웃 위해 추가 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <!-- Bootstrap core CSS -->
    <link href="/css/template/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/template/assets/css/templatemo-chain-app-dev.css">
    <link rel="stylesheet" href="/css/template/assets/css/animated.css">
    <link rel="stylesheet" href="/css/template/assets/css/owl.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Job Start Up / 수정폼</title>
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
        <div class="row gx-5 justify-content-center">
            <div class="col-lg-10">
                <form action="${cPath}/seeker/resumeModify/${modifyResumeDTO.resume_no}" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="member_no" id="member_no" value="${modifyResumeDTO.member_no}"/>
                    <div class="form-floating mb-3">
                        <input type="text" name="resume_title" id="resume_title" class="form-control" value="${modifyResumeDTO.resume_title}"/>
                        <label for="resume_title">제목</label>
                    </div>
                    <div class="mb-3">
                        <label for="profileOrgNameFile" class="form-label">프로필사진</label>
                        <input type="file" name="profileOrgNameFile" id="profileOrgNameFile" class="form-control" placeholder="프로필사진"/>
                        <c:if test="${not empty modifyResumeDTO.profile_savname}">
                            <img src="/image/resume/${modifyResumeDTO.profile_savname}" style="width: 20%; height: auto;"/>
                        </c:if>
                        <input type="hidden" name="profile_savname" id="profile_savname" value="test"/>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="resume_money" id="resume_money" class="form-control" value="${modifyResumeDTO.resume_money}"/>
                        <label for="resume_money">희망연봉</label>
                    </div>
                    <!-- Rest of your form fields here with values inserted -->
                    <!-- 경력 섹션 -->
                    <p class="lead mb-0">경력</p>
                    <hr>
                    <div class="row g-2">
                        <div class="form-floating mb-3 col-sm-6">
                            <input type="text" name="careerDTOList[0].career_company" id="career_company" class="form-control" value="${modifyResumeDTO.careerDTOList[0].career_company}"/>
                            <label for="career_company">회사명</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="text" name="careerDTOList[0].career_date" id="career_date" class="form-control" value="${modifyResumeDTO.careerDTOList[0].career_date}"/>
                            <label for="career_date">경력기간</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="text" name="careerDTOList[0].business_type" id="business_type" class="form-control" value="${modifyResumeDTO.careerDTOList[0].business_type}"/>
                            <label for="business_type">경력직무</label>
                        </div>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="careerDTOList[0].career_work" id="career_work" class="form-control" value="${modifyResumeDTO.careerDTOList[0].career_work}"/>
                        <label for="career_work">담당업무</label>
                    </div>

                    <!-- 자격증 섹션 -->
                    <p class="lead mb-0">자격증</p>
                    <hr>
                    <div class="row g-2">
                        <div class="form-floating mb-3 col-sm-6">
                            <input type="text" name="certificateDTOList[0].cer_name" id="cer_name" class="form-control" value="${modifyResumeDTO.certificateDTOList[0].cer_name}"/>
                            <label for="cer_name">자격증명</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="text" name="certificateDTOList[0].cer_issuer" id="cer_issuer" class="form-control" value="${modifyResumeDTO.certificateDTOList[0].cer_issuer}"/>
                            <label for="cer_issuer">발급처</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="date" name="certificateDTOList[0].cer_date" id="cer_date" class="form-control" value="${modifyResumeDTO.certificateDTOList[0].cer_date}"/>
                            <label for="cer_date">취득일자</label>
                        </div>
                    </div>

                    <!-- 언어 섹션 -->
                    <p class="lead mb-0">언어</p>
                    <hr>
                    <div class="row g-2">
                        <div class="form-floating mb-3 col-sm-6">
                            <input type="text" name="languageDTOList[0].lang_name" id="lang_name" class="form-control" value="${modifyResumeDTO.languageDTOList[0].lang_name}"/>
                            <label for="lang_name">언어명</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="text" name="languageDTOList[0].lang_level" id="lang_level" class="form-control" value="${modifyResumeDTO.languageDTOList[0].lang_level}"/>
                            <label for="lang_level">회화능력</label>
                        </div>
                    </div>

                    <!-- 어학 자격증 섹션 -->
                    <p class="lead mb-0">어학 자격증</p>
                    <hr>
                    <div class="row g-3">
                        <div class="form-floating mb-3 col-sm-6">
                            <input type="text" name="languageCertificateDTOList[0].lang_cer_exam" id="lang_cer_exam" class="form-control" value="${modifyResumeDTO.languageCertificateDTOList[0].lang_cer_exam}"/>
                            <label for="lang_cer_exam">자격증명</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="text" name="languageCertificateDTOList[0].lang_cer_grade" id="lang_cer_grade" class="form-control" value="${modifyResumeDTO.languageCertificateDTOList[0].lang_cer_grade}"/>
                            <label for="lang_cer_grade">등급 및 점수</label>
                        </div>
                        <div class="form-floating mb-3 col-sm">
                            <input type="date" name="languageCertificateDTOList[0].lang_cer_date" id="lang_cer_date" class="form-control" value="${modifyResumeDTO.languageCertificateDTOList[0].lang_cer_date}"/>
                            <label for="lang_cer_date">취득일자</label>
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

                    <input type="submit" name="submitBtn" id="submitBtn" value="등록" class="btn btn-primary btn-lg col-lg-6" style="background-color: #7A41FF; border: none;">
                </form>
            </div>
        </div>
    </div>
</section>
</main>
<%@ include file="../../layout/layoutFooter.jsp" %>
<script src="/css/template/vendor/jquery/jquery.min.js"></script>
<script src="/css/template/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/css/template/assets/js/owl-carousel.js"></script>
<script src="/css/template/assets/js/animation.js"></script>
<script src="/css/template/assets/js/imagesloaded.js"></script>
<script src="/css/template/assets/js/popup.js"></script>
<script src="/css/template/assets/js/custom.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
