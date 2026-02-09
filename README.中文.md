# Mihomo Podman

使用 Podman Compose 部署 [Mihomo](https://github.com/MetaCubeX/mihomo)（代理/VPN 客户端）和 [Metacubexd](https://github.com/MetaCubeX/metacubexd) Web 管理界面。

[EN](./README.md)

## 快速开始

### 前提条件
- 已安装 Podman 和 Podman Compose
- 基本了解容器概念
- 网络配置访问权限（用于特权模式）

### 基础设置

1. **配置 Mihomo**
   - 替换 `mihomo/config.yaml` 为您的配置文件
   - **clash-verge-rev 用户**：可从 Settings → Verge Advanced Setting → Runtime Config 导出配置
     - 注意修改配置文件下的`external-controller`、`secret`为合适, 面板控制会需要
     - 注意修改配置文件下的`external-controller-cors`的`allow-origins`为正确
   
2. **更新地理数据库**
   ```bash
   just update-geo
   # 或
   make update-geo
   ```

3. **启动服务**
   ```bash
   just up
   # 或
   make up
   ```

4. **访问 Web 界面**
   
   - 浏览器访问：http://localhost:9090

## 配置说明

### 环境变量[(`.env` 文件)](./.env)

| 变量 | 默认值 | 描述 |
|------|--------|------|
| `MIHOMO_REGISTRY` | `docker.io` | Mihomo 镜像仓库 |
| `METACUBEXD_REGISTRY` | `docker.io` | Metacubexd 镜像仓库 |
| `MIHOMO_TAG` | `latest` | Mihomo 镜像标签 |
| `METACUBEXD_TAG` | `latest` | Metacubexd 镜像标签 |
| `WEBUI_PORT` | `9090` | Web UI 端口 |
| `COUNTRY_MMDB_URL` | MetaCubeX URL | 国家数据库下载地址 |
| `GEOIP_DAT_URL` | MetaCubeX URL | GeoIP 数据库下载地址 |
| `GEOSITE_DAT_URL` | MetaCubeX URL | Geosite 数据库下载地址 |

### 服务配置

**Mihomo 服务：**

- 使用 `host` 网络模式
- 需要特权模式进行网络操作
- 挂载 `./mihomo` 到 `/root/.config/mihomo`
- 使用能力：`NET_ADMIN`, `SYS_MODULE`

**Metacubexd 服务：**
- 使用 `bridge` 网络模式
- 暴露端口 `9090` 用于 Web 访问
- 挂载 `./metacubexd` 到 `/config/caddy`（如需请创建目录）

## 命令参考

### Just 命令
```justfile
just update-geo    # 下载/更新地理数据库文件
just up            # 启动服务
just down          # 停止服务
just restart       # 重启服务
just logs          # 查看服务日志
just update        # 更新容器镜像并重启
```

### Make 命令
```makefile
make update-geo    # 下载/更新地理数据库文件
make up            # 启动服务
make down          # 停止服务
make restart       # 重启服务
make logs          # 查看服务日志
make update
```

## 自定义配置

### 端口配置
编辑 `.env` 文件：
```bash
WEBUI_PORT=9091  # 修改 Web UI 端口
```

### 镜像标签
编辑 `.env` 文件：
```bash
MIHOMO_TAG=v1.18.0        # 使用特定 Mihomo 版本
METACUBEXD_TAG=v2.0.0     # 使用特定 Metacubexd 版本
```
