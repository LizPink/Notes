Git以及Git衍生出来的应用软件是一种分布式版本控制数据库系统。
# 基本概念
Git包括三个主要的交互概念：工作区、暂存区、本地仓库。日常的使用流程是：当我们在本地修改完成文件内容时，一般统一提交修改过后的文件进入暂存区内，然后统一提交新版本到本地仓库中存储。


# 工作流程
常见的工作流程有两种（1）开发本地仓库再保存至远程仓库中；（2）根据已有的远程仓库进行开发。其中
```sh
# 工作流程1
## 本地新建仓库
git init -b master
## 关联远程仓库
git add remote <远程仓库名> <url>	# 默认给远程仓库取名为origin
## 关联远程分支
git branch -u <远程仓库名/远程分支名> <本地分支名>	# （1）或提交本地时再建立关联
 
## 本地分支修改并提交
git add
git commit
git push		#（1）git push -u <远程仓库名> <远程分支名>

```
```sh
# 工作流程2
## 克隆远程仓库（自动完成本地仓库创建 + 远程仓库关联 + 本地分支创建 + 远程分支关联）
git clone <url>

## 本地分支修改并提交
git switch ...
...
git add ...
git commit ...
git push
```


## 仓库管理
### 新建仓库
```sh
# 新建本地仓库
git init
git init -b <分支名>
```
```sh
# 复制远程仓库（自动完成本地仓库创建 + 远程仓库关联 + 本地分支创建 + 远程分支关联）
git clone <url>

## Example1
git clone https://github.com/LizPink/Elementary-Note-of-Python.git
```

### 查看仓库
```sh
# 查看目前关联的远程仓库
git remote		# 查看仓库名
git remote -v	# 查看仓库详细信息

## Example1
git remote add origin https://github.com/LizPink/Elementary-Note-of-Python.git
git remote		# 查看关联的远程仓库名
out[0]:
origin
```

### 关联仓库
关联主要包括两个方面：关联仓库和关联对应分支。这里先介绍仓库层面的关联。
```sh
# 关联远程仓库，并为远程仓库取名字
git remote  add <远程仓库名> <url>

## Example1
git remote add origin https://github.com/LizPink/Elementary-Note-of-Python.git
```

## 分支管理
### 新建分支
```sh
git branch <新分支名> && git switch <新分支名>
git switch (-c|-C) <新分支名>
git branch -m <新分支名>		# 重新命名所在分支
git fetch <远程仓库名>		# 下载远程仓库的分支信息


## Example1
git switch oldBranch		# 切换到被命名的分支上
git branch -m newBranch	# 修改分支名称

## Example2
```

### 删除分支
```sh
# 删除本地分支
git branch -d <被删除的分支>
# 删除远程分支
git push <仓库名> --delete <被删除的分支>

## Example1
git switch main && git branch -d otherBranch
```

### 查看分支

查看分支分为三个方面：查看分支名、查看分支日志、对比分支日志。
```sh
# 查看分支名
git status			# 查看当前所在分支
git branch (-v/-vv)	# 查看仓库的本地分支
git branch -r		# 查看仓库的远程分支
git branch --all 	# 查看本地和远程分支

## Example1
git remote add origin
git fetch origin		# 拉取远程分支信息
git branch --all		# 查看本地和远程分支名
out[0]:
*master
feature/add-preprocessing
remotes/origin/HEAD -> origin/master
remotes/origin/master
```
```sh
# 查看分支日志
git log
git log -r
git log --all
git log --graph --all

## Example1
git add remote origin https://github.com/LizPink/Elementary-Note-of-Python.git
git fetch origin	# 拉取远程分支信息
git log --all		# 查看所有分支日志
```
```sh
# 比较分支日志
git diff <分支名1> <分支名2>
git diff			# 比较工作区和暂存区
git diff HEAD		# 比较工作区和本地仓库
git diff --cached	# 比较暂存区和本地仓库

## Example1
git diff main origin/master

## Example2
git diff HEAD HEAD^
git diff HEAD HEAD^2
git diff HEAD HEAD^2 file1.txt
```

### 关联分支
```sh
git branch -u <远程仓库名/远程分支名> <本地分支名>
git push -u <远程仓库名/远程分支名>

### Example1
git remote add origin https://github.com/LizPink/Elementary-Note-of-Python.git
git fetch origin
git branch -u origin/master master
```

### 合并分支
不同分支之间合并的基本语法如下。在Git中两条分支之间的合并主要涉及两种情况：前向合并和交叉合并。
```sh
git merge <被合并的分支>
git rebase <作为基的分支>
git pull <远程仓库名> <远程分支名>

## Example1
git switch main								# 切换到主分支
git merge feature/add-preprocessing		# 合并入主分支
git branch -d add-preprocessing			# 合并成功后删除旧分支（可选）
```

### 回退分支
```sh
## 回退到对应id版本，并且保留工作区和暂存区的修改内容
git reset --soft <id>
git reset --hard <id>
git reset --mix  <id>

### Example1
git reset --soft 64989ff

### Example2
git reset --soft HEAD^
```

## 文件管理
### 提交文件
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

### 删除文件
```sh
## 删除暂存区中的文件
git rm --cached

### Example1
git rm file1.txt
### Example2
git rm -r	# 递归删除某个文件夹下的子文件夹和文件
```
### 忽略文件
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
```sh
# 下载远程仓库文件到本地
git clone <url>				# 初次使用
git switch <分支名>			# 后续使用
git pull origin <分支名>



# 本地修改并提交至暂存区
git switch -c newBranch
git add ...
git commit -m "Update new content."

# 关联本地分支与远程仓库分支，并提交对应修改
git push -u origin newBranch	# 初次使用
git push						# 后续使用


```
