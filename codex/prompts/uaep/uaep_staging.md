# UAEP Staging Mode
# Experimental, iterative, prototypes allowed

## Mode Configuration
```toml
[mode.staging]
quality_threshold = "medium"
allow_experimental = true
require_tests = false
enforce_linting = false
rapid_iteration = true
prototype_friendly = true
break_fast = true
```

## Staging Philosophy

**"Move fast and document later"**

Staging mode prioritizes:
1. **Speed**: Get working prototypes quickly
2. **Experimentation**: Try new approaches without fear
3. **Iteration**: Refine based on feedback
4. **Learning**: Document what works and what doesn't

## Acceptable Trade-offs

### What's OK in Staging
- ✅ TODO comments for future improvements
- ✅ Hardcoded values for testing
- ✅ Console.log / print debugging
- ✅ Simplified error handling
- ✅ Minimal documentation
- ✅ Experimental dependencies
- ✅ Breaking changes between versions
- ✅ Manual testing instead of automated tests

### What's Still Required
- ❌ Working functionality (no broken code)
- ❌ Basic error handling (no unhandled crashes)
- ❌ Security fundamentals (no SQL injection, XSS)
- ❌ Git commit messages (track changes)
- ❌ README with setup instructions

## Rapid Prototyping Patterns

### Bash - Quick Scripts
```bash
#!/usr/bin/env bash
# Quick prototype - not production ready

# Simple error handling
set -e

# Hardcoded config (TODO: move to config file)
API_URL="http://localhost:3000"
TOKEN="dev-token-123"

# Quick and dirty implementation
curl -s "$API_URL/api/data" \
    -H "Authorization: Bearer $TOKEN" \
    | jq '.results[]' \
    | while read -r item; do
        echo "Processing: $item"
        # TODO: Add proper processing
    done

echo "Done! (TODO: add error handling)"
```

### Python - Experiment Fast
```python
#!/usr/bin/env python3
"""Quick prototype - iterate fast."""

# TODO: Add proper imports and typing later
import requests

def main():
    # Hardcoded for now
    api_url = "http://localhost:3000"
    
    # Quick implementation
    response = requests.get(f"{api_url}/data")
    data = response.json()
    
    # Debug output
    print(f"Got {len(data)} items")
    
    for item in data:
        print(f"Processing {item['id']}")
        # TODO: Real processing here
    
    print("Done!")

if __name__ == "__main__":
    main()
```

### Rust - MVP Focus
```rust
// Quick prototype - refactor later
use std::fs;

fn main() {
    // TODO: Proper error handling
    let content = fs::read_to_string("data.txt").unwrap();
    
    // Quick parsing
    for line in content.lines() {
        if line.starts_with('#') {
            continue; // Skip comments
        }
        
        println!("Processing: {}", line);
        // TODO: Real processing
    }
    
    println!("Done!");
}
```

## Iteration Workflow

### Wave 1: Skeleton
- Create basic file structure
- Implement happy path only
- Hard code test data
- Manual testing

### Wave 2: Core Features
- Add main functionality
- Basic error handling
- Simple configuration
- Document key decisions

### Wave 3: Refinement
- Handle edge cases
- Add input validation
- Improve error messages
- Write usage examples

### Wave 4: Polish (→ Production)
- Comprehensive error handling
- Add tests
- Complete documentation
- Security audit
- Performance optimization

## Experiment Tracking

### Document Experiments
```markdown
## Experiment Log

### 2025-11-17: Trying Redis for caching
**Hypothesis**: Redis will reduce API response time by 50%
**Implementation**: Added redis-py, cached user queries
**Results**: 
- ✅ Response time: 300ms → 120ms (60% improvement)
- ❌ Memory usage increased 200MB
- ⚠️  Cache invalidation needs work
**Decision**: Keep Redis, optimize invalidation strategy
**Next**: Implement TTL-based invalidation

### 2025-11-16: Async processing experiment
**Hypothesis**: Async will improve throughput
**Implementation**: Converted sync code to asyncio
**Results**:
- ❌ Slower for small datasets (overhead)
- ✅ 3x faster for large datasets
- ⚠️  More complex error handling
**Decision**: Use async only for bulk operations
**Next**: Create async version of bulk importer
```

### Track Technical Debt
```markdown
## Technical Debt Register

### High Priority
- [ ] Replace hardcoded API URL with config file
- [ ] Add proper error handling to data parser
- [ ] Remove debug print statements

### Medium Priority
- [ ] Refactor 300-line function into smaller pieces
- [ ] Add type hints to all functions
- [ ] Replace shell script with Python for better testing

### Low Priority
- [ ] Improve variable naming in legacy code
- [ ] Add docstrings to internal functions
- [ ] Optimize slow loop (not a bottleneck yet)
```

## Quick Testing Strategies

### Manual Test Script
```bash
#!/usr/bin/env bash
# Quick smoke tests for staging

echo "==> Testing basic functionality..."
./bin/cx-review > /dev/null && echo "✓ cx-review works" || echo "✗ cx-review failed"

echo "==> Testing with test data..."
cd tests/fixtures
../../bin/cx-commit && echo "✓ cx-commit works" || echo "✗ cx-commit failed"

echo "==> All basic tests passed!"
```

### Inline Test Cases
```python
def parse_data(input_str):
    """Parse data from string."""
    # Implementation
    result = input_str.strip().split(',')
    return [x.strip() for x in result]

# Quick inline tests
if __name__ == "__main__":
    assert parse_data("a,b,c") == ["a", "b", "c"]
    assert parse_data("  a , b  ") == ["a", "b"]
    print("✓ Basic tests passed")
```

## Staging to Production Promotion

### Pre-Production Checklist
- [ ] All TODOs resolved or documented
- [ ] Hardcoded values moved to configuration
- [ ] Debug statements removed
- [ ] Error handling comprehensive
- [ ] Tests written and passing
- [ ] Documentation complete
- [ ] Security reviewed
- [ ] Performance acceptable

### Migration Steps
1. **Code review**: Get feedback from team
2. **Refactor**: Apply production standards
3. **Test**: Add comprehensive test suite
4. **Document**: Complete all documentation
5. **Audit**: Security and performance review
6. **Deploy**: Gradual rollout with monitoring

## Staging Best Practices

### DO in Staging:
- Experiment boldly
- Break things to learn
- Commit frequently (small commits)
- Document key learnings
- Ask for early feedback
- Iterate based on usage

### DON'T in Staging:
- Leave broken code committed
- Skip basic security (auth, input validation)
- Ignore user feedback
- Let technical debt accumulate unchecked
- Deploy staging code to production
- Forget to document experiments

## Transition Trigger

**Move to Production Mode when:**
- Core functionality proven
- User feedback incorporated
- Architecture validated
- Technical debt manageable
- Ready for reliability requirements
- Team agrees it's time
