# RFC-XXX: [Title]

**Status**: Draft | Under Review | Accepted | Rejected | Implemented  
**Author**: [Your Name]  
**Shepherd**: [Technical Shepherd Name]  
**Created**: YYYY-MM-DD  
**Last Updated**: YYYY-MM-DD

## Summary

[One paragraph explanation of the proposal]

## Motivation

### Why are we doing this?

[Explain the motivation for this proposal. What problem does it solve? What benefits does it bring?]

### What use cases does it support?

[Describe the use cases that this proposal enables or improves]

### What is the expected outcome?

[What do we expect to achieve if this proposal is accepted?]

## Detailed Design

### Overview

[High-level explanation of the proposal]

### Technical Details

[Detailed technical explanation. This is the core of the RFC.]

#### Architecture

```
┌─────────────────┐
│   Component A   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Component B   │
└─────────────────┘
```

#### API Design

```typescript
// Example API or interface
interface ProposedAPI {
  method1(arg: Type): ReturnType;
  method2(arg: Type): ReturnType;
}
```

#### Data Structures

```typescript
// Example data structures
type ProposedType = {
  field1: string;
  field2: number;
  field3?: boolean;
};
```

#### Algorithms

[Describe key algorithms or processes]

```
1. Step one
2. Step two
3. Step three
```

### Examples

#### Example 1: Basic Usage

```typescript
// Show how this would be used
const example = new ProposedAPI();
const result = example.method1({ /* ... */ });
```

#### Example 2: Advanced Usage

```typescript
// Show more complex scenarios
```

### Migration Strategy

[How will existing code/users migrate to this new approach?]

1. Phase 1: [Description]
2. Phase 2: [Description]
3. Phase 3: [Description]

### Edge Cases

[What edge cases exist? How are they handled?]

- **Edge Case 1**: [Description and handling]
- **Edge Case 2**: [Description and handling]

## Drawbacks

[Why should we **not** do this?]

- [Drawback 1]
- [Drawback 2]
- [Drawback 3]

## Alternatives

### Alternative 1: [Name]

**Description**: [Explanation]

**Pros**:
- [Pro 1]
- [Pro 2]

**Cons**:
- [Con 1]
- [Con 2]

**Why Not**: [Reason this was rejected]

### Alternative 2: [Name]

[Same structure as Alternative 1]

### Do Nothing

**Consequences**: [What happens if we don't implement this proposal?]

## Prior Art

### Similar Solutions in Other Systems

- **[System/Language Name]**: [How they solved it]
- **[System/Language Name]**: [How they solved it]

### Academic Research

- [Link to relevant papers or research]

### Industry Patterns

- [Common patterns or best practices in the industry]

## Unresolved Questions

- [ ] [Question 1 that needs to be answered before implementation]
- [ ] [Question 2 that needs to be answered before implementation]

## Future Possibilities

[What future enhancements does this enable? What could we build on top of this?]

- [Future possibility 1]
- [Future possibility 2]

## Implementation Plan

### Milestones

| Milestone | Description | Target Date | Owner |
|-----------|-------------|-------------|-------|
| M1 | [Description] | YYYY-MM-DD | [Name] |
| M2 | [Description] | YYYY-MM-DD | [Name] |
| M3 | [Description] | YYYY-MM-DD | [Name] |

### Tasks

- [ ] [Task 1]
- [ ] [Task 2]
- [ ] [Task 3]

### Dependencies

- [Dependency 1: What needs to exist before this can be implemented?]
- [Dependency 2]

## Testing Plan

### Unit Tests

- [What unit tests are needed?]

### Integration Tests

- [What integration tests are needed?]

### Performance Tests

- [What performance benchmarks need to be met?]

### Compatibility Tests

- [What compatibility needs to be verified?]

## Documentation Plan

- [ ] API documentation
- [ ] User guides
- [ ] Migration guides
- [ ] Examples and tutorials
- [ ] Architecture documentation

## Success Metrics

[How will we measure if this proposal is successful?]

- **Metric 1**: [Description and target]
- **Metric 2**: [Description and target]
- **Metric 3**: [Description and target]

## Security Considerations

[What are the security implications of this proposal?]

- **Consideration 1**: [Description and mitigation]
- **Consideration 2**: [Description and mitigation]

## Performance Considerations

[What are the performance implications?]

- **Consideration 1**: [Description and mitigation]
- **Consideration 2**: [Description and mitigation]

## Accessibility Considerations

[How does this affect accessibility?]

## Privacy Considerations

[How does this affect user privacy?]

## References

- [Link to related RFCs]
- [Link to related ADRs]
- [Link to external documentation]
- [Link to research or benchmarks]

## Feedback and Discussion

### Open Questions from Reviewers

- **[Reviewer Name]**: [Question or concern]
  - **Response**: [Author's response]

### Discussion Log

| Date | Participant | Topic | Resolution |
|------|-------------|-------|------------|
| YYYY-MM-DD | [Name] | [Topic] | [Resolution] |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| YYYY-MM-DD | Initial draft | [Name] |
| YYYY-MM-DD | Added security section | [Name] |
| YYYY-MM-DD | Addressed reviewer feedback | [Name] |

---

## Example: RFC-001: Implement Rate Limiting Middleware

**Status**: Accepted  
**Author**: Backend Team  
**Shepherd**: Tech Lead  
**Created**: 2024-01-10  
**Last Updated**: 2024-01-20

### Summary

We propose implementing a global rate limiting middleware to protect our API from abuse and ensure fair usage across all clients. This will use a token bucket algorithm with Redis as the backing store.

### Motivation

#### Why are we doing this?

Our API is experiencing abuse from a small number of clients making excessive requests:
- One client made 1M requests in 1 hour (10x normal)
- This impacts performance for all users
- We're paying excessive infrastructure costs
- We have no mechanism to prevent or throttle abuse

#### What use cases does it support?

1. Prevent API abuse and DDoS attacks
2. Ensure fair resource allocation among clients
3. Protect downstream services from overload
4. Provide clear feedback to clients about limits

#### What is the expected outcome?

- 99.9% of users unaffected (already within limits)
- Abusive clients automatically throttled
- Clear communication of limits via headers
- Infrastructure costs reduced by ~20%

### Detailed Design

#### Overview

Implement Express middleware that tracks request rates per client (by API key) using Redis. Use token bucket algorithm for smooth rate limiting with burst tolerance.

#### Technical Details

**Rate Limits**:
- Free tier: 100 requests/hour, burst of 10
- Pro tier: 1000 requests/hour, burst of 50
- Enterprise: 10000 requests/hour, burst of 200

**Algorithm**: Token Bucket
- Tokens refill at constant rate
- Each request consumes one token
- Burst capacity allows temporary spikes
- Reject requests when bucket empty

**Storage**: Redis
- Key format: `ratelimit:{tier}:{apiKey}`
- TTL: 1 hour (auto-cleanup)
- Atomic operations via Lua scripts

#### Architecture

```
┌────────────┐
│   Client   │
└─────┬──────┘
      │ Request
      ▼
┌─────────────────┐
│ Rate Limiting   │◄─── Check bucket
│   Middleware    │      in Redis
└─────┬───────────┘
      │ (if allowed)
      ▼
┌─────────────────┐
│   API Handler   │
└─────────────────┘
```

#### API Design

```typescript
interface RateLimitConfig {
  windowMs: number;      // Time window in ms
  maxRequests: number;   // Max requests in window
  burstCapacity: number; // Burst tolerance
  keyGenerator: (req: Request) => string;
  handler: (req: Request, res: Response) => void;
}

class RateLimiter {
  constructor(config: RateLimitConfig);
  
  middleware(): RequestHandler;
  
  async isAllowed(key: string): Promise<{
    allowed: boolean;
    remaining: number;
    resetAt: Date;
  }>;
}
```

#### Data Structures

```typescript
type RateLimitInfo = {
  tokens: number;        // Current token count
  lastRefill: number;    // Last refill timestamp
  capacity: number;      // Max tokens
  refillRate: number;    // Tokens per second
};
```

#### Algorithms

**Token Bucket Algorithm**:
```
1. Calculate elapsed time since last refill
2. Add tokens: tokens += (elapsed * refillRate)
3. Cap tokens at capacity (bucket size)
4. If tokens >= 1:
   a. Consume 1 token
   b. Allow request
5. Else:
   a. Reject request
   b. Return retry-after header
```

**Redis Lua Script** (atomic operations):
```lua
local key = KEYS[1]
local capacity = tonumber(ARGV[1])
local refillRate = tonumber(ARGV[2])
local now = tonumber(ARGV[3])

local info = redis.call('HMGET', key, 'tokens', 'lastRefill')
local tokens = tonumber(info[1]) or capacity
local lastRefill = tonumber(info[2]) or now

local elapsed = math.max(0, now - lastRefill)
tokens = math.min(capacity, tokens + (elapsed * refillRate))

if tokens >= 1 then
  tokens = tokens - 1
  redis.call('HMSET', key, 'tokens', tokens, 'lastRefill', now)
  redis.call('EXPIRE', key, 3600)
  return {1, tokens, math.ceil((capacity - tokens) / refillRate)}
else
  return {0, 0, math.ceil((1 - tokens) / refillRate)}
end
```

### Examples

#### Example 1: Basic Setup

```typescript
import { RateLimiter } from './rate-limiter';

const limiter = new RateLimiter({
  windowMs: 60 * 60 * 1000, // 1 hour
  maxRequests: 100,
  burstCapacity: 10,
  keyGenerator: (req) => req.apiKey,
  handler: (req, res) => {
    res.status(429).json({
      error: 'Too many requests',
      retryAfter: res.getHeader('Retry-After')
    });
  }
});

app.use('/api', limiter.middleware());
```

#### Example 2: Tier-Based Limits

```typescript
const tiers = {
  free: { maxRequests: 100, burstCapacity: 10 },
  pro: { maxRequests: 1000, burstCapacity: 50 },
  enterprise: { maxRequests: 10000, burstCapacity: 200 }
};

app.use('/api', (req, res, next) => {
  const tier = req.user.tier;
  const config = tiers[tier];
  
  const limiter = new RateLimiter({
    ...config,
    windowMs: 60 * 60 * 1000,
    keyGenerator: (req) => `${tier}:${req.user.id}`,
  });
  
  limiter.middleware()(req, res, next);
});
```

### Migration Strategy

1. **Week 1**: Deploy with logging only (no enforcement)
   - Monitor which clients would be affected
   - Tune limits based on data
2. **Week 2**: Soft enforcement (warnings in responses)
   - Add rate limit headers
   - No rejections yet
3. **Week 3**: Full enforcement
   - Start rejecting over-limit requests
   - Monitor for issues
4. **Week 4**: Optimize and tune
   - Adjust limits based on feedback
   - Performance tuning

### Edge Cases

- **Burst Traffic**: Burst capacity handles short spikes
- **Clock Skew**: Use server time, not client time
- **Redis Failure**: Fail open (allow requests) or fail closed (reject)? → Fail open with logging
- **Multiple Instances**: Redis ensures consistency across instances
- **Race Conditions**: Lua scripts provide atomicity

## Drawbacks

- Additional latency (Redis lookup on every request) → ~1-3ms
- Additional infrastructure cost (Redis) → ~$50/month
- Complexity in debugging rate limit issues
- Potential for false positives if limits too strict

## Alternatives

### Alternative 1: Application-Level Rate Limiting (In-Memory)

**Pros**:
- No Redis dependency
- Lower latency
- Simpler setup

**Cons**:
- Not distributed (each instance has own limits)
- Lost on restart
- No persistence

**Why Not**: Doesn't work in multi-instance deployments

### Alternative 2: API Gateway Rate Limiting

**Pros**:
- Centralized
- Lower application complexity
- Battle-tested solutions

**Cons**:
- Additional infrastructure
- Less flexibility
- Higher cost (~$500/month)

**Why Not**: We don't have an API gateway yet

### Alternative 3: Do Nothing

**Consequences**:
- Continued abuse and degraded performance
- Higher infrastructure costs
- Poor user experience
- Potential outages

## Prior Art

- **Express Rate Limit**: Popular library, but not distributed
- **Kong Rate Limiting**: API gateway solution
- **Nginx Rate Limiting**: Web server level
- **AWS API Gateway**: Managed service

## Unresolved Questions

- [ ] What should fail-open vs fail-closed policy be?
- [ ] Should we implement per-IP limits in addition to per-API-key?
- [ ] How do we handle rate limits for webhooks?

## Future Possibilities

- Dynamic rate limits based on real-time load
- Per-endpoint rate limits (different limits for heavy endpoints)
- Rate limit exemptions for trusted clients
- Analytics dashboard for rate limit violations

## Implementation Plan

### Milestones

| Milestone | Description | Target Date | Owner |
|-----------|-------------|-------------|-------|
| M1 | Core middleware implementation | 2024-01-25 | Backend Team |
| M2 | Redis integration and Lua scripts | 2024-01-28 | Backend Team |
| M3 | Logging and monitoring | 2024-01-30 | DevOps Team |
| M4 | Production deployment | 2024-02-05 | Backend Team |

### Tasks

- [ ] Implement RateLimiter class
- [ ] Write Redis Lua scripts
- [ ] Add Express middleware
- [ ] Create configuration system
- [ ] Add rate limit headers
- [ ] Write tests (unit, integration)
- [ ] Add monitoring and alerts
- [ ] Update API documentation
- [ ] Deploy to staging
- [ ] Deploy to production

### Dependencies

- Redis cluster must be provisioned
- Monitoring dashboards must be ready
- API key system must support tier detection

## Testing Plan

### Unit Tests

- Token bucket algorithm correctness
- Key generation
- Configuration parsing
- Error handling

### Integration Tests

- End-to-end rate limiting flow
- Redis persistence
- Multi-instance coordination
- Burst capacity behavior

### Performance Tests

- Latency impact (<5ms p99)
- Throughput (>10k requests/sec)
- Redis load

### Load Tests

- Simulate 10k concurrent users
- Verify limits enforced correctly
- Check for race conditions

## Documentation Plan

- [ ] API reference for RateLimiter class
- [ ] User guide: Understanding rate limits
- [ ] Migration guide for API clients
- [ ] Troubleshooting guide
- [ ] Architecture documentation

## Success Metrics

- **Latency Impact**: <3ms p99 overhead
- **Abuse Prevention**: 95% reduction in over-limit requests
- **Cost Savings**: 20% reduction in infrastructure costs
- **User Satisfaction**: No increase in support tickets

## Security Considerations

- **API Key Leakage**: If key stolen, attacker limited to tier rate
- **Timing Attacks**: Redis access time is constant
- **DoS via Rate Limit**: Fail-open prevents self-DoS

## Performance Considerations

- **Redis Latency**: Use pipelining for multiple checks
- **Network Overhead**: Co-locate Redis with app servers
- **Memory Usage**: ~1KB per active key, ~10MB for 10k keys

## References

- [Token Bucket Algorithm](https://en.wikipedia.org/wiki/Token_bucket)
- [Redis Lua Scripting](https://redis.io/commands/eval)
- [HTTP 429 Status Code](https://httpstat.us/429)
