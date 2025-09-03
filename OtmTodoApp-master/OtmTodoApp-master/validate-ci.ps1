# PowerShell script to validate CI setup locally
Write-Host "🔍 Validating CI Setup..." -ForegroundColor Cyan

# Check if .github/workflows directory exists
if (Test-Path ".github\workflows") {
    Write-Host "✅ .github/workflows directory exists" -ForegroundColor Green
} else {
    Write-Host "❌ .github/workflows directory missing" -ForegroundColor Red
    exit 1
}

# Check for workflow files
$workflowFiles = Get-ChildItem ".github\workflows\*.yml" -ErrorAction SilentlyContinue
if ($workflowFiles.Count -gt 0) {
    Write-Host "✅ Found $($workflowFiles.Count) workflow file(s):" -ForegroundColor Green
    foreach ($file in $workflowFiles) {
        Write-Host "   - $($file.Name)" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ No workflow files found" -ForegroundColor Red
    exit 1
}

# Check pom.xml exists
if (Test-Path "pom.xml") {
    Write-Host "✅ pom.xml found" -ForegroundColor Green
} else {
    Write-Host "❌ pom.xml missing" -ForegroundColor Red
    exit 1
}

# Test Maven build locally
Write-Host "`n🧪 Testing Maven build locally..." -ForegroundColor Cyan
try {
    $mvnPath = ".\apache-maven-3.9.6\bin\mvn.cmd"
    if (Test-Path $mvnPath) {
        Write-Host "Using local Maven installation..." -ForegroundColor Yellow
        & $mvnPath clean compile test -q
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Local Maven build successful" -ForegroundColor Green
        } else {
            Write-Host "❌ Local Maven build failed" -ForegroundColor Red
        }
    } else {
        Write-Host "⚠️ Local Maven not found, skipping build test" -ForegroundColor Yellow
    }
} catch {
    Write-Host "⚠️ Could not test Maven build: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Validate YAML syntax (basic check)
Write-Host "`n📝 Validating YAML syntax..." -ForegroundColor Cyan
foreach ($file in $workflowFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match "name:" -and $content -match "on:" -and $content -match "jobs:") {
        Write-Host "✅ $($file.Name) has basic YAML structure" -ForegroundColor Green
    } else {
        Write-Host "❌ $($file.Name) missing required YAML sections" -ForegroundColor Red
    }
}

Write-Host "`n🎉 CI Setup Validation Complete!" -ForegroundColor Green
Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Commit and push your changes to GitHub" -ForegroundColor White
Write-Host "2. Go to your repository Actions tab" -ForegroundColor White
Write-Host "3. Enable the workflow" -ForegroundColor White
Write-Host "4. Create a test commit to trigger the CI" -ForegroundColor White
Write-Host "`n📖 See CI-SETUP-GUIDE.md for detailed instructions" -ForegroundColor Yellow
