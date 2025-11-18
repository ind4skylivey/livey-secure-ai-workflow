# UAEP Production Mode
# Strict correctness, optimized, final quality

## Mode Configuration
```toml
[mode.production]
quality_threshold = "high"
allow_experimental = false
require_tests = true
enforce_linting = true
security_scan = true
performance_check = true
documentation_complete = true
```

## Production Standards

### Code Quality
- **Zero warnings**: Code must pass all linters without warnings
- **Test coverage**: Minimum 80% for critical paths
- **Error handling**: All errors must be caught and logged
- **Input validation**: Validate all external inputs
- **No magic numbers**: Use named constants
- **No dead code**: Remove unused functions/imports

### Security Requirements
- **Dependency audit**: All dependencies must be up-to-date
- **Secrets management**: No hardcoded credentials
- **Input sanitization**: Prevent injection attacks
- **Authentication**: Verify all authenticated operations
- **Authorization**: Check permissions before actions
- **HTTPS only**: No plaintext communication

### Performance Standards
- **Response time**: API endpoints < 200ms p95
- **Memory usage**: No memory leaks
- **CPU efficiency**: Profile hot paths
- **Database queries**: No N+1 queries
- **Caching strategy**: Cache expensive operations
- **Load testing**: Test under expected traffic

### Documentation Requirements
- **README**: Complete with examples
- **API docs**: All endpoints documented
- **Architecture diagram**: System overview
- **Deployment guide**: Step-by-step instructions
- **Troubleshooting**: Common issues and solutions
- **Changelog**: Version history with migration notes

## Production Checklist

### Before Generation
- [ ] All requirements clearly defined
- [ ] Tech stack approved
- [ ] Architecture reviewed
- [ ] Security considerations addressed
- [ ] Performance targets set
- [ ] Deployment environment known

### During Generation
- [ ] Follow language best practices
- [ ] Implement comprehensive error handling
- [ ] Add logging at appropriate levels
- [ ] Write inline documentation
- [ ] Consider edge cases
- [ ] Optimize for production load

### After Generation
- [ ] Code passes all linters
- [ ] Tests written and passing
- [ ] Security scan clean
- [ ] Performance benchmarks meet targets
- [ ] Documentation complete
- [ ] Deployment instructions verified

## Optimization Guidelines

### Bash Scripts
```bash
# Use built-in commands over external tools
# BAD
cat file.txt | grep pattern
# GOOD
grep pattern file.txt

# Check command existence once
command -v git >/dev/null 2>&1 || die "git required"

# Use arrays for multiple items
readonly COMMANDS=(git codex gh)
for cmd in "${COMMANDS[@]}"; do
    command -v "$cmd" >/dev/null 2>&1 || die "$cmd required"
done
```

### Python
```python
# Use generators for large datasets
def read_large_file(path: Path) -> Generator[str, None, None]:
    with path.open() as f:
        yield from f

# Cache expensive operations
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_operation(arg: str) -> str:
    # Implementation
    pass
```

### Rust
```rust
// Pre-allocate collections
let mut vec = Vec::with_capacity(expected_size);

// Use iterators over indexed loops
data.iter()
    .filter(|x| x.is_valid())
    .map(|x| x.process())
    .collect()

// Avoid unnecessary clones
fn process(data: &Data) -> Result<Output> {
    // Borrow instead of clone when possible
}
```

## Error Handling Patterns

### Bash
```bash
# Always check critical operations
git diff --cached > /tmp/diff || die "Failed to generate diff"

# Use cleanup traps
cleanup() {
    rm -f /tmp/temp-file
}
trap cleanup EXIT INT TERM
```

### Python
```python
# Specific exceptions
try:
    result = risky_operation()
except FileNotFoundError:
    logger.error("File not found")
    raise
except PermissionError:
    logger.error("Permission denied")
    raise
except Exception as e:
    logger.exception("Unexpected error")
    raise
```

### Rust
```rust
// Use Result for recoverable errors
fn parse_config(path: &Path) -> Result<Config, ConfigError> {
    let content = fs::read_to_string(path)
        .map_err(ConfigError::ReadFailed)?;
    
    toml::from_str(&content)
        .map_err(ConfigError::ParseFailed)
}

// Panic only for programming errors
assert!(index < len, "Index out of bounds");
```

## Logging Strategy

### Levels
- **ERROR**: Failures requiring immediate attention
- **WARN**: Potential issues or deprecated usage
- **INFO**: Key operations and state changes
- **DEBUG**: Detailed diagnostic information
- **TRACE**: Very verbose, function entry/exit

### Format
```
[TIMESTAMP] [LEVEL] [COMPONENT] message key=value key2=value2
```

### Example (Python)
```python
import logging
import structlog

logger = structlog.get_logger()

logger.info(
    "user_login",
    user_id=user.id,
    ip=request.remote_addr,
    duration_ms=elapsed
)
```

## Deployment Considerations

### Environment Variables
- Use `.env` files for local development
- Use secrets management in production (Vault, AWS Secrets Manager)
- Never commit `.env` to version control
- Validate all required env vars on startup

### Health Checks
```python
@app.get("/health")
def health_check():
    return {
        "status": "healthy",
        "version": VERSION,
        "uptime": get_uptime(),
        "checks": {
            "database": check_db(),
            "cache": check_cache(),
            "disk": check_disk_space(),
        }
    }
```

### Graceful Shutdown
```python
import signal
import sys

def signal_handler(sig, frame):
    logger.info("Shutdown signal received")
    cleanup_resources()
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)
```

## Production-Ready Indicators

✅ **Ready for Production:**
- All tests passing
- Code coverage > 80%
- No security vulnerabilities
- Performance benchmarks met
- Documentation complete
- Monitoring configured
- Deployment runbook ready

❌ **Not Ready:**
- Failing tests
- Security warnings
- Missing error handling
- No documentation
- Performance issues
- Hardcoded secrets
