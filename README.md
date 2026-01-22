# SealFlowGuard

这是一个使用Spring Boot框架开发的应用程序，采用com.sealflow作为基础包名。

## 项目特性

- 基于Spring Boot 3.2.0
- 使用Java 17
- 内置Web支持
- 包含健康检查端点

## 快速开始

### 环境要求

- Java 17 或更高版本
- Maven (或使用提供的wrapper)

### 构建项目

您可以使用以下命令构建项目:

```bash
./mvnw clean package
```

或者在Windows上:

```bash
mvnw.cmd clean package
```

### 运行应用

运行以下命令启动应用程序:

```bash
./mvnw spring-boot:run
```

或者在Windows上:

```bash
mvnw.cmd spring-boot:run
```

应用将在 `http://localhost:8080` 启动。

### API 端点

- `/` - 返回欢迎信息
- `/health` - 应用健康状态检查

## 项目结构

```
src/
├── main/
│   ├── java/com/sealflow/
│   │   ├── SealflowGuardApplication.java
│   │   └── controller/
│   │       └── HelloController.java
│   └── resources/
│       └── application.properties
```