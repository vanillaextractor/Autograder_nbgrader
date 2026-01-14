#!/bin/bash

# Exit on any error
set -e

# Configuration
COURSE_DIR=$(pwd)
ENV_ACTIVATE="../jhub_env/bin/activate"
NBGRADER="../jhub_env/bin/nbgrader"

echo "========================================"
echo "      Starting Final Grading Process    "
echo "========================================"

# Check if environment exists
if [ ! -f "$ENV_ACTIVATE" ]; then
    echo "Error: Environment not found at $ENV_ACTIVATE"
    exit 1
fi

# Activate Environment
echo "[1/4] Activating environment..."
source "$ENV_ACTIVATE"

# Register/Update Assignment
echo "[2/4] Registering/Updating assignment 'test'..."
"$NBGRADER" generate_assignment test --force

# Run Autograder
echo "[3/4] Running autograder..."
"$NBGRADER" autograde test

# Generate Feedback
echo "[4/4] Generating feedback..."
"$NBGRADER" generate_feedback test

# Export Grades
echo "[5/5] Exporting grades..."
"$NBGRADER" export --assignment test --to test_grades.csv

echo "========================================"
echo "      Workflow Completed Successfully   "
echo "========================================"
echo "Feedback available in: $COURSE_DIR/feedback"
echo "Grades exported to: $COURSE_DIR/test_grades.csv"
