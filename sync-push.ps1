# Script tu dong day nhanh hien tai len ca 4 repository:
# 1. Organization Monorepo (MajorMatch-Labs/MajorMatch)
# 2. Personal Monorepo (NhatPrv/MajorMatch)
# 3. Organization Client (MajorMatch-Labs/majormatch-client)
# 4. Organization Backend (MajorMatch-Labs/majormatch-backend-hpc)

$currentBranch = (git branch --show-current).Trim()

if (-not $currentBranch) {
    Write-Host "[ERROR] Khong xac dinh duoc nhanh Git hien tai!" -ForegroundColor Red
    exit 1
}

Write-Host ">>> [1/4] Dang day nhanh '$currentBranch' len repo to Organization (MajorMatch-Labs/MajorMatch)..." -ForegroundColor Cyan
git push origin $currentBranch

Write-Host ">>> [2/4] Dang day nhanh '$currentBranch' len repo ca nhan (NhatPrv/MajorMatch)..." -ForegroundColor Cyan
try {
    git push personal $currentBranch
} catch {
    Write-Host ">>> Loi hoac bo qua push len repo ca nhan." -ForegroundColor Yellow
}

Write-Host ">>> [3/4] Dang trich xuat folder client va day len repo con (majormatch-client)..." -ForegroundColor Cyan
try {
    git subtree push --prefix=client client-remote $currentBranch
} catch {
    Write-Host ">>> Bo qua client hoac chua co commit moi trong client." -ForegroundColor Yellow
}

Write-Host ">>> [4/4] Dang trich xuat folder backend-hpc va day len repo con (majormatch-backend-hpc)..." -ForegroundColor Cyan
try {
    git subtree push --prefix=backend-hpc backend-remote $currentBranch
} catch {
    Write-Host ">>> Bo qua backend-hpc hoac chua co commit moi trong backend-hpc." -ForegroundColor Yellow
}

Write-Host ">>> [SUCCESS] Dong bo hoan tat len toan bo 4 repository cho nhanh: $currentBranch" -ForegroundColor Green
