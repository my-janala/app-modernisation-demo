# Contributing Guide

Thanks for your interest in improving the app-modernisation demo! This document explains how to propose changes and contribute effectively.

## Getting Started

1. Fork the repository and create a feature branch (`git checkout -b feature/my-change`).
2. Install prerequisites listed in the [Setup Guide](docs/setup.md#prerequisites).
3. Spin up the local Konveyor environment:
   ```bash
   make setup
   ```
4. Run the workflow you are changing (analysis, docs, assets) and validate your updates.

## Development Workflow

- Keep changes focused. Separate unrelated updates into different pull requests.
- Update documentation when behavior or workflows change.
- Run any relevant checks (e.g. formatting, `make clean`, or manual commands described in the docs).
- For documentation-only fixes, state `Docs only change` in the pull request body.

## Commit Messages

- Use concise, present-tense messages, e.g. `docs: add troubleshooting for analyser jobs`.
- Reference issues with `Fixes #<id>` where appropriate.

## Pull Requests

When opening a PR:

- Ensure the branch is rebased on the latest `main`.
- Provide context and testing notes in the PR template checklist.
- Attach screenshots or terminal output for UI/analysis changes when possible.

## Reporting Issues

Use the GitHub issue templates (Bug Report or Feature Request). Include:

- Summary of the problem or desired enhancement.
- Steps to reproduce (for bugs).
- Relevant logs or screenshots.
- Suggested remediation if you have one.

## Code of Conduct

Participation in this project is governed by the [Code of Conduct](CODE_OF_CONDUCT.md). Please review it before engaging with the community.

We appreciate your contributions!
