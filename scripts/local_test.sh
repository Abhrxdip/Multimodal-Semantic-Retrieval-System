#!/bin/bash
# Local testing script - run this instead of GitHub Actions CI

set -e

echo "🔍 Starting local CI tests..."
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
python -m pip install --upgrade pip -q
pip install -r requirements-ci.txt -q

# Syntax check
echo "✓ Dependencies installed"
echo ""

# Lint with ruff
echo "🔍 Running linter (ruff)..."
ruff check .
echo "✓ Linting passed"
echo ""

# Build local index
echo "📊 Building local index..."
python scripts/build_index.py --input data/raw/sample_docs.jsonl --output data/processed/index.json
echo "✓ Index built"
echo ""

# Build demo bundle
echo "🤖 Training demo model..."
python train_demo.py
echo "✓ Demo bundle created"
echo ""

# Run evaluation
echo "📈 Running evaluation..."
python scripts/run_eval.py --predictions eval/sample_predictions.json --thresholds eval/thresholds.yaml
echo "✓ Evaluation passed"
echo ""

# Run tests
echo "🧪 Running tests..."
pytest --cov=app --cov=train_demo --cov-report=term -v
echo "✓ Tests passed"
echo ""

echo "✅ All tests passed!"
