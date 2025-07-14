#!/bin/bash

# 配置变量
REPO_DIR="/home/flaggems"  # 本地仓库目录
GITHUB_REPO="https://github.com/FlagOpen/FlagGems.git"  # GitHub仓库地址
GITEE_REPO="git@gitee.com:leopold0801/flaggems.git"   # Gitee仓库地址
BRANCH="master"                        # 同步的分支名称

cd /home
git clone "$GITHUB_REPO" flaggems
cd "$REPO_DIR" || exit 1

# 添加双远程仓库
git remote add github $GITHUB_REPO 2>/dev/null
git remote add gitee "$GITEE_REPO" 2>/dev/null

# 从GitHub拉取最新代码
echo "从GitHub拉取更新..."
git pull github "$BRANCH"

# 推送到Gitee
echo "推送到Gitee..."
git push gitee "$BRANCH"

# 显示同步结果
if [ $? -eq 0 ]; then
  echo "$(date) - 同步成功" >> /var/log/sync_repo.log
else
  echo "$(date) - 同步失败" >> /var/log/sync_repo.log
fi
