package com.pickmeup.jobstartup.recruiter.appmanagement.service;

import com.pickmeup.jobstartup.recruiter.appmanagement.dto.AppManageDTO;
import com.pickmeup.jobstartup.recruiter.appmanagement.dto.AppResumeDTO;
import com.pickmeup.jobstartup.recruiter.appmanagement.repository.AppManageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class AppManageServiceImpl implements AppManageService{

    @Autowired
    private AppManageRepository appManageRepository;

    //채용관리 지원자 상세 페이지: 1) 지원자 인적 정보
    @Override
    public AppManageDTO selectAppInfoByMember(int status_no) {
        return appManageRepository.selectAppInfoByMember(status_no);
    }

    //채용관리 지원자 상세 페이지: 2) 지원자 이력 정보
    @Override
    public AppResumeDTO selectAppResumeByMember(int resume_no) {
        return appManageRepository.selectAppResumeByMember(resume_no);
    }

    //채용관리 지원자 상세 페이지: 2) 지원자 이력 정보 - 파일 다운로드





    //채용관리 지원자 상세 페이지: 1차 면접일자 등록
    @Override
    public int updateAppManageFirstEnroll(AppManageDTO appManageDTO){
        return appManageRepository.updateAppManageFirstEnroll(appManageDTO);
    };

    //채용관리 지원자 상세 페이지: 1차 면접일자 반려
    @Override
    public int updateAppManageFirstDenial(int status_no){
        return appManageRepository.updateAppManageFirstDenial(status_no);
    };

    //채용관리 지원자 상세 페이지: 최종 면접일자 승인
    @Override
    public int updateAppManageLastEnroll(int status_no){
        return appManageRepository.updateAppManageLastEnroll(status_no);
    };

    //채용관리 지원자 상세 페이지: 최종 면접일자 반려
    @Override
    public int updateAppManageLastDenial(int status_no){
        return appManageRepository.updateAppManageLastDenial(status_no);
    };

    //채용관리 지원자 상세 페이지: 1차 메일링(안내)

    //채용관리 지원자 상세 페이지: 최종 메일링(안내)



}