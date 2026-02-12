package com.sealflow.common.config;

import com.sealflow.common.filter.JwtAuthenticationFilter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.concurrent.TimeUnit;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class WebConfig implements WebMvcConfigurer {

	@Value("${file.upload.path:uploads/sealflow}")
	private String uploadPath;

	// 添加静态资源处理
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/uploads/**")
				.addResourceLocations("file:" + uploadPath + "/")
				.setCacheControl(CacheControl.maxAge(0, TimeUnit.SECONDS).cachePublic());
	}

	// 密码编码器
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	// 创建安全过滤器链
		@Bean
	public SecurityFilterChain filterChain(HttpSecurity http, JwtAuthenticationFilter jwtAuthenticationFilter) throws Exception {
		http
				.csrf(AbstractHttpConfigurer::disable)
				.sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
				.authorizeHttpRequests(auth -> auth
						.requestMatchers("/**").permitAll()
						.requestMatchers("/v3/api-docs/**", "/swagger-ui.html", "/doc.html", "/error").permitAll()
						.anyRequest().authenticated()
				);

		// 添加JWT认证过滤器
		http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

		return http.build();
	}

	// 添加跨域支持
    @Override
    public void addCorsMappings(CorsRegistry registry) {
         registry.addMapping("/**") // 允许所有路径
                 .allowedOriginPatterns("*")
                 .allowedMethods("GET", "POST", "PUT", "DELETE") // 允许的 HTTP 方法
                 .allowCredentials(true); // 允许携带身份凭证（如 Cookie）
    }
}
