package com.sealflow.model.vo;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;


@Data
@Schema(description = "用户表列表对象")
public class SysUserVO {

    @Schema(description = "用户ID，主键自增")
    private Long id;

    @Schema(description = "学号，唯一")
    private String username;

    @Schema(description = "真实姓名")
    private String realName;

    @Schema(description = "邮箱，唯一")
    private String email;

    @Schema(description = "手机号")
    private String phone;

    @Schema(description = "头像URL")
    private String avatar;

    @Schema(description = "性别（0-未知，1-男，2-女）")
    private Integer gender;

    @Schema(description = "生日")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime birthday;

    @Schema(description = "个人简介")
    private String introduction;

    @Schema(description = "状态（0禁用，1启用）")
    private Integer status;

    @Schema(description = "用户角色列表")
    private List<SysRoleVO> roles;
}
