# Deployment Guide — GitHub Copilot Documentation

> Production deployment instructions for doc-utilisation-ia

---

## Quick Start

```bash
# Build locally
python -m mkdocs build --strict

# Serve locally (development)
python -m mkdocs serve

# Deploy to GitHub Pages (automatic via CI/CD)
git push origin main
```

---

## Architecture

```
Repository Structure:
├── docs/                          ← Documentation markdown
├── mkdocs.yml                     ← Site configuration
├── .github/workflows/deploy.yml   ← GitHub Actions CI/CD
├── site/                          ← Generated static site (git ignored)
└── requirements.txt               ← Python dependencies
```

---

## Local Development

### Prerequisites

```bash
# Python 3.11+
python --version

# Install dependencies
pip install -r requirements.txt
```

### Building

```bash
# Strict mode (fail on errors)
python -m mkdocs build --strict

# Output: site/ directory with HTML files
```

### Testing Locally

```bash
# Start development server
python -m mkdocs serve

# Open browser: http://localhost:8000
# Auto-refreshes on file changes
```

---

## Production Deployment

### Option 1: GitHub Pages (Recommended)

**Prerequisites**:
- Repository on GitHub
- GitHub Pages enabled (Settings → Pages)
- Main branch protection enabled (optional but recommended)

**Automatic Deployment**:
1. Push to `main` or `master` branch
2. GitHub Actions trigger (`.github/workflows/deploy.yml`)
3. Workflow builds documentation
4. Site deployed to `gh-pages` branch
5. Live at: `https://{username}.github.io/{repo}`

**Configuration**:
```yaml
# In mkdocs.yml
site_url: https://fturleque.github.io/doc-utilisation-ia/
```

### Option 2: Manual Deployment

```bash
# Build site
python -m mkdocs build --strict

# Deploy site/ directory to web server
# Examples:
# - Copy to Apache/Nginx DocumentRoot
# - Upload to cloud storage (AWS S3, Azure Blob)
# - Deploy to Vercel, Netlify, etc.
```

### Option 3: Docker Deployment

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY docs/ docs/
COPY mkdocs.yml .
RUN python -m mkdocs build
EXPOSE 8000
CMD ["python", "-m", "mkdocs", "serve", "-a", "0.0.0.0:8000"]
```

```bash
# Build image
docker build -t doc-copilot .

# Run container
docker run -p 8000:8000 doc-copilot
```

---

## Performance Optimization

### Site Size

```bash
# Check built site size
du -sh site/

# Typical: 5-15 MB (uncompressed)
```

### Compression

```bash
# Gzip compression
gzip -r site/

# CDN (CloudFlare, AWS CloudFront)
# Automatic gzip + caching
```

### Caching Strategy

```
# .github/workflows/deploy.yml adds cache headers:
Cache-Control: max-age=3600        # HTML (1 hour)
Cache-Control: max-age=31536000    # Assets/JS/CSS (1 year)
```

---

## Monitoring & Maintenance

### Health Checks

```bash
# Test site is live
curl -I https://fturleque.github.io/doc-utilisation-ia/

# Check specific page
curl -I https://fturleque.github.io/doc-utilisation-ia/index.html
```

### Broken Links

```bash
# Run link checker locally
python -m pip install linkchecker
linkchecker site/

# Or using GitHub Actions (add to workflow)
```

### Analytics

Add to `docs/index.md` or `mkdocs.yml`:
```yaml
# Google Analytics
google_analytics:
  provider: google
  property: G-XXXXXXXXXX
```

---

## Troubleshooting

### Build Fails on Push

1. Check workflow logs: GitHub → Actions → {workflow run}
2. Verify `requirements.txt` has all dependencies
3. Run locally first: `python -m mkdocs build --strict`
4. Check file encoding (UTF-8 recommended)

### Permission Denied (403) on `mkdocs gh-deploy`

If you see an error like:
```
remote: Permission to FTurleque/doc-utilisation-ia.git denied to <username>.
fatal: unable to access '...': The requested URL returned error: 403
```

**Local deployment is not recommended.** Use the automated GitHub Actions workflow instead.

To trigger a deployment:
```bash
git push origin main
```

The GitHub Actions workflow (`.github/workflows/deploy.yml`) uses `GITHUB_TOKEN` and the `github-actions[bot]` identity to push to the `gh-pages` branch — no manual deployment is needed.

### Site Not Updating

1. Verify push succeeded: `git status`
2. Check GitHub Actions ran: Settings → Actions
3. Clear browser cache: `Ctrl+Shift+Delete`
4. Check gh-pages branch exists: `git branch -a`

### Custom Domain Not Working

1. Verify DNS CNAME record points to GitHub Pages
2. Check GitHub Settings → Pages → Custom domain
3. Wait 5-10 minutes for DNS propagation
4. Test: `nslookup fturleque.github.io`

---

## Rollback

### Previous Version

```bash
# View deployment history
git log --oneline site/ | head -10

# Revert to previous build
git checkout {commit-hash} -- site/

# Re-deploy
git push origin main
```

### Manual Rollback

```bash
# Rebuild from previous mkdocs.yml
git checkout {commit-hash} mkdocs.yml docs/

# Build and deploy
python -m mkdocs build --strict
# Deploy site/ directory
```

---

## CI/CD Pipeline

### Automated Checks (Before Deployment)

1. **Build Check**
   ```bash
   python -m mkdocs build --strict
   ```
   Fails if: markdown errors, broken macros, encoding issues

2. **Link Validation** (optional)
   ```bash
   linkchecker site/
   ```
   Fails if: broken internal links, missing files

3. **Performance** (optional)
   ```bash
   # Check site size, load time
   ```

### Deployment Steps

1. ✅ All checks pass
2. 🔨 Build documentation
3. 📤 Deploy to GitHub Pages
4. 🔔 Comment on PR with status

---

## Security

### Sensitive Data

❌ **Never commit**:
- API keys, secrets
- Personal information
- Credentials

✅ **Use**:
- Environment variables
- GitHub Secrets (for CI/CD)
- `.gitignore` for sensitive files

### Access Control

- GitHub Pages: Public by default
- Use GitHub Organizations for private docs
- Set branch protection rules on main

---

## Support

**Issues?**
1. Check logs: GitHub Actions → Workflow run
2. Run locally: `python -m mkdocs build --strict`
3. Open GitHub Issue with error message
4. Check [MkDocs Docs](https://www.mkdocs.org/)

