# pyvenv - Python 虚拟环境管理器

一个功能强大、用户友好的 Python 虚拟环境管理工具，支持多语言界面和丰富的环境管理功能。

![pyvenv 界面演示](https://github.com/user-attachments/assets/377d5be7-bfd4-4eef-a326-decdf3e51277)

## ✨ 特性

- 🌍 **双语界面** - 支持中文和英文界面，自动检测系统语言
- 🚀 **快速创建** - 一键创建并激活虚拟环境
- 🔧 **灵活配置** - 支持指定 Python 版本或路径
- 📦 **包管理** - 轻松更新环境中的所有过时包
- 💾 **备份还原** - 完整的环境备份和恢复功能
- 🗑️ **安全删除** - 提供多重确认，防止误操作
- 🔍 **详细信息** - 显示环境详情、包列表和占用空间
- 🎯 **智能补全** - Bash 和 Zsh 自动命令补全
- 📊 **状态显示** - 清晰标注当前激活的环境

## 📦 安装

### 一键安装（推荐）

```bash
# 默认中文界面
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install

# 英文界面
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install en

# 强制重新安装
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install --force
```

安装完成后，重新打开终端或运行：
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

### 手动安装

1. 克隆仓库：
```bash
git clone https://github.com/eraycc/pyvenv.git
```

2. 运行安装脚本：
```bash
cd pyvenv
./pyvenv.sh install
```

## 🚀 快速开始

### 创建并激活环境
```bash
# 创建名为 myproject 的环境
pyvenv new myproject

# 使用 Python 3.11 创建环境
pyvenv new ai -p 3.11

# 使用指定 Python 路径创建环境
pyvenv new demo -p ~/.pyenv/versions/3.12.1/bin/python
```

### 管理环境
```bash
# 列出所有环境
pyvenv list

# 激活环境
pyvenv use myproject

# 退出当前环境
pyvenv off

# 查看环境详情
pyvenv info myproject
```

### 包管理
```bash
# 更新当前环境的所有包
pyvenv update

# 在环境中运行命令（无需激活）
pyvenv run myproject -- pip list
```

### 备份与还原
```bash
# 备份环境
pyvenv backup myproject

# 列出所有备份
pyvenv backups

# 还原环境
pyvenv restore myproject_20241215_143022.tar.gz
```

## 📖 完整命令参考

### 基础命令
| 命令 | 别名 | 描述 |
|------|------|------|
| `list` | `ls` | 列出所有虚拟环境 |
| `new` | `add` | 创建并激活新环境 |
| `use` | `on`, `start`, `activate` | 激活环境 |
| `off` | `exit`, `quit`, `stop`, `deactivate` | 退出当前环境 |

### 环境管理
| 命令 | 描述 |
|------|------|
| `create <name> [-p version/path]` | 创建环境（不激活） |
| `rm <name>` | 删除环境 |
| `rm-all` | 删除所有环境 |
| `reset [name]` | 重置环境（删除所有包） |
| `info [name]` | 显示环境详情 |
| `where [name]` | 显示环境路径 |
| `run <name> -- <command>` | 在环境中运行命令 |

### 包管理
| 命令 | 描述 |
|------|------|
| `update` | 更新所有过时的包 |

### 备份与还原
| 命令 | 描述 |
|------|------|
| `backup [name]` | 备份环境为 tar.gz 文件 |
| `backups` | 列出所有备份 |
| `restore <file>` | 从备份还原环境 |
| `rm-backup <file>` | 删除备份文件 |
| `rm-all-backups` | 删除所有备份 |

### 其他命令
| 命令 | 描述 |
|------|------|
| `lang [cn/en]` | 设置界面语言 |
| `uninstall` | 卸载 pyvenv |
| `help` | 显示帮助信息 |
| `version` | 显示版本信息 |

## 🗂️ 目录结构

```
~/.pyvenv/          # 配置目录
├── pyvenv.sh      # 主脚本
├── config         # 配置文件
└── backups/       # 备份文件存储

~/pyvenv/          # 虚拟环境存储目录
├── env1/         # 环境1
├── env2/         # 环境2
└── ...
```

## 🔧 配置

### 语言设置
```bash
# 切换为英文
pyvenv lang en

# 切换为中文
pyvenv lang cn

# 查看当前语言
pyvenv lang
```

### Python 版本支持
- 支持 Python 3.3 及以上版本
- 不支持 Python 2.x
- 可自动检测系统 Python 版本

## 🛠️ 开发

### 脚本位置
```bash
# 主脚本
~/.pyvenv/pyvenv.sh

# 配置文件
~/.pyvenv/config
```

### 卸载
```bash
# 通过命令卸载
pyvenv uninstall

# 或使用 curl 卸载
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- uninstall
```

卸载选项：
1. **仅卸载 pyvenv** - 保留所有虚拟环境
2. **完全卸载** - 删除 pyvenv 和所有环境
3. **取消卸载**

## 📋 要求

- **操作系统**: Linux, macOS, WSL
- **Shell**: Bash 4.0+ 或 Zsh
- **Python**: 3.3 或更高版本
- **工具**: curl, tar

## 🤝 贡献

欢迎贡献代码、报告问题或提出建议！

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者！

## 📞 支持

如果遇到问题，请：
1. 查看 [Issues](https://github.com/eraycc/pyvenv/issues)
2. 查看帮助 (`pyvenv help`)
3. 开启新的 Issue

---
