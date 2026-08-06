Git以及Git衍生出来的应用软件是一种分布式版本控制数据库系统。
# 基本概念
Git包括三个主要的交互概念：工作区、暂存区、本地仓库。日常的使用流程是：当我们在本地修改完成文件内容时，一般统一提交修改过后的文件进入暂存区内，然后统一提交新版本到本地仓库中存储。


# 工作流程
## 新建仓库
```sh
git init
```
## 关联仓库
```sh
git add remote <short_name="origin"><url>

### Example1
git add remote origin ...
git push -u origin main:main
```

## 新建分支
```sh
git branch <分支名>
git switch <分支名>
```

## 删除分支
```sh
git branch -d <被删除的分支>
```
## 合并分支
```sh
git merge <被合并的分支>
```
```sh
git rebase <作为基的分支>
```

## 提交文件
```sh
# 查看仓库的状态
git status
```
```sh
## 将后缀为.txt的修改文件添加到暂存区
git add *.txt

## 将所有修改文件添加到暂存区
git add .
```
```sh
# 将所有暂存区的文件提交到本地仓库
git commit -m "Commit Content..."
```

## 拉取文件
```sh
git pull <远程仓库名> <远程分支>:<本地分支>

### Example1
git pull origin main:mian
```

## 删除文件
```sh
## 删除暂存区中的文件（进而删除最新版本库中的文件）
git rm --cached

### Example1
git rm file1.txt
### Example2
git rm -r	# 递归删除某个文件夹下的子文件夹和文件
```

## 版本查看
```sh
# 查看版本提交记录
git log --oneline
```
```sh
# 查看版本差异
## 比较工作区和暂存区
git diff
## 比较工作区和版本库
git diff HEAD
## 比较暂存区和版本库
git diff --cached

### Example1
git diff HEAD HEAD^
git diff HEAD HEAD^2
git diff HEAD HEAD^2 file1.txt
```

## 版本回退
```sh
## 回退到对应id版本，并且保留工作区和暂存区的修改内容
git reset --soft
git reset --hard
git reset --mix

### Example1
git reset --soft 64989ff

### Example2
git reset --soft HEAD^
```

## 版本忽略
```sh
.gitignore
```


# 流程规范
## Git Flow

|         |     |
| ------- | --- |
| main    |     |
| hotfix  |     |
| release |     |
| develop |     |
| feature |     |

## GitHub Flow