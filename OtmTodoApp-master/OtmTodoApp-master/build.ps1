# build.ps1 - portable one-command build
$ErrorActionPreference = "Stop"

# Use mvnw if present, else mvn
$mvn = if (Test-Path ".\mvnw.cmd") { ".\mvnw.cmd" } else { "mvn" }

# Build, test, package
& $mvn -B clean verify package

# Reports
& $mvn -B jacoco:report
& $mvn -B javadoc:javadoc
& $mvn -B jxr:jxr checkstyle:checkstyle

# Dependency tree (NOTE THE QUOTES!)
New-Item -ItemType Directory -Force -Path target | Out-Null
& $mvn -B dependency:tree "-DoutputFile=target\dependency-tree.txt"

Write-Host "`n Build complete. JAR in target/, reports in target/site/"
