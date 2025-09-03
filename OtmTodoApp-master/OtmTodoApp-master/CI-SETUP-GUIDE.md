# Continuous Integration Setup Guide

## Overview
This guide will help you set up GitHub Actions CI/CD for your Java + Maven TodoApp project.

## Prerequisites
- GitHub account
- Repository hosted on GitHub
- Maven project with `pom.xml`

## Setup Steps

### 1. Repository Setup
1. **Push your code to GitHub** (if not already done):
   ```bash
   git add .
   git commit -m "Add CI workflow"
   git push origin main
   ```

### 2. GitHub Actions Workflow Files
Two workflow files have been created:

#### Option A: Enhanced CI Pipeline (`ci.yml`)
- **Features**: Caching, artifact uploads, PR comments, multiple triggers
- **Best for**: Production projects with active development

#### Option B: Simple CI Pipeline (`ci-simple.yml`)
- **Features**: Basic build, test, and coverage
- **Best for**: Learning or simple projects

### 3. Activate GitHub Actions
1. Go to your GitHub repository
2. Click on the **"Actions"** tab
3. You should see your workflow files listed
4. Click on **"CI Pipeline"** or **"Simple CI Pipeline"**
5. Click **"Enable workflow"**

### 4. Trigger Your First Build
The CI will automatically run when you:
- Push code to `main`, `master`, or `develop` branches
- Create a pull request to these branches
- Manually trigger from the Actions tab

## Workflow Features

### Enhanced CI Pipeline Features:
- ✅ **Multi-branch support** (main, master, develop)
- ✅ **Maven dependency caching** (faster builds)
- ✅ **Test result artifacts** (downloadable reports)
- ✅ **Coverage report artifacts** (JaCoCo reports)
- ✅ **JAR artifact uploads** (built applications)
- ✅ **PR comments** (automatic test result summaries)
- ✅ **Java 17 with Temurin distribution**

### Simple CI Pipeline Features:
- ✅ **Basic build and test**
- ✅ **Coverage report generation**
- ✅ **Java 17 setup**

## Monitoring CI Runs

### 1. View Build Status
- Go to **Actions** tab in your repository
- Click on any workflow run to see details
- Green checkmark = Success ✅
- Red X = Failure ❌
- Yellow circle = In Progress ⏳

### 2. Download Artifacts
- Click on a successful build
- Scroll to **"Artifacts"** section
- Download:
  - `test-results`: Test execution reports
  - `coverage-reports`: JaCoCo coverage HTML reports
  - `jar-artifacts`: Built JAR files

### 3. View Coverage Reports
1. Download `coverage-reports` artifact
2. Extract the ZIP file
3. Open `index.html` in a web browser
4. View detailed coverage metrics

## Troubleshooting

### Common Issues:

#### 1. "No workflow file found"
- Ensure `.github/workflows/` directory exists
- Check file is named `ci.yml` or `ci-simple.yml`
- Verify YAML syntax is correct

#### 2. "Java version not found"
- The workflow uses Java 17 (Temurin distribution)
- Ensure your `pom.xml` is compatible with Java 17
- Check Maven compiler plugin configuration

#### 3. "Tests failing"
- Check test output in Actions logs
- Ensure all dependencies are in `pom.xml`
- Verify test files are in `src/test/java/`

#### 4. "Maven build failing"
- Check for compilation errors
- Verify all required dependencies
- Ensure `pom.xml` is valid

### Debug Steps:
1. **Check Actions logs**: Click on failed step for detailed error messages
2. **Test locally**: Run `mvn clean test` on your machine
3. **Validate YAML**: Use online YAML validators
4. **Check permissions**: Ensure GitHub Actions is enabled for your repository

## Customization Options

### Modify Triggers:
```yaml
on:
  push:
    branches: [ main, develop ]
    paths: [ 'src/**', 'pom.xml' ]  # Only trigger on source changes
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 2 * * 1'  # Weekly on Monday at 2 AM
```

### Add More Steps:
```yaml
- name: Run Checkstyle
  run: mvn checkstyle:check
  
- name: Generate Javadoc
  run: mvn javadoc:javadoc
  
- name: Deploy to staging
  if: github.ref == 'refs/heads/develop'
  run: echo "Deploy to staging environment"
```

### Environment Variables:
```yaml
env:
  MAVEN_OPTS: -Xmx1024m
  JAVA_OPTS: -Dfile.encoding=UTF-8
```

## Best Practices

1. **Keep workflows fast**: Use caching for dependencies
2. **Fail fast**: Run quick checks first (compile, then test)
3. **Parallel jobs**: Split into multiple jobs for large projects
4. **Security**: Use GitHub secrets for sensitive data
5. **Notifications**: Set up email/Slack notifications for failures

## Next Steps

1. **Set up branch protection**: Require CI to pass before merging
2. **Add deployment**: Deploy to staging/production on successful builds
3. **Code quality gates**: Add SonarQube or similar tools
4. **Security scanning**: Add dependency vulnerability checks
5. **Performance testing**: Add load testing to your pipeline

## Support

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Maven GitHub Actions](https://github.com/actions/setup-java)
- [Java CI/CD Examples](https://github.com/actions/starter-workflows/tree/main/ci)
