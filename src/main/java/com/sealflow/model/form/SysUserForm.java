package com.sealflow.model.form;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
@Schema(description = "用户表表单信息")
public class SysUserForm {

    @Schema(description = "用户ID，主键自增")
    private Long id;

    @Schema(description = "学号，唯一")
    private String username;

    @Schema(description = "密码，加密存储")
    private String password;

    @Schema(description = "真实姓名")
    private String realName;

    @Schema(description = "角色ID列表")
    private List<Long> roleIds;

    @Schema(description = "邮箱，唯一")
    private String email;

    @Schema(description = "手机号")
    private String phone;

    @Schema(description = "头像URL")
    private String avatar;

    @Schema(description = "性别（0-未知，1-男，2-女）")
    private Integer gender;

    @Schema(description = "生日")
    private LocalDate birthday;

    @Schema(description = "个人简介")
    private String introduction;

    @Schema(description = "状态（0禁用，1启用）")
    private Integer status;
}