# Local testing script for Windows - run this instead of GitHub Actions CI

Write-Host "🔍 Starting local CI tests..." -ForegroundColor Cyan
Write-Host ""

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
python -m pip install --upgrade pip --quiet
pip install -r requirements-ci.txt --quiet

Write-Host "✓ Dependencies installed" -ForegroundColor Green
Write-Host ""

# Lint with ruff
Write-Host "🔍 Running linter (ruff)..." -ForegroundColor Yellow
ruff check .
Write-Host "✓ Linting passed" -ForegroundColor Green
Write-Host ""

# Build local index
Write-Host "📊 Building local index..." -ForegroundColor Yellow
python scripts/build_index.py --input data/raw/sample_docs.jsonl --output data/processed/index.json
Write-Host "✓ Index built" -ForegroundColor Green
Write-Host ""

# Build demo bundle
Write-Host "🤖 Training demo model..." -ForegroundColor Yellow
python train_demo.py
Write-Host "✓ Demo bundle created" -ForegroundColor Green
Write-Host ""

# Run evaluation
Write-Host "📈 Running evaluation..." -ForegroundColor Yellow
python scripts/run_eval.py --predictions eval/sample_predictions.json --thresholds eval/thresholds.yaml
Write-Host "✓ Evaluation passed" -ForegroundColor Green
Write-Host ""

# Run tests
Write-Host "🧪 Running tests..." -ForegroundColor Yellow
pytest --cov=app --cov=train_demo --cov-report=term -v
Write-Host "✓ Tests passed" -ForegroundColor Green
Write-Host ""

Write-Host "✅ All tests passed!" -ForegroundColor Green
