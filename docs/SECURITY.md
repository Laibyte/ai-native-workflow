# Security Policy

## Overview

Security is a core principle of the AI-Native Development Workflow. This document outlines security practices, policies, and procedures.

## Reporting Security Vulnerabilities

### Where to Report

**DO NOT** create public GitHub issues for security vulnerabilities.

Instead:
1. Email: security@example.com
2. GitHub Security Advisories (private)
3. Encrypted communication: [PGP key]

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)
- Your contact information

### Response Timeline

- **24 hours**: Initial acknowledgment
- **72 hours**: Preliminary assessment
- **7 days**: Detailed response with timeline
- **30 days**: Fix or mitigation (target)

## Security Best Practices

### 1. Secrets Management

#### Never Commit Secrets

```bash
# ❌ BAD - Never do this
API_KEY=sk_live_abc123
DATABASE_URL=postgres://user:password@host/db
```

#### Use Environment Variables

```bash
# ✅ GOOD
# .env (gitignored)
API_KEY=${API_KEY}
DATABASE_URL=${DATABASE_URL}
```

#### Use Secret Management Services

- **GitHub Secrets**: For CI/CD
- **AWS Secrets Manager**: For production
- **HashiCorp Vault**: For enterprise
- **Doppler**: For team secrets

#### Rotate Secrets Regularly

```yaml
Secret Rotation Schedule:
  - API keys: Every 90 days
  - Database passwords: Every 180 days
  - Service credentials: Every 30 days
  - Personal access tokens: Every year
```

### 2. Secrets Scanning

#### Pre-commit Scanning

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.1
    hooks:
      - id: gitleaks
```

#### CI Scanning

```yaml
# .github/workflows/security.yml
- name: Run gitleaks
  uses: gitleaks/gitleaks-action@v2
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Tools

- **gitleaks**: Detect secrets in commits
- **trufflehog**: Find high-entropy strings
- **detect-secrets**: Yelp's secret scanner

### 3. Dependency Security

#### Audit Dependencies

**npm**:
```bash
npm audit
npm audit fix
npm audit fix --force  # For breaking changes
```

**poetry**:
```bash
poetry audit  # Requires safety plugin
poetry add safety --group dev
```

#### Automated Scanning

```yaml
# .github/workflows/security.yml
- name: Run npm audit
  run: npm audit --audit-level=high
  
- name: Run Snyk
  uses: snyk/actions/node@master
  env:
    SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
```

#### Vulnerability Response

| Severity | Response Time | Action |
|----------|---------------|--------|
| Critical | Immediate | Patch and deploy ASAP |
| High | 24 hours | Patch and deploy next day |
| Medium | 1 week | Include in next release |
| Low | 1 month | Address when convenient |

### 4. Input Validation

#### Validate All User Input

```typescript
// ❌ BAD
function getUser(id: string) {
  return db.query(`SELECT * FROM users WHERE id = ${id}`);
}

// ✅ GOOD
function getUser(id: string) {
  if (!isValidUuid(id)) {
    throw new ValidationError('Invalid user ID');
  }
  return db.query('SELECT * FROM users WHERE id = $1', [id]);
}
```

#### Use Schema Validation

```typescript
import { z } from 'zod';

const UserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
  age: z.number().int().min(13).max(120)
});

function createUser(data: unknown) {
  const validated = UserSchema.parse(data);
  // Now validated is type-safe and validated
}
```

### 5. SQL Injection Prevention

#### Use Parameterized Queries

```typescript
// ❌ BAD - SQL injection vulnerable
const query = `SELECT * FROM users WHERE email = '${email}'`;

// ✅ GOOD - Parameterized
const query = 'SELECT * FROM users WHERE email = $1';
const result = await db.query(query, [email]);
```

#### Use ORMs Safely

```typescript
// ✅ GOOD with TypeORM
const user = await userRepository.findOne({
  where: { email: email }
});

// ⚠️ DANGEROUS with raw queries
const user = await userRepository.query(
  `SELECT * FROM users WHERE email = '${email}'`
);
```

### 6. XSS Prevention

#### Escape User Content

```typescript
// ❌ BAD
element.innerHTML = userContent;

// ✅ GOOD
element.textContent = userContent;
// or
element.innerHTML = DOMPurify.sanitize(userContent);
```

#### Use Content Security Policy

```typescript
// Set CSP headers
app.use((req, res, next) => {
  res.setHeader(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-inline'"
  );
  next();
});
```

### 7. CSRF Protection

#### Use CSRF Tokens

```typescript
import csrf from 'csurf';

app.use(csrf({ cookie: true }));

app.post('/api/transfer', (req, res) => {
  // Token automatically validated
  processTransfer(req.body);
});
```

#### SameSite Cookies

```typescript
res.cookie('session', token, {
  httpOnly: true,
  secure: true,
  sameSite: 'strict'
});
```

### 8. Authentication & Authorization

#### Password Security

```typescript
import bcrypt from 'bcrypt';

// Hash password
const saltRounds = 10;
const hashedPassword = await bcrypt.hash(password, saltRounds);

// Verify password
const isValid = await bcrypt.compare(password, hashedPassword);
```

**Requirements**:
- Minimum 8 characters
- Mix of uppercase, lowercase, numbers, symbols
- Check against common password lists
- Rate limit login attempts

#### JWT Security

```typescript
import jwt from 'jsonwebtoken';

// Sign token
const token = jwt.sign(
  { userId: user.id },
  process.env.JWT_SECRET!,
  { expiresIn: '1h', algorithm: 'HS256' }
);

// Verify token
try {
  const decoded = jwt.verify(token, process.env.JWT_SECRET!);
} catch (err) {
  throw new UnauthorizedError('Invalid token');
}
```

**Best Practices**:
- Use strong, random secrets (256-bit minimum)
- Set appropriate expiration times
- Use refresh tokens for long-lived sessions
- Implement token revocation

#### Authorization

```typescript
function requireRole(role: string) {
  return (req: Request, res: Response, next: NextFunction) => {
    if (!req.user || req.user.role !== role) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}

app.post('/admin/users', requireRole('admin'), createUser);
```

### 9. Rate Limiting

#### Prevent Brute Force

```typescript
import rateLimit from 'express-rate-limit';

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 requests per window
  message: 'Too many login attempts, please try again later'
});

app.post('/api/login', loginLimiter, login);
```

#### API Rate Limiting

```typescript
const apiLimiter = rateLimit({
  windowMs: 60 * 60 * 1000, // 1 hour
  max: 100, // 100 requests per hour
  standardHeaders: true,
  legacyHeaders: false,
});

app.use('/api/', apiLimiter);
```

### 10. Secure Headers

```typescript
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true
  }
}));
```

## Security Checklist

### Development

- [ ] No secrets in code or repository
- [ ] All user input validated
- [ ] Parameterized queries used
- [ ] XSS protection implemented
- [ ] CSRF protection enabled
- [ ] Secure headers configured
- [ ] Dependencies audited
- [ ] Error messages don't leak info

### Deployment

- [ ] HTTPS enabled
- [ ] Secrets in environment/vault
- [ ] Database access restricted
- [ ] Logging configured securely
- [ ] Rate limiting enabled
- [ ] Monitoring and alerts set up
- [ ] Backup and recovery tested

### Code Review

- [ ] Security implications considered
- [ ] Input validation reviewed
- [ ] Authentication/authorization correct
- [ ] No sensitive data logged
- [ ] Dependencies are up to date
- [ ] Following secure coding practices

## Security Scanning

### SAST (Static Application Security Testing)

```yaml
# .github/workflows/security.yml
- name: Run CodeQL
  uses: github/codeql-action/analyze@v2

- name: Run Semgrep
  uses: returntocorp/semgrep-action@v1
```

**Tools**:
- **CodeQL**: GitHub's semantic code analysis
- **Semgrep**: Fast, customizable static analysis
- **SonarQube**: Comprehensive code quality and security

### DAST (Dynamic Application Security Testing)

```yaml
- name: Run OWASP ZAP
  uses: zaproxy/action-baseline@v0.7.0
  with:
    target: 'https://staging.example.com'
```

**Tools**:
- **OWASP ZAP**: Web application scanner
- **Burp Suite**: Professional security testing
- **Nikto**: Web server scanner

### Dependency Scanning

```yaml
- name: Run Snyk
  uses: snyk/actions/node@master

- name: Run Trivy
  uses: aquasecurity/trivy-action@master
```

**Tools**:
- **Snyk**: Developer-first security
- **Trivy**: Comprehensive vulnerability scanner
- **WhiteSource**: Automated open source security

## Incident Response

### 1. Detection

**Indicators**:
- Unexpected API calls
- Failed login spikes
- Unusual error rates
- Performance degradation
- Security scan alerts

**Monitoring**:
- Error tracking (Sentry, Rollbar)
- Performance monitoring (Datadog, New Relic)
- Security monitoring (SIEM)
- Log aggregation (ELK, Splunk)

### 2. Assessment

**Questions**:
1. What happened?
2. What data was accessed?
3. How did it happen?
4. What is the impact?
5. Is it still happening?

**Severity Levels**:
- **P0 (Critical)**: Data breach, system compromise
- **P1 (High)**: Elevated privileges, service disruption
- **P2 (Medium)**: Potential vulnerability, limited impact
- **P3 (Low)**: Minor issue, no immediate risk

### 3. Containment

**Immediate Actions**:
1. Stop the attack (block IP, disable endpoint)
2. Preserve evidence (logs, database snapshots)
3. Notify stakeholders
4. Assess scope

**Short-term Containment**:
1. Patch vulnerability
2. Rotate compromised credentials
3. Deploy fixes
4. Monitor for reoccurrence

### 4. Eradication

1. Remove attacker access
2. Patch all vulnerabilities
3. Update security controls
4. Verify no backdoors remain

### 5. Recovery

1. Restore from clean backups
2. Verify system integrity
3. Monitor closely
4. Gradual restoration

### 6. Lessons Learned

**Post-Incident Review**:
- What went well?
- What could be improved?
- What should change?
- Action items and owners

**Documentation**:
- Incident timeline
- Root cause analysis
- Response effectiveness
- Preventive measures

## Compliance

### GDPR

- [ ] User consent for data collection
- [ ] Right to access data
- [ ] Right to deletion
- [ ] Data portability
- [ ] Breach notification (72 hours)
- [ ] Data protection impact assessments

### PCI DSS

- [ ] Secure cardholder data
- [ ] Encrypt transmission
- [ ] Maintain secure network
- [ ] Implement access controls
- [ ] Regular testing
- [ ] Security policy

### SOC 2

- [ ] Security controls
- [ ] Availability monitoring
- [ ] Processing integrity
- [ ] Confidentiality measures
- [ ] Privacy protection

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

## Summary

Security is everyone's responsibility:
- ✅ Never commit secrets
- ✅ Validate all input
- ✅ Use parameterized queries
- ✅ Keep dependencies updated
- ✅ Enable security scanning
- ✅ Monitor and respond quickly
- ✅ Learn from incidents
