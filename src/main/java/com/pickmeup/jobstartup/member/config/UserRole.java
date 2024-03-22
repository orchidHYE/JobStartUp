package com.pickmeup.jobstartup.member.config;

import lombok.Getter;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Set;
import java.util.stream.Collectors;

@Getter
public enum UserRole {
    COMMON(Set.of("COMMON")),
    COMPANY(Set.of("COMPANY")),
    ADMIN(Set.of("ADMIN")),
    UNAPPROVED_COMPANY(Set.of("UNAPPROVED_COMPANY"));

    private final Set<String> permissions;

    UserRole(Set<String> permissions) {
        this.permissions = permissions;
    }

    //권한 문자열을 SimpleGrantedAuthority 객체로 변환
    public Set<SimpleGrantedAuthority> getGrantedAuthorities() {
        //권한 목록을 stream으로 변환해서 권한 문자열의 Set을 반환
        Set<SimpleGrantedAuthority> permissions = getPermissions().stream()
                //SimpleGrantedAuthority 생성자를 사용하여 권한 문자열을 SimpleGrantedAuthority 객체로 변환
                .map(SimpleGrantedAuthority::new)
                //stream의 결과를 Set으로 모음
                .collect(Collectors.toSet());
        return permissions;
    }
}