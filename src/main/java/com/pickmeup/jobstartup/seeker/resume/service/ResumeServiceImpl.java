package com.pickmeup.jobstartup.seeker.resume.service;

import com.pickmeup.jobstartup.recruiter.apply.dto.JobDTO;
import com.pickmeup.jobstartup.recruiter.apply.dto.LocDTO;
import com.pickmeup.jobstartup.seeker.applicationSupport.repository.ApplicationStatusRepository;
import com.pickmeup.jobstartup.seeker.resume.dto.*;
import com.pickmeup.jobstartup.seeker.resume.repository.ResumeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.ReturnedType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Service
public class ResumeServiceImpl implements ResumeService{
    private static final Logger logger = LoggerFactory.getLogger(ResumeServiceImpl.class);

    @Autowired
    private ResumeRepository resumeRepository;

    @Autowired
    private ApplicationStatusRepository applicationStatusRepository;

    //이력서 목록조회
    @Override
    public List<ResumeDTO> selectResumeList (int member_no) {
        logger.info("ResumeServiceImpl-selectResumeList() 진입");
        return resumeRepository.selectResumeList(member_no);
    }

    //이력서 상세 조회
    @Override
    public ResumeDTO selectResumeDetail (int resume_no) {
        logger.info("ResumeServiceImpl-selectResumeDetail() 진입");
        return resumeRepository.selectResumeDetail(resume_no);
    }

    //이력서 삭제
    @Override
    @Transactional
    public void deleteResume (int resume_no) {
        logger.info("ResumeServiceImpl-deleteResume() 진입");
        resumeRepository.deleteResume(resume_no);
    }

    //부속테이블 삭제
    @Override
    public void deleteResumeAttached (int resume_no, int lang_no) {
        logger.info("ResumeServiceImpl-deleteResumeAttached() 진입");
        resumeRepository.deleteCareer(resume_no);
        resumeRepository.deleteLanguageCertificate(lang_no);
        resumeRepository.deleteLanguage(resume_no);
        resumeRepository.deleteResumeLoc(resume_no);
        resumeRepository.deleteCertificate(resume_no);
        applicationStatusRepository.deleteApply(resume_no);
        this.deleteResume(resume_no);
    }

    //이력서 작성
    @Override
    public int insertResume(ResumeDTO resumeDTO, MultipartFile profileOrgNameFile, MultipartFile resumeOrgNameFile) {
        logger.info("ResumeServiceImpl-insertResume() 진입");

        //이력서 프로필 사진 업로드
        String profileSaveName = uploadFile(profileOrgNameFile, "C:/jobStartUp_fileUpload/profile_img/", resumeDTO.getProfile_orgname());
        resumeDTO.setProfile_savname(profileSaveName);

        //이력서 첨부파일 업로드
        String resumeSaveName = uploadFile(resumeOrgNameFile, "C:/jobStartUp_fileUpload/resumeFile/", resumeDTO.getResume_orgname());
        resumeDTO.setResume_savname(resumeSaveName);

        resumeRepository.insertResume(resumeDTO);

        int resumeNo = resumeRepository.getResumeSequence();

        logger.info("ResumeServiceImpl-insertResume() resumeNo: {}", resumeNo);

        return resumeNo;
    }

    //이력서 부속테이블 작성
    @Override
    @Transactional
    public void insertResumeAttached (ResumeDTO resumeDTO, MultipartFile profileOrgNameFile, MultipartFile resumeOrgNameFile) {
        logger.info("ResumeServiceImpl-insertResumeAttached() 진입");

        int resumeNo = this.insertResume(resumeDTO, profileOrgNameFile, resumeOrgNameFile);

        List<CareerDTO> careerDTOList = resumeDTO.getCareerDTOList().stream()
                .map(career -> CareerDTO.builder()
                        .resume_no(resumeNo)
                        .career_company(career.getCareer_company())
                        .business_type(career.getBusiness_type())
                        .career_work(career.getCareer_work())
                        .career_date(career.getCareer_date())
                        .build())
                .collect(Collectors.toList());

        List<CertificateDTO> certificateDTOList = resumeDTO.getCertificateDTOList().stream()
                .map(certificate -> CertificateDTO.builder()
                        .resume_no(resumeNo)
                        .cer_name(certificate.getCer_name())
                        .cer_issuer(certificate.getCer_issuer())
                        .cer_date(certificate.getCer_date())
                        .build())
                .collect(Collectors.toList());

        List<Integer> langNoList = resumeDTO.getLanguageDTOList().stream()
                .map(languageDTO -> {
                    LanguageDTO updateLanguageDTO = LanguageDTO.builder()
                                    .resume_no(resumeNo)
                                    .lang_name(languageDTO.getLang_name())
                                    .lang_level(languageDTO.getLang_level())
                                    .build();
                    resumeRepository.insertLanguage(Collections.singletonList(updateLanguageDTO));
                    return resumeRepository.getLanguageSequence();
                })
                .collect(Collectors.toList());

        List<LanguageCertificateDTO> languageCertificateDTOList = IntStream.range(0, langNoList.size())
                .mapToObj(i -> LanguageCertificateDTO.builder()
                        .lang_no(langNoList.get(i))
                        .lang_cer_exam(resumeDTO.getLanguageCertificateDTOList().get(i).getLang_cer_exam())
                        .lang_cer_grade(resumeDTO.getLanguageCertificateDTOList().get(i).getLang_cer_grade())
                        .lang_cer_date(resumeDTO.getLanguageCertificateDTOList().get(i).getLang_cer_date())
                        .build())
                .collect(Collectors.toList());

        List<ResumeLocDTO> resumeLocDTOList = resumeDTO.getResumeLocDTOList().stream()
                .map(loc -> ResumeLocDTO.builder()
                        .resume_no(resumeNo)
                        .loc_detail_code_num(loc.getLoc_detail_code_num())
                        .build())
                .collect(Collectors.toList());

        int careerResult = resumeRepository.insertCareer(careerDTOList);
        int certificateResult = resumeRepository.insertCertificate(certificateDTOList);
        int languageCertificateResult = resumeRepository.insertLanguageCertificate(languageCertificateDTOList);
        int resumeLocResult = resumeRepository.insertResumeLoc(resumeLocDTOList);

        logger.info("careerResult: {} / certificateResult: {} / languageCertificateResult: {} / resumeLocResult: {}", careerResult, certificateResult, languageCertificateResult, resumeLocResult);

        if (careerResult < 1 || certificateResult < 1 ||
                languageCertificateResult < 1 || resumeLocResult < 1) {

            throw new RuntimeException("트랜잭션 실패: 하나 이상의 작업이 실패했습니다.");
        }

    }

    //이력서 수정
    @Override
    @Transactional
    public void modifyResume (int resume_no, ResumeDTO modifyResumeDTO, MultipartFile profileOrgNameFile, MultipartFile resumeOrgNameFile) {

        List<CareerDTO> modifyCareerDTOList = new ArrayList<>();
        List<CertificateDTO> modifyCertificateDTOList = new ArrayList<>();
        List<LanguageDTO> modifyLanguageDTOList = new ArrayList<>();
        List<LanguageCertificateDTO> modifyLanguageCertificateDTOList = new ArrayList<>();
        List<ResumeLocDTO> modifyResumeLocDTOList = new ArrayList<>();

        ResumeDTO originalResumeDTO = resumeRepository.selectResumeDetail(resume_no);

        if (originalResumeDTO == null) {
            throw new NullPointerException();
        }

        originalResumeDTO.setMember_no(modifyResumeDTO.getMember_no());
        originalResumeDTO.setResume_title(modifyResumeDTO.getResume_title());

        /*if (!originalResumeDTO.getProfile_savname().equals(modifyResumeDTO.getProfile_savname())) {

        }*/
        //프로필 사진 수정
        //originalResumeDTO.setProfile_savname(modifyResumeDTO.getProfile_savname());
        originalResumeDTO.setResume_money(modifyResumeDTO.getResume_money());
        originalResumeDTO.setResume_skill(modifyResumeDTO.getResume_skill());
        //첨부파일 수정
        //originalResumeDTO.set(modifyResumeDTO.get);
        originalResumeDTO.setResume_url(modifyResumeDTO.getResume_url());

        //Career 수정
        for (CareerDTO originalCareerDTO : originalResumeDTO.getCareerDTOList()) {
            for (CareerDTO modifyCareerDTO : modifyResumeDTO.getCareerDTOList()) {
                originalCareerDTO.setCareer_date(modifyCareerDTO.getCareer_date());
                originalCareerDTO.setCareer_company(modifyCareerDTO.getCareer_company());
                originalCareerDTO.setBusiness_type(modifyCareerDTO.getBusiness_type());
                originalCareerDTO.setCareer_work(modifyCareerDTO.getCareer_work());
            }

            modifyCareerDTOList.add(originalCareerDTO);
        }

        //Certificate 수정
        for (CertificateDTO originalCertificateDTO : originalResumeDTO.getCertificateDTOList()) {
            for (CertificateDTO modifyCertificateDTO : modifyResumeDTO.getCertificateDTOList()) {
                originalCertificateDTO.setCer_name(modifyCertificateDTO.getCer_name());
                originalCertificateDTO.setCer_issuer(modifyCertificateDTO.getCer_issuer());
                originalCertificateDTO.setCer_date(modifyCertificateDTO.getCer_date());
            }

            modifyCertificateDTOList.add(originalCertificateDTO);
        }

        //Language 수정
        for (LanguageDTO originalLanguageDTO : originalResumeDTO.getLanguageDTOList()) {
            for (LanguageDTO modifyLanguageDTO : modifyResumeDTO.getLanguageDTOList()) {
                originalLanguageDTO.setLang_name(modifyLanguageDTO.getLang_name());
                originalLanguageDTO.setLang_level(modifyLanguageDTO.getLang_level());
            }

            modifyLanguageDTOList.add(originalLanguageDTO);
        }

        //LanguageCertificate 수정
        for (LanguageCertificateDTO originalLanguageCertificateDTO : originalResumeDTO.getLanguageCertificateDTOList()) {
            for (LanguageCertificateDTO modifyLanguageCertificateDTO : modifyResumeDTO.getLanguageCertificateDTOList()) {
                originalLanguageCertificateDTO.setLang_cer_exam(modifyLanguageCertificateDTO.getLang_cer_exam());
                originalLanguageCertificateDTO.setLang_cer_grade(modifyLanguageCertificateDTO.getLang_cer_grade());
                originalLanguageCertificateDTO.setLang_cer_date(modifyLanguageCertificateDTO.getLang_cer_date());
            }

            modifyLanguageCertificateDTOList.add(originalLanguageCertificateDTO);
        }

        //ResumeLoc 수정
        for (ResumeLocDTO originalResumeLocDTO : originalResumeDTO.getResumeLocDTOList()) {
            for (ResumeLocDTO modifyResumeLocDTO : modifyResumeDTO.getResumeLocDTOList()) {
                originalResumeLocDTO.setLoc_detail_code_num(modifyResumeLocDTO.getLoc_detail_code_num());
            }

            modifyResumeLocDTOList.add(originalResumeLocDTO);
        }

        resumeRepository.modifyResume(originalResumeDTO);
        resumeRepository.modifyResumeLoc(modifyResumeLocDTOList);
        resumeRepository.modifyCareer(modifyCareerDTOList);
        resumeRepository.modifyCertificate(modifyCertificateDTOList);
        resumeRepository.modifyLanguageCertificate(modifyLanguageCertificateDTOList);
        resumeRepository.modifyLanguage(modifyLanguageDTOList);
    }

    //상위 지역 리스트 가져오기
    @Override
    public List<LocDTO> getUpperLoc() {
        List<LocDTO> upperLoc = resumeRepository.getUpperLoc();
        System.out.println("서비스 upperLoc = " + upperLoc);
        return upperLoc;
    }

    //상위 지역에 따른 하위 지역 리스트 가져오기
    @Override
    public List<LocDTO> getLowerLoc(String upperLoc) {
        List<LocDTO> lowerLoc = resumeRepository.getLowerLoc(upperLoc);
        return lowerLoc;
    }

    @Override
    public List<JobDTO> getBusiness_type_code_up(){
        return resumeRepository.getBusiness_type_code_up();
    }

    @Override
    public List<JobDTO> getBusiness_type_code(String business_type_code_up){
        return resumeRepository.getBusiness_type_code(business_type_code_up);
    }

    @Override
    public List<LocDTO> selectDetailName (String detail_code_num) {
        List<LocDTO> result = resumeRepository.selectDetailName(detail_code_num);
        logger.info("result : {}", result);
        return result;
    }

    //파일 업로드 공통 메서드
    private String uploadFile (MultipartFile file, String directory, String originalName) {
        try {
            if (file == null || file.isEmpty()) {
                return "";
            }

        File dir = new File (directory);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        UUID uuid = UUID.randomUUID();
        String saveName = originalName + uuid;
        File dest = new File (directory + saveName);
        file.transferTo(dest);

        return saveName;
        } catch (IOException e) {
            throw  new RuntimeException("파일 업로드 오류", e);
        }
    }

}

