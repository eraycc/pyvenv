# pyvenv

---

一、简介  
pyvenv 是一个 纯 Bash 编写的 Python 虚拟环境管理器，目标是“零依赖、零学习成本、一键安装”。

它把官方 venv 的常见操作封装成 20 余个直观命令，并自带：  
- 中/英双语界面  
- 备份/还原（tar.gz）  
- 批量升级包  
- 自动补全  
- 彩色友好提示  

一句话：比 venv 官方脚本好用，比 conda 轻量，比 virtualenvwrapper 简洁。

---

二、一分钟上手

场景	命令	
安装	`curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh	
新建并激活环境	`pyvenv new myproj`	
退出环境	`pyvenv off`	
列出环境	`pyvenv list`	
删除环境	`pyvenv rm myproj`	
备份环境	`pyvenv backup myproj`	
还原环境	`pyvenv restore myproj_20251215_143022.tar.gz`	
升级全部包	`pyvenv update`	
卸载 pyvenv	`pyvenv uninstall`	

安装完成后重新打开终端即可使用 `pyvenv` 命令；Zsh/Bash 自动补全已默认开启。

---

三、安装与卸载

3.1 在线安装（推荐）

```bash
# 中文界面（默认）
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install

# 英文界面
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install en
```

过程说明：  
1. 下载脚本到 `~/.pyvenv/pyvenv.sh`  
2. 写入语言配置 `~/.pyvenv/config`  
3. 在 `~/.bashrc` 或 `~/.zshrc` 追加一行 `source ~/.pyvenv/pyvenv.sh`  
4. 重新加载 rc 文件（或新开终端）

3.2 卸载

```bash
pyvenv uninstall
```

提供三种选项：  
1. 仅卸载管理器，保留所有虚拟环境  
2. 完全卸载（环境 + 配置 + 自身）  
3. 取消

---

四、目录结构

```
~
├── .pyvenv/               # 管理器本体
│   ├── pyvenv.sh          # 核心脚本（会被 source）
│   ├── config             # 语言/配置
│   └── backups/           # 备份文件存放处
└── pyvenv/                # 所有虚拟环境统一根目录
    ├── proj1/
    ├── proj2/
    └── ...
```

> 可手动修改 `PYVENV_ENV_DIR` 环境变量改变默认存放位置。

---

五、命令总览

分组	命令（别名）	说明	
基础	`list`, `ls`	列出所有环境	
	`new <name>`	创建并激活	
	`use <name>`	激活已存在环境	
	`off`	退出当前环境	
管理	`create <name>`	仅创建，不激活	
	`rm <name>`	删除指定环境	
	`rm-all`	删除全部（需确认）	
	`reset [name]`	清空第三方包，保留 pip	
	`info [name]`	查看详情（Python 版本/包数量/大小）	
	`where [name]`	打印环境绝对路径	
	`run <name> -- <cmd>`	不激活直接运行命令	
包	`update`	升级当前环境内过时包	
备份	`backup [name]`	打包为 tar.gz	
	`backups`	列出已有备份	
	`restore <file>`	从备份还原	
	`rm-backup <file>`	删除单个备份	
	`rm-all-backups`	清空备份目录	
其他	`lang [cn	en]`	
	`uninstall`	卸载 pyvenv	
	`help`, `-h`	帮助	
	`version`, `-v`	版本	

---

六、使用示例

1. 新建并进入环境

   `pyvenv new demo`

   提示：已激活 demo，可直接 `pip install flask`。

2. 在环境外一次性执行命令

   `pyvenv run demo -- python -m pytest tests/`

   等价于激活 → 执行 → 退出，适合 CI。

3. 批量升级包

   `pyvenv use demo`

   `pyvenv update`          # 仅升级 demo 内过时包

4. 备份与迁移

   `pyvenv backup demo`                    # 生成 demo_20251215_143022.tar.gz

   拷贝文件到另一台机器

   `pyvenv restore demo_20251215_143022.tar.gz`   # 原样恢复

5. 重置环境（恢复“干净”状态）

   `pyvenv reset demo`      # 删除所有第三方包，仅保留 pip

---

七、自动补全
已内置 Bash/Zsh 补全规则，安装后无需额外配置：

`pyvenv <Tab>` → 列出子命令

`pyvenv use <Tab>` → 列出环境名

`pyvenv restore <Tab>` → 列出备份文件

---

八、多语言
`pyvenv lang`          # 查看当前语言

`pyvenv lang en`       # 切换英文

`pyvenv lang cn`       # 切换中文

语言设置保存在 `~/.pyvenv/config`，全局生效。

---

九、与官方 venv 对比

功能	venv 官方	pyvenv	
创建环境	✔	✔	
激活/退出	source bin/activate	`pyvenv use` / `pyvenv off`	
多环境列表	手动 ls	`pyvenv list` 彩色表格	
删除环境	rm -rf	`pyvenv rm`（二次确认）	
备份	手动 tar	`pyvenv backup` 一键打包	
升级包	pip list → pip install -U	`pyvenv update` 一键完成	
批量管理	×	`rm-all` / `rm-all-backups`	
语言界面	英文	中/英双语	
自动补全	×	Bash/Zsh 已集成	

---

十、常见问题

Q1 与系统 Python 冲突吗？

完全不冲突。pyvenv 只是对官方 venv 的封装，生成的环境与系统隔离。

Q2 可以指定 Python 版本吗？

目前自动使用 PATH 中第一个 `python3`/`python`。如需多版本，建议先使用 pyenv 或 deadsnakes 安装所需解释器，并确保其在 PATH 首位。

Q3 备份文件能否跨平台？

tar.gz 仅打包 site-packages 与脚本，同架构 + 同 Python 小版本 可直接用；跨平台/跨版本建议重新 `pip install -r requirements.txt`。

Q4 可以改环境存放路径吗？

`export PYVENV_ENV_DIR="/data/venvs"` 放入 `~/.bashrc`，再执行 `pyvenv` 即可。

Q5 Zsh 提示 complete: 未找到命令？

部分精简系统未加载 bashcompinit，可手动执行：

`autoload -Uz bashcompinit && bashcompinit`

再重新 source 一次即可。

---

十一、升级 pyvenv 自身

```bash
# 强制重新安装（保留环境与配置）
curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install --force
```

---

十二、贡献与反馈
欢迎提 Issue / PR：

https://github.com/eraycc/pyvenv

开源协议：MIT

---
