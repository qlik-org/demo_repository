# demo_repository

This repository contains Qlik Data Integration project configurations for automation and testing.

## Creating a New Project Directory

To create a new project directory structure for automation, use the provided script:

```bash
./scripts/create_project_directory.sh <project_name> [base_path]
```

### Examples

Create a new automation project:
```bash
./scripts/create_project_directory.sh A_MY_NEW_PROJECT_12_34_56
```

Create a project in a different location:
```bash
./scripts/create_project_directory.sh MyProject di/projects
```

### What Gets Created

The script creates the following structure:
```
<project_name>/
├── project.json              # Main project configuration
├── projectSettings.json      # Project settings (naming conventions, etc.)
├── bindingsTemplate.json     # Variable bindings and connection properties
├── tasks/                    # Directory for task definitions
└── newTaskDefaults/          # Directory for task default templates
```

### Next Steps

After creating a project directory:
1. Configure your project settings in `project.json`
2. Add tasks to the `tasks/` directory
3. Update `bindingsTemplate.json` with your connection variables and mappings

## GitHub Actions Workflow

Alternatively, you can use the GitHub Actions workflow to create a new project directory:

1. Go to the **Actions** tab in the repository
2. Select **Create Project Directory** workflow
3. Click **Run workflow**
4. Enter the project name and optionally customize the base path
5. The workflow will create the directory and commit it to the repository

This is useful for team members who want to create new project directories without running scripts locally.
