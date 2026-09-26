#!/bin/bash

# Script to create a new project directory structure for Qlik Data Integration
# Usage: ./create_project_directory.sh <project_name> [base_path]

set -e

# Default values
PROJECT_NAME="${1}"
BASE_PATH="${2:-di/projects/automation}"

# Validate input
if [ -z "$PROJECT_NAME" ]; then
    echo "Error: Project name is required"
    echo "Usage: $0 <project_name> [base_path]"
    echo "Example: $0 A_MY_NEW_PROJECT_01_23_45"
    exit 1
fi

# Get the repository root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Full path to the new project
PROJECT_PATH="$REPO_ROOT/$BASE_PATH/$PROJECT_NAME"

# Check if directory already exists
if [ -d "$PROJECT_PATH" ]; then
    echo "Error: Directory already exists: $PROJECT_PATH"
    exit 1
fi

echo "Creating new project directory: $PROJECT_NAME"
echo "Location: $PROJECT_PATH"

# Create main project directory structure
mkdir -p "$PROJECT_PATH"
mkdir -p "$PROJECT_PATH/tasks"
mkdir -p "$PROJECT_PATH/newTaskDefaults"

# Create project.json
cat > "$PROJECT_PATH/project.json" << 'EOF'
{
  "exportVersion": "1.0",
  "name": "{{projectName}}",
  "space": "ref{project.current.spaceId}",
  "type": "DATA_PIPELINE",
  "description": "",
  "platformType": "SNOWFLAKE",
  "platformConnection": "{{platformConnection}}",
  "cloudStagingConnection": "{{cloudStagingConnection}}",
  "snowflakeStorageIntegration": ""
}
EOF

# Create projectSettings.json
cat > "$PROJECT_PATH/projectSettings.json" << 'EOF'
{
  "artifactsNaming": {
    "suffixLiveViews": "__live",
    "suffixChangesView": "__changes",
    "suffixCurrentView": "",
    "suffixHistoryViews": "__history",
    "suffixLiveHistoryViews": "__live_history",
    "suffixInternalSchema": "__internal",
    "prefixHeaderColumns": "hdr__",
    "prefixSchema": "{{project.current.prefixSchema}}",
    "defaultSchemaNameOption": "LOWER_CASE"
  }
}
EOF

# Create bindingsTemplate.json
cat > "$PROJECT_PATH/bindingsTemplate.json" << 'EOF'
{
  "variables": {
    "cloudStagingConnection": "",
    "platformConnection": "",
    "projectName": "",
    "project.current.prefixSchema": ""
  },
  "idToNameMap": {},
  "connectionProperties": {}
}
EOF

echo "✓ Project directory created successfully!"
echo "✓ Location: $PROJECT_PATH"
echo ""
echo "Next steps:"
echo "  1. Configure your project settings in $PROJECT_PATH/project.json"
echo "  2. Add tasks to $PROJECT_PATH/tasks/"
echo "  3. Update bindingsTemplate.json with your connection variables"

exit 0
