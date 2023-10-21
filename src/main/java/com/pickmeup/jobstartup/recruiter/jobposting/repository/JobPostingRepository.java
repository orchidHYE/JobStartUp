package com.pickmeup.jobstartup.recruiter.jobposting.repository;

import com.pickmeup.jobstartup.recruiter.apply.dto.LocDTO;
import com.pickmeup.jobstartup.recruiter.jobposting.dto.JobPostingDTO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface JobPostingRepository {
    //공고등록
    public void insertJobPostingDTO(JobPostingDTO jobPostingDTO) throws DataAccessException;

    //목록조회
    public List<JobPostingDTO> paginationPosting();

    //공고상세조회
    public JobPostingDTO selectJPdetail (int posting_no);

    // 공고게시글 수정
    public void JPmodify(Map<String, Object> map);

    // 공고 삭제
    public void JPdelete(int posting_no);

    //상위지역(서울특별시, 부산광역시 등등, 지역 계층구조 1단계) 목록 가져오기
    public List<LocDTO> getUpperLoc();
    //상위지역에 따른 하위지역 목록(강동구, 강서구, 강남구 등등, 지역 계층구조 2단계) 가져오기
    public List<LocDTO> getLowerLoc(String upperLoc);

    List<JobPostingDTO> paginationPosting(Map<String, Integer> paramMap);

    int countPosting();

}
