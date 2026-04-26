# Testing Alternatives

Since GitHub Actions has billing constraints, here are free alternatives:

## 1. **Local Testing (Recommended)**
Run tests locally before pushing:

**Windows (PowerShell):**
```powershell
.\scripts\local_test.ps1
```

**macOS/Linux (Bash):**
```bash
bash scripts/local_test.sh
```

## 2. **Free CI Providers**

### Gitea CI (Self-hosted, Free)
- Completely free, self-hosted
- Full control, no billing issues
- Can integrate with GitHub via mirror

### GitLab CI (Free Tier)
- 400 minutes/month free
- Go to: https://gitlab.com
- Mirror your repo from GitHub
- Create `.gitlab-ci.yml` file

### Woodpecker CI (Free, Self-hosted)
- Open-source alternative
- Works with GitHub repos
- No cost

### Sourcehut (Free Tier)
- ~$0/month for public repos
- https://builds.sr.ht
- Limited but free

## 3. **Docker Local Testing**
Run everything in a container:

```powershell
docker compose up --build
```

## 4. **Manual Pre-commit Hooks**
Automatically run tests before committing:

```powershell
pip install pre-commit
pre-commit install
```

Then create `.pre-commit-config.yaml`:
```yaml
repos:
  - repo: local
    hooks:
      - id: pytest
        name: pytest
        entry: pytest
        language: system
        types: [python]
        pass_filenames: false
        stages: [commit]
```

---

**Recommendation:** Use local testing for development, then consider GitLab CI or Woodpecker when ready for automated CI.
