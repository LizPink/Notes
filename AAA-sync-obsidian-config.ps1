# Obsidian 配置同步脚本
# 用法：在 Notes 根目录运行： .\AAA-sync-obsidian-config-fixed.ps1
# 作用：把 AAA-Obsidian-Shared-Config 同步到每个 Vault 的 .obsidian 文件夹中

# 当前脚本所在目录，也就是你的 Notes 根目录
$root = $PSScriptRoot

# 主配置目录：这里存放的是要同步给所有 Vault 的 Obsidian 配置
$source = Join-Path $root "AAA-Obsidian-Shared-Config"

# 需要同步的 Vault 列表
# 注意：这里写的是 Notes 文件夹下面的子文件夹名称
$vaultNames = @(
    "Data Science",
    "Machine Learning",
    "Mathematics",
    "Programing Languages"
)

# 检查主配置目录是否存在
if (-not (Test-Path $source)) {
    Write-Host "错误：找不到主配置目录：$source"
    exit 1
}

foreach ($vaultName in $vaultNames) {
    $vault = Join-Path $root $vaultName
    $target = Join-Path $vault ".obsidian"

    if (-not (Test-Path $vault)) {
        Write-Host "跳过：找不到 Vault：$vault"
        continue
    }

    if (-not (Test-Path $target)) {
        New-Item -ItemType Directory -Path $target | Out-Null
    }

    Write-Host "正在同步到：$vaultName"

    # /E：复制所有子文件夹，包括空文件夹；不会删除目标中多余文件，比 /MIR 更安全
    # /R:2 /W:1：失败时重试 2 次，每次等待 1 秒
    # /XD：排除文件夹
    # /XF：排除文件
    $robocopyArgs = @(
        $source,
        $target,
        "/E",
        "/R:2",
        "/W:1",
        "/XD", ".trash",
        "/XF",
        "workspace.json",
        "workspace-mobile.json",
        "graph.json",
        "bookmarks.json"
    )

    & robocopy @robocopyArgs | Out-Host

    # robocopy 的退出码 0-7 通常都表示可接受结果；大于 7 才是真正错误
    if ($LASTEXITCODE -gt 7) {
        Write-Host "错误：同步 $vaultName 时 robocopy 失败，退出码：$LASTEXITCODE"
        exit $LASTEXITCODE
    }

    Write-Host "完成：$vaultName"
}

Write-Host "全部 Vault 同步完成。"
