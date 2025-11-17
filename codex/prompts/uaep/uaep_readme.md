# UAEP Integration Guide
# How to use Universal Agent Execution Protocol with livey-codex-toolkit

## Quick Start

### Using UAEP with Codex CLI

```bash
# Load UAEP protocol for current session
cx-uaep production

# Or use staging mode for experiments
cx-uaep staging

# Load specific profile + UAEP
cx-uaep production --profile laravel

# Load UAEP directly in Codex
codex --load codex/prompts/uaep/loader.md
```

### Project Structure

```
codex/prompts/uaep/
├── uaep_core.md         # Core protocol specification
├── uaep_production.md   # Production mode rules
├── uaep_staging.md      # Staging mode rules
├── uaep_readme.md       # This file
└── loader.md            # Protocol loader for Codex
```

## Execution Modes

### Production Mode
**When to use:**
- Building production features
- Refactoring critical code
- Security-sensitive changes
- Performance optimization
- Public API development

**Characteristics:**
- Strict quality standards
- Comprehensive error handling
- Complete documentation required
- Tests mandatory
- Security audit enabled

**Example:**
```bash
cx-uaep production

# Then ask Codex:
# "Implement a secure user authentication system with JWT tokens"
```

### Staging Mode
**When to use:**
- Prototyping new features
- Experimenting with approaches
- Learning new technologies
- Quick iteration cycles
- POC development

**Characteristics:**
- Rapid iteration
- Experimental code allowed
- Minimal documentation
- Tests optional
- TODOs acceptable

**Example:**
```bash
cx-uaep staging

# Then ask Codex:
# "Create a quick prototype for Redis caching integration"
```

## Special Modes

### AI Local Support
Integrates local AI models (Ollama, llama.cpp) for code suggestions and reviews.

```bash
cx-uaep production --mode ai_local_support

# Codex will:
# - Prefer local models for code review
# - Keep sensitive data on-device
# - Fallback to cloud AI if needed
```

### Security Analysis
Evaluates code safety, dependency risks, and potential misuse.

```bash
cx-uaep production --mode security_analysis

# Codex will:
# - Perform threat modeling
# - Check for common vulnerabilities
# - Audit dependencies
# - Suggest hardening measures
```

### Performance Max
Generates optimizations with benchmarking reasoning.

```bash
cx-uaep production --mode performance_max

# Codex will:
# - Profile hot paths
# - Suggest optimizations
# - Provide benchmark comparisons
# - Recommend caching strategies
```

## Integration with Existing Commands

### cx-review + UAEP
```bash
# Use UAEP production mode for reviews
cx-uaep production
cx-review

# Codex will apply production-level scrutiny:
# - Security vulnerabilities
# - Performance issues
# - Code quality problems
# - Missing error handling
```

### cx-commit + UAEP
```bash
# Use UAEP for better commit messages
cx-uaep production
cx-commit

# Generates commits following:
# - Conventional Commits spec
# - Clear, descriptive subjects
# - Proper scope and type
```

### cx-security + UAEP
```bash
# Combine security audit with UAEP
cx-uaep production --mode security_analysis
cx-security src/

# Deep security analysis:
# - OWASP Top 10 check
# - Dependency vulnerabilities
# - Code injection risks
# - Data leak potential
```

## Custom Profiles

### Creating Custom Profiles

```markdown
# codex/prompts/agent.myproject.md

# Agent Profile: MyProject

## Project Context
- Laravel API backend
- React frontend
- PostgreSQL database
- Redis caching layer

## Coding Standards
- PSR-12 for PHP
- ESLint for JavaScript
- Prettier for formatting
- PHPStan level 8

## Architecture Patterns
- Repository pattern for data access
- Service layer for business logic
- API resources for responses
- Form requests for validation

## Testing Requirements
- Feature tests for all endpoints
- Unit tests for services
- Integration tests for repositories
- E2E tests for critical flows
```

### Loading Custom Profiles

```bash
# Load custom profile with UAEP
cx-uaep production --profile myproject

# Or manually in Codex
codex \
    --load codex/prompts/uaep/loader.md \
    --load codex/prompts/agent.myproject.md
```

## Output Structure

### Expected Response Format

Every Codex response using UAEP will follow this structure:

```markdown
## 1. PLAN
[High-level reasoning and architecture]

## 2. FILE-TREE
[Directory structure with explanations]

## 3. GENERATION RULES
[Coding standards and conventions]

## 4. IMPLEMENTATION
[Complete, working code]

## 5. TASK QUEUE
[Future improvements and considerations]
```

### Example Query and Response

**Query:**
```
Using UAEP production mode, create a CLI command for database backups.
```

**Codex Response:**
```markdown
## 1. PLAN
### High-Level Steps
1. Accept database credentials via CLI flags or env vars
2. Use pg_dump for PostgreSQL backups
3. Compress output with gzip
4. Store with timestamp-based filename
5. Support remote storage (S3, FTP) optionally

### Architecture
- Single Bash script in bin/cx-backup
- Configuration via ~/.config/livey-codex/backup.conf
- Logging to syslog and local file
- Encryption with gpg for security

[... continues with full UAEP structure ...]
```

## Tips and Best Practices

### For Production Mode
1. **Be specific**: Provide detailed requirements
2. **Set constraints**: Define performance targets, security requirements
3. **Review carefully**: Codex follows UAEP, but you verify correctness
4. **Iterate**: Start with core, add features incrementally

### For Staging Mode
1. **Experiment freely**: Try different approaches
2. **Document learnings**: Keep experiment log
3. **Fail fast**: Don't spend too long on one approach
4. **Promote carefully**: Review before moving to production

### General Tips
1. **Load UAEP once**: At start of session, not per query
2. **Combine modes**: Use special modes when relevant
3. **Save context**: Codex remembers in session
4. **Use profiles**: Leverage project-specific profiles

## Troubleshooting

### Issue: Codex not following UAEP structure

**Solution:**
```bash
# Reload the protocol explicitly
codex --load codex/prompts/uaep/loader.md

# Or restart cx-uaep
cx-uaep production
```

### Issue: Output too verbose

**Solution:**
```bash
# Use staging mode for quicker responses
cx-uaep staging

# Or request specific sections only
# "Just show me the IMPLEMENTATION section"
```

### Issue: Missing dependencies in generated code

**Solution:**
Add context about your environment:
```
Using UAEP production mode, create X.
Environment: Arch Linux, PHP 8.2, Composer 2.x
Constraints: No external services, CLI only
```

## Examples

### Example 1: New CLI Command
```bash
cx-uaep production

# Query:
# "Create a command cx-deploy that:
# - Runs tests before deploying
# - Pushes to git remote
# - Triggers CI/CD pipeline
# - Sends notification to Slack"
```

### Example 2: Refactoring
```bash
cx-uaep production --mode performance_max

# Query:
# "Refactor cx-security to:
# - Process files in parallel
# - Stream large files instead of loading in memory
# - Add progress bar with percentage"
```

### Example 3: Quick Prototype
```bash
cx-uaep staging

# Query:
# "Quick prototype for log file parser that:
# - Reads syslog format
# - Filters by severity
# - Outputs JSON
# Don't worry about error handling yet"
```

## Integration with Other Tools

### With Git Hooks
```bash
# .git/hooks/pre-commit
#!/usr/bin/env bash
cx-uaep production
cx-review
```

### With CI/CD
```yaml
# .github/workflows/code-review.yml
name: AI Code Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install livey-codex-toolkit
        run: ./install.sh
      - name: Run UAEP review
        run: |
          cx-uaep production --mode security_analysis
          cx-review > review-output.md
      - name: Comment on PR
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const review = fs.readFileSync('review-output.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review
            });
```

### With Neovim/VS Code
```lua
-- Neovim config
vim.keymap.set('n', '<leader>cr', function()
  vim.cmd('!cx-uaep production && cx-review')
end, { desc = 'Codex Review' })

vim.keymap.set('n', '<leader>cc', function()
  vim.cmd('!cx-uaep production && cx-commit')
end, { desc = 'Codex Commit' })
```

## FAQ

**Q: Can I use multiple special modes?**
A: Yes! `cx-uaep production --mode security_analysis,performance_max`

**Q: Does UAEP work with non-English queries?**
A: Yes, but protocol itself is in English for consistency.

**Q: Can I modify UAEP protocol for my needs?**
A: Absolutely! Fork and customize the markdown files.

**Q: Is UAEP compatible with other AI models?**
A: Yes, designed to work with GPT-4, Claude, local models (Ollama), etc.

**Q: How do I contribute improvements to UAEP?**
A: Submit PRs to the repository with your enhancements!

## Resources

- **UAEP Specification**: `codex/prompts/uaep/uaep_core.md`
- **Mode Details**: Production and Staging mode files
- **Examples**: `examples/` directory (coming soon)
- **Community**: GitHub Discussions

## Version History

- **v1.0** (2025-11-17): Initial UAEP integration
  - Core protocol specification
  - Production and staging modes
  - Special modes (AI local, security, performance)
  - CLI loader command
