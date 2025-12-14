#!/usr/bin/env bash
# ============================================================================
#  pyvenv - Python 虚拟环境管理器 / Python Virtual Environment Manager
#  
#  安装 / Install:
#    curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install
#    curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install en
#  
#  卸载 / Uninstall:
#    pyvenv uninstall
#    curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- uninstall
# ============================================================================

# ======================== 目录与文件路径 ========================
PYVENV_HOME="${HOME}/.pyvenv"
PYVENV_SCRIPT="${PYVENV_HOME}/pyvenv.sh"
PYVENV_CONFIG="${PYVENV_HOME}/config"
PYVENV_BACKUP_DIR="${PYVENV_HOME}/backups"
PYVENV_ENV_DIR="${HOME}/pyvenv"

# ======================== 完整语言包 ========================
declare -gA L

# ---- 通用词汇 ----
L[cn,name]="名称"
L[en,name]="Name"
L[cn,path]="路径"
L[en,path]="Path"
L[cn,version]="版本"
L[en,version]="Version"
L[cn,python]="Python"
L[en,python]="Python"
L[cn,packages]="已安装包"
L[en,packages]="Packages"
L[cn,size]="占用空间"
L[en,size]="Size"
L[cn,status]="状态"
L[en,status]="Status"
L[cn,active]="已激活"
L[en,active]="Active"
L[cn,inactive]="未激活"
L[en,inactive]="Inactive"
L[cn,yes]="是"
L[en,yes]="Yes"
L[cn,no]="否"
L[en,no]="No"
L[cn,none]="无"
L[en,none]="None"
L[cn,total]="共计"
L[en,total]="Total"
L[cn,current]="当前"
L[en,current]="Current"
L[cn,target]="目标"
L[en,target]="Target"
L[cn,source]="源"
L[en,source]="Source"
L[cn,file]="文件"
L[en,file]="File"
L[cn,command]="命令"
L[en,command]="Command"
L[cn,option]="选项"
L[en,option]="Option"
L[cn,argument]="参数"
L[en,argument]="Argument"
L[cn,example]="示例"
L[en,example]="Example"
L[cn,usage]="用法"
L[en,usage]="Usage"
L[cn,description]="描述"
L[en,description]="Description"
L[cn,note]="注意"
L[en,note]="Note"
L[cn,tip]="提示"
L[en,tip]="Tip"
L[cn,warning]="警告"
L[en,warning]="Warning"
L[cn,error]="错误"
L[en,error]="Error"
L[cn,success]="成功"
L[en,success]="Success"
L[cn,failed]="失败"
L[en,failed]="Failed"
L[cn,cancelled]="已取消"
L[en,cancelled]="Cancelled"
L[cn,confirmed]="已确认"
L[en,confirmed]="Confirmed"
L[cn,skipped]="已跳过"
L[en,skipped]="Skipped"
L[cn,done]="完成"
L[en,done]="Done"
L[cn,please_wait]="请稍候..."
L[en,please_wait]="Please wait..."
L[cn,processing]="处理中..."
L[en,processing]="Processing..."
L[cn,loading]="加载中..."
L[en,loading]="Loading..."

# ---- 环境操作消息 ----
L[cn,env_creating]="正在创建虚拟环境"
L[en,env_creating]="Creating virtual environment"
L[cn,env_created]="虚拟环境创建成功"
L[en,env_created]="Virtual environment created successfully"
L[cn,env_create_failed]="虚拟环境创建失败"
L[en,env_create_failed]="Failed to create virtual environment"
L[cn,env_exists]="虚拟环境已存在"
L[en,env_exists]="Virtual environment already exists"
L[cn,env_not_found]="虚拟环境不存在"
L[en,env_not_found]="Virtual environment not found"
L[cn,env_activating]="正在激活环境"
L[en,env_activating]="Activating environment"
L[cn,env_activated]="环境已激活"
L[en,env_activated]="Environment activated"
L[cn,env_deactivating]="正在退出环境"
L[en,env_deactivating]="Deactivating environment"
L[cn,env_deactivated]="已退出环境"
L[en,env_deactivated]="Environment deactivated"
L[cn,env_no_active]="当前没有激活的环境"
L[en,env_no_active]="No environment is currently active"
L[cn,env_removing]="正在删除环境"
L[en,env_removing]="Removing environment"
L[cn,env_removed]="环境已删除"
L[en,env_removed]="Environment removed"
L[cn,env_remove_active_hint]="已自动退出正在使用的环境"
L[en,env_remove_active_hint]="Automatically deactivated the active environment"
L[cn,env_copying]="正在复制环境"
L[en,env_copying]="Copying environment"
L[cn,env_copied]="环境复制完成"
L[en,env_copied]="Environment copied successfully"
L[cn,env_renaming]="正在重命名环境"
L[en,env_renaming]="Renaming environment"
L[cn,env_renamed]="环境重命名完成"
L[en,env_renamed]="Environment renamed successfully"
L[cn,env_resetting]="正在重置环境"
L[en,env_resetting]="Resetting environment"
L[cn,env_reset_done]="环境已重置（仅保留 pip）"
L[en,env_reset_done]="Environment reset (pip only)"
L[cn,env_empty_list]="暂无虚拟环境"
L[en,env_empty_list]="No virtual environments found"
L[cn,env_list_title]="虚拟环境列表"
L[en,env_list_title]="Virtual Environments"
L[cn,env_list_hint]="提示：使用 'pyvenv new <名称>' 创建新环境"
L[en,env_list_hint]="Tip: Use 'pyvenv new <name>' to create a new environment"
L[cn,env_info_title]="环境详情"
L[en,env_info_title]="Environment Details"
L[cn,env_count]="共 %d 个环境"
L[en,env_count]="%d environment(s)"

# ---- 包管理消息 ----
L[cn,pkg_updating]="正在检查并升级过期的包"
L[en,pkg_updating]="Checking and updating outdated packages"
L[cn,pkg_update_done]="所有包已升级到最新版本"
L[en,pkg_update_done]="All packages updated to latest versions"
L[cn,pkg_no_outdated]="所有包都是最新的，无需升级"
L[en,pkg_no_outdated]="All packages are up to date"
L[cn,pkg_upgrading]="正在升级"
L[en,pkg_upgrading]="Upgrading"
L[cn,pkg_list_title]="已安装的包"
L[en,pkg_list_title]="Installed Packages"

# ---- 备份与还原消息 ----
L[cn,backup_creating]="正在备份环境"
L[en,backup_creating]="Backing up environment"
L[cn,backup_created]="备份完成"
L[en,backup_created]="Backup completed"
L[cn,backup_file]="备份文件"
L[en,backup_file]="Backup file"
L[cn,backup_list_title]="可用备份列表"
L[en,backup_list_title]="Available Backups"
L[cn,backup_empty]="暂无备份文件"
L[en,backup_empty]="No backup files found"
L[cn,backup_invalid]="无效的备份文件"
L[en,backup_invalid]="Invalid backup file"
L[cn,backup_not_found]="备份文件不存在"
L[en,backup_not_found]="Backup file not found"
L[cn,backup_removing]="正在删除备份"
L[en,backup_removing]="Removing backup"
L[cn,backup_removed]="备份已删除"
L[en,backup_removed]="Backup removed"
L[cn,backup_count]="共 %d 个备份"
L[en,backup_count]="%d backup(s)"
L[cn,restore_starting]="正在还原环境"
L[en,restore_starting]="Restoring environment"
L[cn,restore_done]="环境还原完成"
L[en,restore_done]="Environment restored successfully"
L[cn,restore_env_name]="还原的环境名称"
L[en,restore_env_name]="Restored environment name"

# ---- 确认提示 ----
L[cn,confirm_remove]="确定要删除环境 '%s' 吗？此操作不可撤销。"
L[en,confirm_remove]="Are you sure you want to remove '%s'? This cannot be undone."
L[cn,confirm_remove_all]="⚠️  警告：即将删除所有 %d 个虚拟环境！"
L[en,confirm_remove_all]="⚠️  Warning: About to remove all %d virtual environment(s)!"
L[cn,confirm_remove_backup]="确定要删除备份 '%s' 吗？"
L[en,confirm_remove_backup]="Are you sure you want to remove backup '%s'?"
L[cn,confirm_remove_all_backups]="⚠️  警告：即将删除所有 %d 个备份文件！"
L[en,confirm_remove_all_backups]="⚠️  Warning: About to remove all %d backup file(s)!"
L[cn,confirm_reset]="确定要重置环境 '%s' 吗？这将删除所有已安装的包（保留 pip）。"
L[en,confirm_reset]="Reset '%s'? This will remove all installed packages (keeping pip)."
L[cn,confirm_type_yes]="请输入 'yes' 确认"
L[en,confirm_type_yes]="Type 'yes' to confirm"
L[cn,confirm_type_name]="请输入环境名称 '%s' 确认"
L[en,confirm_type_name]="Type the environment name '%s' to confirm"
L[cn,confirm_yn]="确认？[y/N]"
L[en,confirm_yn]="Confirm? [y/N]"
L[cn,confirm_Yn]="确认？[Y/n]"
L[en,confirm_Yn]="Confirm? [Y/n]"

# ---- 错误消息 ----
L[cn,err_no_name]="请指定环境名称"
L[en,err_no_name]="Please specify an environment name"
L[cn,err_invalid_name]="无效的环境名称。只能包含字母、数字、下划线和连字符，且不能以连字符开头。"
L[en,err_invalid_name]="Invalid environment name. Use only letters, numbers, underscores and hyphens. Cannot start with hyphen."
L[cn,err_same_name]="源环境和目标环境名称不能相同"
L[en,err_same_name]="Source and destination names cannot be the same"
L[cn,err_no_python]="未找到 Python。请先安装 Python 3。"
L[en,err_no_python]="Python not found. Please install Python 3 first."
L[cn,err_python_version]="需要 Python 3.3 或更高版本"
L[en,err_python_version]="Python 3.3 or higher is required"
L[cn,err_file_not_found]="文件不存在"
L[en,err_file_not_found]="File not found"
L[cn,err_not_tar_gz]="文件必须是 .tar.gz 格式"
L[en,err_not_tar_gz]="File must be in .tar.gz format"
L[cn,err_cmd_not_found]="未知命令"
L[en,err_cmd_not_found]="Unknown command"
L[cn,err_missing_arg]="缺少必需的参数"
L[en,err_missing_arg]="Missing required argument"
L[cn,err_too_many_args]="参数过多"
L[en,err_too_many_args]="Too many arguments"
L[cn,err_run_no_cmd]="请指定要运行的命令"
L[en,err_run_no_cmd]="Please specify a command to run"
L[cn,err_download_failed]="下载失败，请检查网络连接"
L[en,err_download_failed]="Download failed. Please check your network connection"
L[cn,err_no_backup_name]="请指定备份文件名"
L[en,err_no_backup_name]="Please specify a backup file name"

# ---- 语言设置 ----
L[cn,lang_current]="当前语言"
L[en,lang_current]="Current language"
L[cn,lang_changed]="语言已切换为"
L[en,lang_changed]="Language changed to"
L[cn,lang_cn]="简体中文"
L[en,lang_cn]="Simplified Chinese"
L[cn,lang_en]="English"
L[en,lang_en]="English"
L[cn,lang_invalid]="无效的语言选项。请使用 'cn'（中文）或 'en'（英文）。"
L[en,lang_invalid]="Invalid language. Use 'cn' (Chinese) or 'en' (English)."

# ---- 安装与卸载 ----
L[cn,install_starting]="正在安装 pyvenv..."
L[en,install_starting]="Installing pyvenv..."
L[cn,install_downloading]="正在下载脚本..."
L[en,install_downloading]="Downloading script..."
L[cn,install_configuring]="正在配置..."
L[en,install_configuring]="Configuring..."
L[cn,install_success]="pyvenv 安装成功！"
L[en,install_success]="pyvenv installed successfully!"
L[cn,install_ready]="pyvenv 已就绪，现在可以使用了。"
L[en,install_ready]="pyvenv is ready to use."
L[cn,install_try_now]="现在可以尝试："
L[en,install_try_now]="You can now try:"
L[cn,install_already]="pyvenv 已经安装。如需重新安装，请先卸载。"
L[en,install_already]="pyvenv is already installed. To reinstall, please uninstall first."
L[cn,install_force_hint]="或使用 --force 强制重新安装"
L[en,install_force_hint]="Or use --force to force reinstall"
L[cn,install_note]="如果运行 pyvenv 失败，请新建终端窗口或手动执行："
L[en,install_note]="If pyvenv command fails, please open a new terminal or run:"

L[cn,uninstall_title]="卸载 pyvenv"
L[en,uninstall_title]="Uninstall pyvenv"
L[cn,uninstall_menu]="请选择卸载方式："
L[en,uninstall_menu]="Select uninstall option:"
L[cn,uninstall_opt1]="仅卸载 pyvenv（保留所有虚拟环境）"
L[en,uninstall_opt1]="Uninstall pyvenv only (keep all environments)"
L[cn,uninstall_opt2]="完全卸载（删除 pyvenv 和所有虚拟环境）"
L[en,uninstall_opt2]="Complete uninstall (remove pyvenv and all environments)"
L[cn,uninstall_opt3]="取消卸载"
L[en,uninstall_opt3]="Cancel"
L[cn,uninstall_select]="请输入选项 [1-3]"
L[en,uninstall_select]="Enter option [1-3]"
L[cn,uninstall_removing]="正在卸载 pyvenv..."
L[en,uninstall_removing]="Uninstalling pyvenv..."
L[cn,uninstall_done]="pyvenv 已卸载"
L[en,uninstall_done]="pyvenv has been uninstalled"
L[cn,uninstall_env_kept]="虚拟环境目录已保留"
L[en,uninstall_env_kept]="Environment directory has been kept"
L[cn,uninstall_all_removed]="所有文件已清理完毕"
L[en,uninstall_all_removed]="All files have been removed"
L[cn,uninstall_hint]="如需重新安装，请运行："
L[en,uninstall_hint]="To reinstall, run:"
L[cn,uninstall_complete]="卸载完成。pyvenv 命令已移除。"
L[en,uninstall_complete]="Uninstall complete. pyvenv command has been removed."

# ---- 帮助信息 ----
L[cn,help_header]="pyvenv - Python 虚拟环境管理器"
L[en,help_header]="pyvenv - Python Virtual Environment Manager"
L[cn,help_usage]="用法：pyvenv <命令> [参数]"
L[en,help_usage]="Usage: pyvenv <command> [arguments]"
L[cn,help_commands]="命令列表："
L[en,help_commands]="Commands:"
L[cn,help_section_basic]="基础命令"
L[en,help_section_basic]="Basic Commands"
L[cn,help_section_manage]="环境管理"
L[en,help_section_manage]="Environment Management"
L[cn,help_section_package]="包管理"
L[en,help_section_package]="Package Management"
L[cn,help_section_backup]="备份与还原"
L[en,help_section_backup]="Backup & Restore"
L[cn,help_section_other]="其他"
L[en,help_section_other]="Other"

L[cn,help_cmd_list]="列出所有虚拟环境"
L[en,help_cmd_list]="List all virtual environments"
L[cn,help_cmd_create]="创建新的虚拟环境（不激活）"
L[en,help_cmd_create]="Create a new virtual environment (without activating)"
L[cn,help_cmd_new]="创建并立即激活新环境"
L[en,help_cmd_new]="Create and immediately activate a new environment"
L[cn,help_cmd_use]="激活指定的虚拟环境"
L[en,help_cmd_use]="Activate a virtual environment"
L[cn,help_cmd_off]="退出当前激活的环境"
L[en,help_cmd_off]="Deactivate current environment"
L[cn,help_cmd_rm]="删除指定的虚拟环境"
L[en,help_cmd_rm]="Remove a virtual environment"
L[cn,help_cmd_rm_all]="删除所有虚拟环境（需二次确认）"
L[en,help_cmd_rm_all]="Remove all virtual environments (requires confirmation)"
L[cn,help_cmd_cp]="复制一个虚拟环境"
L[en,help_cmd_cp]="Copy a virtual environment"
L[cn,help_cmd_mv]="重命名虚拟环境"
L[en,help_cmd_mv]="Rename a virtual environment"
L[cn,help_cmd_reset]="重置环境（删除所有包，保留 pip）"
L[en,help_cmd_reset]="Reset environment (remove all packages, keep pip)"
L[cn,help_cmd_info]="显示环境的详细信息"
L[en,help_cmd_info]="Show detailed environment information"
L[cn,help_cmd_where]="显示环境的完整路径"
L[en,help_cmd_where]="Show full path of an environment"
L[cn,help_cmd_run]="在指定环境中运行命令（无需激活）"
L[en,help_cmd_run]="Run command in an environment (without activating)"
L[cn,help_cmd_update]="升级当前环境中的所有过期包"
L[en,help_cmd_update]="Update all outdated packages in current environment"
L[cn,help_cmd_backup]="备份虚拟环境为 tar.gz 文件"
L[en,help_cmd_backup]="Backup a virtual environment to tar.gz file"
L[cn,help_cmd_backups]="列出所有备份文件"
L[en,help_cmd_backups]="List all backup files"
L[cn,help_cmd_restore]="从备份文件还原虚拟环境"
L[en,help_cmd_restore]="Restore a virtual environment from backup"
L[cn,help_cmd_rm_backup]="删除指定的备份文件"
L[en,help_cmd_rm_backup]="Remove a backup file"
L[cn,help_cmd_rm_all_backups]="删除所有备份文件"
L[en,help_cmd_rm_all_backups]="Remove all backup files"
L[cn,help_cmd_lang]="设置界面语言（cn/en）"
L[en,help_cmd_lang]="Set interface language (cn/en)"
L[cn,help_cmd_uninstall]="卸载 pyvenv"
L[en,help_cmd_uninstall]="Uninstall pyvenv"
L[cn,help_cmd_help]="显示此帮助信息"
L[en,help_cmd_help]="Show this help message"
L[cn,help_cmd_version]="显示版本信息"
L[en,help_cmd_version]="Show version information"

L[cn,help_examples]="示例："
L[en,help_examples]="Examples:"
L[cn,help_ex_new]="创建并激活名为 myproject 的环境"
L[en,help_ex_new]="Create and activate an environment named myproject"
L[cn,help_ex_use]="激活已存在的环境"
L[en,help_ex_use]="Activate an existing environment"
L[cn,help_ex_run]="在环境中运行 pip 命令"
L[en,help_ex_run]="Run pip command in an environment"
L[cn,help_ex_backup]="备份环境"
L[en,help_ex_backup]="Backup an environment"

L[cn,help_dirs]="目录说明："
L[en,help_dirs]="Directories:"
L[cn,help_dir_envs]="虚拟环境存储目录"
L[en,help_dir_envs]="Virtual environments storage"
L[cn,help_dir_config]="配置文件目录"
L[en,help_dir_config]="Configuration directory"

L[cn,help_more]="更多信息请访问："
L[en,help_more]="For more information, visit:"

# ---- 版本信息 ----
L[cn,version_info]="pyvenv 版本 %s"
L[en,version_info]="pyvenv version %s"
L[cn,version_author]="Python 虚拟环境管理器"
L[en,version_author]="Python Virtual Environment Manager"

# ======================== 版本号 ========================
PYVENV_VERSION="1.6.8"

# ======================== 颜色与格式 ========================
if [[ -t 1 ]]; then
    C_RESET='\033[0m'
    C_BOLD='\033[1m'
    C_DIM='\033[2m'
    C_RED='\033[0;31m'
    C_GREEN='\033[0;32m'
    C_YELLOW='\033[0;33m'
    C_BLUE='\033[0;34m'
    C_MAGENTA='\033[0;35m'
    C_CYAN='\033[0;36m'
    C_WHITE='\033[0;37m'
else
    C_RESET='' C_BOLD='' C_DIM=''
    C_RED='' C_GREEN='' C_YELLOW='' C_BLUE='' C_MAGENTA='' C_CYAN='' C_WHITE=''
fi

# ======================== 核心函数 ========================

# 获取翻译文本
_t() {
    local key="$1"
    echo "${L[${PYVENV_LANG:-cn},$key]:-$key}"
}

# 格式化翻译（printf 格式）
_tf() {
    local key="$1"; shift
    # shellcheck disable=SC2059
    printf "${L[${PYVENV_LANG:-cn},$key]:-$key}" "$@"
}

# 输出函数
_echo()    { echo -e "$*"; }
_success() { echo -e "${C_GREEN}✓${C_RESET} $*"; }
_error()   { echo -e "${C_RED}✗${C_RESET} $*" >&2; }
_warn()    { echo -e "${C_YELLOW}!${C_RESET} $*"; }
_info()    { echo -e "${C_BLUE}→${C_RESET} $*"; }
_dim()     { echo -e "${C_DIM}$*${C_RESET}"; }

# 加载配置
_load_config() {
    PYVENV_LANG="cn"  # 默认中文
    if [[ -f "$PYVENV_CONFIG" ]]; then
        # shellcheck source=/dev/null
        source "$PYVENV_CONFIG" 2>/dev/null || true
    fi
    export PYVENV_LANG
}

# 保存配置
_save_config() {
    mkdir -p "$PYVENV_HOME"
    cat > "$PYVENV_CONFIG" <<EOF
# pyvenv configuration
PYVENV_LANG="${PYVENV_LANG:-cn}"
EOF
}

# 初始化目录
_init_dirs() {
    mkdir -p "$PYVENV_HOME" "$PYVENV_ENV_DIR" "$PYVENV_BACKUP_DIR" 2>/dev/null || true
}

# 验证环境名称
_valid_name() {
    local name="$1"
    [[ -n "$name" && "$name" =~ ^[a-zA-Z0-9_][a-zA-Z0-9_-]*$ ]]
}

# 检查环境是否存在
_env_exists() {
    [[ -f "$PYVENV_ENV_DIR/$1/bin/activate" ]]
}

# 获取当前激活的环境名
_current_env() {
    [[ -n "${VIRTUAL_ENV:-}" ]] && basename "$VIRTUAL_ENV" || echo ""
}

# 列出所有环境名
_list_envs() {
    local envs=()
    for d in "$PYVENV_ENV_DIR"/*/; do
        [[ -f "${d}bin/activate" ]] && envs+=("$(basename "$d")")
    done
    printf '%s\n' "${envs[@]}"
}

# 获取环境数量
_env_count() {
    local count=0
    for d in "$PYVENV_ENV_DIR"/*/; do
        [[ -f "${d}bin/activate" ]] && ((count++))
    done
    echo "$count"
}

# 获取环境的 Python 版本
_env_python_ver() {
    local py="$PYVENV_ENV_DIR/$1/bin/python"
    [[ -x "$py" ]] && "$py" -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}')" 2>/dev/null || echo "-"
}

# 获取环境的包数量
_env_pkg_count() {
    local pip="$PYVENV_ENV_DIR/$1/bin/pip"
    [[ -x "$pip" ]] && "$pip" list --format=freeze 2>/dev/null | wc -l | tr -d ' ' || echo "0"
}

# 获取环境大小
_env_size() {
    du -sh "$PYVENV_ENV_DIR/$1" 2>/dev/null | cut -f1 || echo "-"
}

# 列出所有备份文件
_list_backups() {
    for f in "$PYVENV_BACKUP_DIR"/*.tar.gz; do
        [[ -f "$f" ]] && basename "$f"
    done
}

# 获取备份数量
_backup_count() {
    local count=0
    for f in "$PYVENV_BACKUP_DIR"/*.tar.gz; do
        [[ -f "$f" ]] && ((count++))
    done
    echo "$count"
}

# 确认（y/N）
_confirm() {
    local prompt="$1" answer
    read -rp "$prompt " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

# 确认输入 yes
_confirm_yes() {
    local prompt="$1" answer
    read -rp "$prompt " answer
    [[ "$answer" == "yes" ]]
}

# 确认输入指定文本
_confirm_text() {
    local expected="$1" prompt="$2" answer
    read -rp "$prompt " answer
    [[ "$answer" == "$expected" ]]
}

# 获取 shell rc 文件
_get_shell_rc() {
    case "${SHELL:-/bin/bash}" in
        */zsh)  echo "${ZDOTDIR:-$HOME}/.zshrc" ;;
        */bash) echo "$HOME/.bashrc" ;;
        *)      echo "$HOME/.bashrc" ;;
    esac
}

# 清理 rc 文件中过多的连续空行（保留最多1个连续空行）
_clean_empty_lines() {
    local file="$1"
    if [[ -f "$file" ]]; then
        local tmp_file="${file}.pyvenv.tmp"
        # 使用 awk 合并连续空行为单个空行，并移除文件末尾的空行
        awk 'NF {blank=0} !NF {blank++} blank<=1' "$file" > "$tmp_file" && mv "$tmp_file" "$file"
    fi
}

# ======================== 命令实现 ========================

# 列出所有环境
_cmd_list() {
    local current=$(_current_env)
    local count=$(_env_count)
    
    _echo ""
    _echo "${C_BOLD}$(_t env_list_title)${C_RESET}  ${C_DIM}$PYVENV_ENV_DIR${C_RESET}"
    _echo ""
    
    if [[ "$count" -eq 0 ]]; then
        _warn "$(_t env_empty_list)"
        _echo ""
        _dim "$(_t env_list_hint)"
        _echo ""
        return 0
    fi
    
    # 表头
    printf "  ${C_BOLD}%-22s %-12s %-8s %s${C_RESET}\n" \
        "$(_t name)" "$(_t python)" "$(_t packages)" "$(_t size)"
    _echo "  $(printf '%.0s─' {1..56})"
    
    while IFS= read -r name; do
        [[ -z "$name" ]] && continue
        local marker="" color=""
        if [[ "$name" == "$current" ]]; then
            marker=" ${C_GREEN}◀${C_RESET}"
            color="$C_GREEN"
        fi
        printf "  ${color}%-22s${C_RESET} %-12s %-8s %s%b\n" \
            "$name" "$(_env_python_ver "$name")" "$(_env_pkg_count "$name")" "$(_env_size "$name")" "$marker"
    done < <(_list_envs)
    
    _echo ""
    _dim "  $(_tf env_count "$count")"
    _echo ""
}

# 创建环境
_cmd_create() {
    local name="$1"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv create <$(_t name)>"
        return 1
    fi
    
    if ! _valid_name "$name"; then
        _error "$(_t err_invalid_name)"
        return 1
    fi
    
    if _env_exists "$name"; then
        _error "$(_t env_exists): $name"
        return 1
    fi
    
    # 查找 Python
    local python_cmd=""
    for cmd in python3 python; do
        if command -v "$cmd" &>/dev/null; then
            python_cmd="$cmd"
            break
        fi
    done
    
    if [[ -z "$python_cmd" ]]; then
        _error "$(_t err_no_python)"
        return 1
    fi
    
    _info "$(_t env_creating): ${C_CYAN}$name${C_RESET}"
    
    if "$python_cmd" -m venv "$PYVENV_ENV_DIR/$name" 2>/dev/null; then
        _success "$(_t env_created): ${C_CYAN}$name${C_RESET}"
        return 0
    else
        _error "$(_t env_create_failed)"
        return 1
    fi
}

# 创建并激活
_cmd_new() {
    local name="$1"
    if _cmd_create "$name"; then
        _cmd_use "$name"
    fi
}

# 激活环境
_cmd_use() {
    local name="$1"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv use <$(_t name)>"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    # 先退出当前环境
    [[ -n "${VIRTUAL_ENV:-}" ]] && deactivate 2>/dev/null
    
    # shellcheck source=/dev/null
    source "$PYVENV_ENV_DIR/$name/bin/activate"
    _success "$(_t env_activated): ${C_CYAN}$name${C_RESET}"
}

# 退出环境
_cmd_off() {
    if [[ -z "${VIRTUAL_ENV:-}" ]]; then
        _warn "$(_t env_no_active)"
        return 0
    fi
    
    local name=$(_current_env)
    deactivate 2>/dev/null
    _success "$(_t env_deactivated): ${C_CYAN}$name${C_RESET}"
}

# 删除环境
_cmd_rm() {
    local name="$1"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv rm <$(_t name)>"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    _echo ""
    if ! _confirm "$(_tf confirm_remove "$name") $(_t confirm_yn)"; then
        _warn "$(_t cancelled)"
        return 0
    fi
    
    # 如果正在使用，先退出
    if [[ "${VIRTUAL_ENV:-}" == "$PYVENV_ENV_DIR/$name" ]]; then
        deactivate 2>/dev/null
        _dim "  $(_t env_remove_active_hint)"
    fi
    
    rm -rf "${PYVENV_ENV_DIR:?}/$name"
    _success "$(_t env_removed): ${C_CYAN}$name${C_RESET}"
}

# 删除所有环境
_cmd_rm_all() {
    local count=$(_env_count)
    
    if [[ "$count" -eq 0 ]]; then
        _warn "$(_t env_empty_list)"
        return 0
    fi
    
    _echo ""
    _warn "$(_tf confirm_remove_all "$count")"
    _echo ""
    
    while IFS= read -r name; do
        [[ -n "$name" ]] && _echo "  ${C_RED}•${C_RESET} $name"
    done < <(_list_envs)
    
    _echo ""
    
    if ! _confirm_yes "$(_t confirm_type_yes): "; then
        _warn "$(_t cancelled)"
        return 0
    fi
    
    # 先退出当前环境
    [[ -n "${VIRTUAL_ENV:-}" ]] && deactivate 2>/dev/null
    
    while IFS= read -r name; do
        [[ -z "$name" ]] && continue
        rm -rf "${PYVENV_ENV_DIR:?}/$name"
        _success "$(_t env_removed): $name"
    done < <(_list_envs)
}

# 复制环境
_cmd_cp() {
    local src="$1" dst="$2"
    
    if [[ -z "$src" || -z "$dst" ]]; then
        _error "$(_t err_missing_arg)"
        _echo "  $(_t usage): pyvenv cp <$(_t source)> <$(_t target)>"
        return 1
    fi
    
    if ! _valid_name "$dst"; then
        _error "$(_t err_invalid_name)"
        return 1
    fi
    
    if ! _env_exists "$src"; then
        _error "$(_t env_not_found): $src"
        return 1
    fi
    
    if [[ "$src" == "$dst" ]]; then
        _error "$(_t err_same_name)"
        return 1
    fi
    
    if _env_exists "$dst"; then
        _error "$(_t env_exists): $dst"
        return 1
    fi
    
    _info "$(_t env_copying): ${C_CYAN}$src${C_RESET} → ${C_CYAN}$dst${C_RESET}"
    cp -a "$PYVENV_ENV_DIR/$src" "$PYVENV_ENV_DIR/$dst"
    _success "$(_t env_copied)"
}

# 重命名环境
_cmd_mv() {
    local src="$1" dst="$2"
    
    if [[ -z "$src" || -z "$dst" ]]; then
        _error "$(_t err_missing_arg)"
        _echo "  $(_t usage): pyvenv mv <$(_t source)> <$(_t target)>"
        return 1
    fi
    
    if ! _valid_name "$dst"; then
        _error "$(_t err_invalid_name)"
        return 1
    fi
    
    if ! _env_exists "$src"; then
        _error "$(_t env_not_found): $src"
        return 1
    fi
    
    if [[ "$src" == "$dst" ]]; then
        _error "$(_t err_same_name)"
        return 1
    fi
    
    if _env_exists "$dst"; then
        _error "$(_t env_exists): $dst"
        return 1
    fi
    
    # 如果正在使用源环境，先退出
    if [[ "${VIRTUAL_ENV:-}" == "$PYVENV_ENV_DIR/$src" ]]; then
        deactivate 2>/dev/null
    fi
    
    _info "$(_t env_renaming): ${C_CYAN}$src${C_RESET} → ${C_CYAN}$dst${C_RESET}"
    mv "$PYVENV_ENV_DIR/$src" "$PYVENV_ENV_DIR/$dst"
    _success "$(_t env_renamed)"
}

# 重置环境
_cmd_reset() {
    local name="${1:-$(_current_env)}"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv reset <$(_t name)>"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    _echo ""
    if ! _confirm "$(_tf confirm_reset "$name") $(_t confirm_yn)"; then
        _warn "$(_t cancelled)"
        return 0
    fi
    
    _info "$(_t env_resetting): ${C_CYAN}$name${C_RESET}"
    
    # 清空 site-packages（保留基础结构）
    local site_pkgs
    site_pkgs=$(find "$PYVENV_ENV_DIR/$name/lib" -type d -name "site-packages" 2>/dev/null | head -1)
    if [[ -n "$site_pkgs" && -d "$site_pkgs" ]]; then
        find "$site_pkgs" -mindepth 1 -maxdepth 1 ! -name 'pip*' ! -name 'setuptools*' ! -name 'pkg_resources*' ! -name '_distutils_hack*' ! -name 'distutils-precedence.pth' -exec rm -rf {} \; 2>/dev/null
    fi
    
    # 升级 pip
    "$PYVENV_ENV_DIR/$name/bin/python" -m pip install --upgrade pip -q 2>/dev/null || true
    
    _success "$(_t env_reset_done): ${C_CYAN}$name${C_RESET}"
}

# 显示环境信息
_cmd_info() {
    local name="${1:-$(_current_env)}"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv info <$(_t name)>"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    local current=$(_current_env)
    local status_text status_color
    if [[ "$name" == "$current" ]]; then
        status_text="$(_t active)"
        status_color="$C_GREEN"
    else
        status_text="$(_t inactive)"
        status_color="$C_DIM"
    fi
    
    local py_ver=$(_env_python_ver "$name")
    local pkg_count=$(_env_pkg_count "$name")
    local env_size=$(_env_size "$name")
    local env_path="$PYVENV_ENV_DIR/$name"
    
    _echo ""
    _echo "${C_BOLD}$(_t env_info_title)${C_RESET}"
    _echo "$(printf '%.0s─' {1..45})"
    _echo ""
    _echo "  ${C_CYAN}$(_t name):${C_RESET}        $name"
    _echo "  ${C_CYAN}$(_t status):${C_RESET}      ${status_color}${status_text}${C_RESET}"
    _echo "  ${C_CYAN}$(_t python):${C_RESET}      $py_ver"
    _echo "  ${C_CYAN}$(_t packages):${C_RESET}    $pkg_count"
    _echo "  ${C_CYAN}$(_t size):${C_RESET}        $env_size"
    _echo "  ${C_CYAN}$(_t path):${C_RESET}        $env_path"
    _echo ""
}

# 显示环境路径
_cmd_where() {
    local name="${1:-$(_current_env)}"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    echo "$PYVENV_ENV_DIR/$name"
}

# 在环境中运行命令
_cmd_run() {
    local name="$1"
    shift || true
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv run <$(_t name)> [--] <$(_t command)>"
        return 1
    fi
    
    # 跳过可选的 --
    [[ "${1:-}" == "--" ]] && shift
    
    if [[ $# -eq 0 ]]; then
        _error "$(_t err_run_no_cmd)"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    local cmd="$1"; shift
    local bin_path="$PYVENV_ENV_DIR/$name/bin"
    
    # 优先使用环境中的命令
    if [[ -x "$bin_path/$cmd" ]]; then
        "$bin_path/$cmd" "$@"
    else
        PATH="$bin_path:$PATH" "$cmd" "$@"
    fi
}

# 升级包
_cmd_update() {
    local name=$(_current_env)
    
    if [[ -z "$name" ]]; then
        _error "$(_t env_no_active)"
        return 1
    fi
    
    local pip_cmd="$PYVENV_ENV_DIR/$name/bin/pip"
    
    _info "$(_t pkg_updating)"
    
    # 获取过期的包
    local outdated
    outdated=$("$pip_cmd" list --outdated --format=json 2>/dev/null | 
               python3 -c "import sys,json; [print(p['name']) for p in json.load(sys.stdin)]" 2>/dev/null) || true
    
    if [[ -z "$outdated" ]]; then
        _success "$(_t pkg_no_outdated)"
        return 0
    fi
    
    # 逐个升级
    while IFS= read -r pkg; do
        [[ -z "$pkg" ]] && continue
        _echo "  ${C_BLUE}↑${C_RESET} $(_t pkg_upgrading): $pkg"
        "$pip_cmd" install -U "$pkg" -q 2>/dev/null || true
    done <<< "$outdated"
    
    _success "$(_t pkg_update_done)"
}

# 备份环境
_cmd_backup() {
    local name="${1:-$(_current_env)}"
    
    if [[ -z "$name" ]]; then
        _error "$(_t err_no_name)"
        _echo "  $(_t usage): pyvenv backup <$(_t name)>"
        return 1
    fi
    
    if ! _env_exists "$name"; then
        _error "$(_t env_not_found): $name"
        return 1
    fi
    
    mkdir -p "$PYVENV_BACKUP_DIR"
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$PYVENV_BACKUP_DIR/${name}_${timestamp}.tar.gz"
    
    _info "$(_t backup_creating): ${C_CYAN}$name${C_RESET}"
    
    tar -czf "$backup_file" -C "$PYVENV_ENV_DIR" "$name" 2>/dev/null
    
    _success "$(_t backup_created)"
    _echo "  $(_t backup_file): ${C_DIM}$backup_file${C_RESET}"
}

# 列出备份
_cmd_backups() {
    local count=$(_backup_count)
    
    _echo ""
    _echo "${C_BOLD}$(_t backup_list_title)${C_RESET}  ${C_DIM}$PYVENV_BACKUP_DIR${C_RESET}"
    _echo ""
    
    if [[ "$count" -eq 0 ]]; then
        _warn "$(_t backup_empty)"
        _echo ""
        return 0
    fi
    
    for f in "$PYVENV_BACKUP_DIR"/*.tar.gz; do
        [[ -f "$f" ]] || continue
        local fname=$(basename "$f")
        local fsize=$(du -h "$f" 2>/dev/null | cut -f1)
        local fdate=$(stat -c %y "$f" 2>/dev/null | cut -d' ' -f1 || stat -f %Sm -t %Y-%m-%d "$f" 2>/dev/null)
        _echo "  ${C_CYAN}•${C_RESET} $fname  ${C_DIM}($fsize, $fdate)${C_RESET}"
    done
    
    _echo ""
    _dim "  $(_tf backup_count "$count")"
    _echo ""
}

# 删除单个备份
_cmd_rm_backup() {
    local backup_name="$1"
    
    if [[ -z "$backup_name" ]]; then
        _error "$(_t err_no_backup_name)"
        _echo "  $(_t usage): pyvenv rm-backup <$(_t file)>"
        return 1
    fi
    
    # 补全 .tar.gz 后缀
    [[ "$backup_name" != *.tar.gz ]] && backup_name="${backup_name}.tar.gz"
    
    local backup_file="$PYVENV_BACKUP_DIR/$backup_name"
    
    if [[ ! -f "$backup_file" ]]; then
        _error "$(_t backup_not_found): $backup_name"
        return 1
    fi
    
    if ! _confirm "$(_tf confirm_remove_backup "$backup_name") $(_t confirm_yn)"; then
        _warn "$(_t cancelled)"
        return 0
    fi
    
    rm -f "$backup_file"
    _success "$(_t backup_removed): ${C_CYAN}$backup_name${C_RESET}"
}

# 删除所有备份
_cmd_rm_all_backups() {
    local count=$(_backup_count)
    
    if [[ "$count" -eq 0 ]]; then
        _warn "$(_t backup_empty)"
        return 0
    fi
    
    _echo ""
    _warn "$(_tf confirm_remove_all_backups "$count")"
    _echo ""
    
    for f in "$PYVENV_BACKUP_DIR"/*.tar.gz; do
        [[ -f "$f" ]] && _echo "  ${C_RED}•${C_RESET} $(basename "$f")"
    done
    
    _echo ""
    
    if ! _confirm_yes "$(_t confirm_type_yes): "; then
        _warn "$(_t cancelled)"
        return 0
    fi
    
    for f in "$PYVENV_BACKUP_DIR"/*.tar.gz; do
        [[ -f "$f" ]] || continue
        rm -f "$f"
        _success "$(_t backup_removed): $(basename "$f")"
    done
}

# 还原备份
_cmd_restore() {
    local backup_file="$1"
    
    if [[ -z "$backup_file" ]]; then
        _error "$(_t err_missing_arg)"
        _echo "  $(_t usage): pyvenv restore <$(_t file)>"
        return 1
    fi
    
    # 补全 .tar.gz 后缀
    [[ "$backup_file" != *.tar.gz ]] && backup_file="${backup_file}.tar.gz"
    
    # 如果只给了文件名，在备份目录中查找
    if [[ ! -f "$backup_file" && -f "$PYVENV_BACKUP_DIR/$backup_file" ]]; then
        backup_file="$PYVENV_BACKUP_DIR/$backup_file"
    fi
    
    if [[ ! -f "$backup_file" ]]; then
        _error "$(_t err_file_not_found): $backup_file"
        return 1
    fi
    
    if [[ ! "$backup_file" =~ \.tar\.gz$ ]]; then
        _error "$(_t err_not_tar_gz)"
        return 1
    fi
    
    # 获取环境名
    local env_name
    env_name=$(tar -tzf "$backup_file" 2>/dev/null | head -1 | cut -d/ -f1)
    
    if [[ -z "$env_name" ]]; then
        _error "$(_t backup_invalid)"
        return 1
    fi
    
    if _env_exists "$env_name"; then
        _error "$(_t env_exists): $env_name"
        return 1
    fi
    
    _info "$(_t restore_starting): ${C_CYAN}$env_name${C_RESET}"
    
    tar -xzf "$backup_file" -C "$PYVENV_ENV_DIR" 2>/dev/null
    
    _success "$(_t restore_done)"
    _echo "  $(_t restore_env_name): ${C_CYAN}$env_name${C_RESET}"
}

# 设置语言
_cmd_lang() {
    local lang="$1"
    
    if [[ -z "$lang" ]]; then
        _echo "$(_t lang_current): ${C_CYAN}$(_t lang_${PYVENV_LANG})${C_RESET} (${PYVENV_LANG})"
        return 0
    fi
    
    case "$lang" in
        cn|zh|chinese)
            PYVENV_LANG="cn"
            _save_config
            _success "$(_t lang_changed): $(_t lang_cn) (cn)"
            ;;
        en|english)
            PYVENV_LANG="en"
            _save_config
            _success "$(_t lang_changed): $(_t lang_en) (en)"
            ;;
        *)
            _error "$(_t lang_invalid)"
            return 1
            ;;
    esac
}

# 卸载
_cmd_uninstall() {
    local count=$(_env_count)
    local shell_rc=$(_get_shell_rc)
    
    _echo ""
    _echo "${C_BOLD}$(_t uninstall_title)${C_RESET}"
    _echo "$(printf '%.0s─' {1..45})"
    _echo ""
    _echo "$(_t uninstall_menu)"
    _echo ""
    _echo "  ${C_CYAN}1)${C_RESET} $(_t uninstall_opt1)"
    _echo "  ${C_CYAN}2)${C_RESET} $(_t uninstall_opt2)"
    _echo "  ${C_CYAN}3)${C_RESET} $(_t uninstall_opt3)"
    _echo ""
    
    local choice
    read -rp "$(_t uninstall_select): " choice
    
    case "$choice" in
        1)
            _echo ""
            _info "$(_t uninstall_removing)"
            _do_uninstall_manager
            _echo ""
            _success "$(_t uninstall_done)"
            _echo "  $(_t uninstall_env_kept): ${C_DIM}$PYVENV_ENV_DIR${C_RESET}"
            _echo ""
            _echo "$(_t uninstall_hint)"
            _echo "  ${C_DIM}curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install${C_RESET}"
            _echo ""
            _success "$(_t uninstall_complete)"
            _echo ""
            # 重新加载 shell 配置
            # shellcheck source=/dev/null
            source "$shell_rc" 2>/dev/null || true
            ;;
        2)
            if [[ "$count" -gt 0 ]]; then
                _echo ""
                _warn "$(_tf confirm_remove_all "$count")"
                _echo ""
            fi
            
            if ! _confirm_yes "$(_t confirm_type_yes): "; then
                _warn "$(_t cancelled)"
                return 0
            fi
            
            _echo ""
            _info "$(_t uninstall_removing)"
            
            # 先退出环境
            [[ -n "${VIRTUAL_ENV:-}" ]] && deactivate 2>/dev/null
            
            # 删除所有环境
            rm -rf "$PYVENV_ENV_DIR"
            
            _do_uninstall_manager
            
            _echo ""
            _success "$(_t uninstall_done)"
            _success "$(_t uninstall_all_removed)"
            _echo ""
            _echo "$(_t uninstall_hint)"
            _echo "  ${C_DIM}curl -fsSL https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh | bash -s -- install${C_RESET}"
            _echo ""
            _success "$(_t uninstall_complete)"
            _echo ""
            # 重新加载 shell 配置
            # shellcheck source=/dev/null
            source "$shell_rc" 2>/dev/null || true
            ;;
        *)
            _warn "$(_t cancelled)"
            ;;
    esac
}

# 执行卸载管理器
_do_uninstall_manager() {
    local shell_rc=$(_get_shell_rc)
    
    # 从 rc 文件移除配置行
    if [[ -f "$shell_rc" ]]; then
        local tmp_file="${shell_rc}.pyvenv.tmp"
        # 移除包含 .pyvenv 的行和 pyvenv 注释行
        grep -v -E '\.pyvenv|^# pyvenv' "$shell_rc" > "$tmp_file" 2>/dev/null && mv "$tmp_file" "$shell_rc"
        # 清理过多的连续空行
        _clean_empty_lines "$shell_rc"
    fi
    
    # 删除配置目录
    rm -rf "$PYVENV_HOME"
    
    # 取消函数定义
    unset -f pyvenv 2>/dev/null || true
}

# 帮助信息
_cmd_help() {
    _echo ""
    _echo "${C_BOLD}$(_t help_header)${C_RESET}  ${C_DIM}v${PYVENV_VERSION}${C_RESET}"
    _echo ""
    _echo "$(_t help_usage)"
    _echo ""
    _echo "${C_BOLD}$(_t help_commands)${C_RESET}"
    _echo ""
    
    _echo "  ${C_YELLOW}$(_t help_section_basic)${C_RESET}"
    _echo "    ${C_CYAN}list, ls${C_RESET}                    $(_t help_cmd_list)"
    _echo "    ${C_CYAN}new, add${C_RESET} <name>             $(_t help_cmd_new)"
    _echo "    ${C_CYAN}use, on${C_RESET} <name>              $(_t help_cmd_use)"
    _echo "    ${C_CYAN}quit ,exit, off${C_RESET}             $(_t help_cmd_off)"
    _echo ""
    
    _echo "  ${C_YELLOW}$(_t help_section_manage)${C_RESET}"
    _echo "    ${C_CYAN}create${C_RESET} <name>               $(_t help_cmd_create)"
    _echo "    ${C_CYAN}rm, remove${C_RESET} <name>           $(_t help_cmd_rm)"
    _echo "    ${C_CYAN}rm-all${C_RESET}                      $(_t help_cmd_rm_all)"
    _echo "    ${C_CYAN}cp, copy${C_RESET} <src> <dst>        $(_t help_cmd_cp)"
    _echo "    ${C_CYAN}mv, rename${C_RESET} <old> <new>      $(_t help_cmd_mv)"
    _echo "    ${C_CYAN}reset${C_RESET} [name]                $(_t help_cmd_reset)"
    _echo "    ${C_CYAN}info${C_RESET} [name]                 $(_t help_cmd_info)"
    _echo "    ${C_CYAN}where${C_RESET} [name]                $(_t help_cmd_where)"
    _echo "    ${C_CYAN}run${C_RESET} <name> -- <cmd>         $(_t help_cmd_run)"
    _echo ""
    
    _echo "  ${C_YELLOW}$(_t help_section_package)${C_RESET}"
    _echo "    ${C_CYAN}update, upgrade${C_RESET}             $(_t help_cmd_update)"
    _echo ""
    
    _echo "  ${C_YELLOW}$(_t help_section_backup)${C_RESET}"
    _echo "    ${C_CYAN}backup${C_RESET} [name]               $(_t help_cmd_backup)"
    _echo "    ${C_CYAN}backups${C_RESET}                     $(_t help_cmd_backups)"
    _echo "    ${C_CYAN}restore, recover${C_RESET} <file>     $(_t help_cmd_restore)"
    _echo "    ${C_CYAN}rm-backup${C_RESET} <file>            $(_t help_cmd_rm_backup)"
    _echo "    ${C_CYAN}rm-all-backups${C_RESET}              $(_t help_cmd_rm_all_backups)"
    _echo ""
    
    _echo "  ${C_YELLOW}$(_t help_section_other)${C_RESET}"
    _echo "    ${C_CYAN}lang${C_RESET} [cn|en]                $(_t help_cmd_lang)"
    _echo "    ${C_CYAN}uninstall${C_RESET}                   $(_t help_cmd_uninstall)"
    _echo "    ${C_CYAN}help, -h${C_RESET}                    $(_t help_cmd_help)"
    _echo "    ${C_CYAN}version, -v${C_RESET}                 $(_t help_cmd_version)"
    _echo ""
    
    _echo "${C_BOLD}$(_t help_examples)${C_RESET}"
    _echo ""
    _echo "  ${C_DIM}# $(_t help_ex_new)${C_RESET}"
    _echo "  pyvenv new myproject"
    _echo ""
    _echo "  ${C_DIM}# $(_t help_ex_use)${C_RESET}"
    _echo "  pyvenv use myproject"
    _echo ""
    _echo "  ${C_DIM}# $(_t help_ex_run)${C_RESET}"
    _echo "  pyvenv run myproject -- pip list"
    _echo ""
    
    _echo "${C_BOLD}$(_t help_dirs)${C_RESET}"
    _echo ""
    _echo "  ${C_CYAN}~/pyvenv/${C_RESET}        $(_t help_dir_envs)"
    _echo "  ${C_CYAN}~/.pyvenv/${C_RESET}       $(_t help_dir_config)"
    _echo ""
}

# 版本信息
_cmd_version() {
    _echo ""
    _echo "${C_BOLD}$(_tf version_info "$PYVENV_VERSION")${C_RESET}"
    _echo "$(_t version_author)"
    _echo ""
    _echo "https://github.com/eraycc/pyvenv"
    _echo ""
}

# ======================== 安装入口 ========================

_do_install() {
    local lang="${1:-cn}"
    local force="${2:-}"
    
    # 验证语言
    [[ "$lang" != "cn" && "$lang" != "en" ]] && lang="cn"
    PYVENV_LANG="$lang"
    
    # 检查是否已安装
    if [[ -f "$PYVENV_SCRIPT" && "$force" != "--force" ]]; then
        _echo ""
        _warn "$(_t install_already)"
        _echo ""
        _dim "  $(_t install_force_hint)"
        _echo ""
        exit 0
    fi
    
    _echo ""
    _info "$(_t install_starting)"
    
    # 创建目录
    mkdir -p "$PYVENV_HOME" "$PYVENV_ENV_DIR" "$PYVENV_BACKUP_DIR"
    
    # 下载脚本
    _info "$(_t install_downloading)"
    local script_url="https://raw.githubusercontent.com/eraycc/pyvenv/main/pyvenv.sh"
    
    if ! curl -fsSL "$script_url" -o "$PYVENV_SCRIPT" 2>/dev/null; then
        _error "$(_t err_download_failed)"
        exit 1
    fi
    
    chmod +x "$PYVENV_SCRIPT"
    
    # 保存配置
    _info "$(_t install_configuring)"
    cat > "$PYVENV_CONFIG" <<EOF
# pyvenv configuration
PYVENV_LANG="$lang"
EOF
    
    # 配置 shell rc
    local shell_rc=$(_get_shell_rc)
    local source_line='[ -f ~/.pyvenv/pyvenv.sh ] && source ~/.pyvenv/pyvenv.sh'
    
    # 移除旧配置（如果有）
    if [[ -f "$shell_rc" ]]; then
        grep -v -E '\.pyvenv|^# pyvenv' "$shell_rc" > "${shell_rc}.tmp" 2>/dev/null && mv "${shell_rc}.tmp" "$shell_rc"
        # 清理过多的连续空行
        _clean_empty_lines "$shell_rc"
    fi
    
    # 添加新配置
    {
        echo ""
        echo "# pyvenv - Python virtual environment manager"
        echo "$source_line"
    } >> "$shell_rc"
    
    _echo ""
    _success "$(_t install_success)"
    _echo ""
    _success "$(_t install_ready)"
    _echo ""
    _echo "$(_t install_try_now)"
    _echo ""
    _echo "  ${C_CYAN}pyvenv help${C_RESET}"
    _echo "  ${C_CYAN}pyvenv new myenv${C_RESET}"
    _echo ""
    _warn "$(_t install_note)"
    _echo "  ${C_DIM}source $shell_rc${C_RESET}"
    _echo ""
    # 重新加载 shell 配置
    # shellcheck source=/dev/null
    source "$shell_rc" 2>/dev/null || true
}

# curl 卸载入口
_do_curl_uninstall() {
    # 尝试加载配置获取语言
    [[ -f "$PYVENV_CONFIG" ]] && source "$PYVENV_CONFIG" 2>/dev/null
    PYVENV_LANG="${PYVENV_LANG:-cn}"
    
    local shell_rc=$(_get_shell_rc)
    
    _echo ""
    _info "$(_t uninstall_removing)"
    
    _do_uninstall_manager
    
    _echo ""
    _success "$(_t uninstall_done)"
    _echo "  $(_t uninstall_env_kept): ${C_DIM}$PYVENV_ENV_DIR${C_RESET}"
    _echo ""
    _success "$(_t uninstall_complete)"
    _echo ""
    
    # 重新加载 shell 配置
    # shellcheck source=/dev/null
    source "$shell_rc" 2>/dev/null || true
}

# ======================== 自动补全 ========================

_pyvenv_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    local commands="list ls new add create use on off quit exit deactivate rm remove rm-all cp copy mv rename reset info where run update upgrade backup backups restore recover rm-backup rm-all-backups lang language uninstall help version"
    
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return
    fi
    
    case "$prev" in
        use|on|rm|remove|info|where|backup|reset|run|cp|copy|mv|rename)
            local envs=$(_list_envs 2>/dev/null | tr '\n' ' ')
            COMPREPLY=($(compgen -W "$envs" -- "$cur"))
            ;;
        lang|language)
            COMPREPLY=($(compgen -W "cn en" -- "$cur"))
            ;;
        restore|recover|rm-backup)
            local backups=$(_list_backups 2>/dev/null | tr '\n' ' ')
            COMPREPLY=($(compgen -W "$backups" -- "$cur"))
            ;;
    esac
}

# ======================== 主入口 ========================

pyvenv() {
    local cmd="${1:-help}"
    shift 2>/dev/null || true
    
    case "$cmd" in
        # 基础命令
        list|ls)                           _cmd_list ;;
        new|add)                           _cmd_new "$@" ;;
        create)                            _cmd_create "$@" ;;
        use|on|activate|workon)            _cmd_use "$@" ;;
        off|quit|exit|deactivate)          _cmd_off ;;
        
        # 环境管理
        rm|remove|delete)                  _cmd_rm "$@" ;;
        rm-all|remove-all|delete-all)      _cmd_rm_all ;;
        cp|copy|clone)                     _cmd_cp "$@" ;;
        mv|rename)                         _cmd_mv "$@" ;;
        reset)                             _cmd_reset "$@" ;;
        info)                              _cmd_info "$@" ;;
        where|whereis|path)                _cmd_where "$@" ;;
        run)                               _cmd_run "$@" ;;
        
        # 包管理
        update|upgrade)                    _cmd_update ;;
        
        # 备份还原
        backup)                            _cmd_backup "$@" ;;
        backups|backup-list)               _cmd_backups ;;
        restore|recover)                   _cmd_restore "$@" ;;
        rm-backup|rm-bak|remove-backup|remove-bak|delete-backup|delete-bak)
                                           _cmd_rm_backup "$@" ;;
        rm-all-backups|rm-all-bak|remove-all-backups|remove-all-bak|delete-all-backups|delete-all-bak)
                                           _cmd_rm_all_backups ;;
        
        # 其他
        lang|language)                     _cmd_lang "$@" ;;
        uninstall)                         _cmd_uninstall ;;
        help|-h|--help)                    _cmd_help ;;
        version|-v|--version)              _cmd_version ;;
        
        *)
            _error "$(_t err_cmd_not_found): $cmd"
            _echo ""
            _echo "$(_t usage): pyvenv help"
            return 1
            ;;
    esac
}

# ======================== 脚本执行入口 ========================

# 处理 curl 安装/卸载
if [[ "${1:-}" == "install" ]]; then
    shift
    _do_install "$@"
    exit 0
elif [[ "${1:-}" == "uninstall" && "${BASH_SOURCE[0]:-}" != "${0:-}" ]]; then
    _do_curl_uninstall
    exit 0
fi

# 正常 source 加载时的初始化
_init_dirs
_load_config

# 注册自动补全
if [[ -n "${BASH_VERSION:-}" ]]; then
    complete -F _pyvenv_completions pyvenv 2>/dev/null
elif [[ -n "${ZSH_VERSION:-}" ]]; then
    autoload -Uz compinit && compinit -u 2>/dev/null
    autoload -Uz bashcompinit && bashcompinit 2>/dev/null
    complete -F _pyvenv_completions pyvenv 2>/dev/null
fi
