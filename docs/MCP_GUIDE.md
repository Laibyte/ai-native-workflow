# MCP (Model Context Protocol) Server Integration Guide

Guide to extending Cursor capabilities with MCP servers for databases, payments, hosting, and more.

## What is MCP?

Model Context Protocol (MCP) allows AI agents to interact with external services securely and efficiently. MCP servers extend Cursor's capabilities beyond code generation.

## Use Cases

- **Database**: Query, migrate, seed data (Supabase, PostgreSQL, MongoDB)
- **Payments**: Create checkout sessions, manage subscriptions (Stripe, PayPal)
- **Hosting**: Deploy apps, manage DNS (Vercel, Netlify, Cloudflare)
- **Search**: Full-text search, embeddings (Algolia, Elasticsearch)
- **Documentation**: Fetch docs, generate examples (MDN, npm docs)
- **Observability**: Query logs, metrics, traces (Datadog, Sentry)

## Available MCP Servers

### Database Servers

#### Supabase MCP Server

**Capabilities**:
- Create/read/update/delete operations
- Run raw SQL queries
- Manage auth users
- Handle file storage
- Real-time subscriptions

**Setup**:
```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"],
      "env": {
        "SUPABASE_URL": "https://your-project.supabase.co",
        "SUPABASE_SERVICE_ROLE_KEY": "your-service-role-key"
      }
    }
  }
}
```

**Usage Examples**:
```typescript
// Create a table
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

// Insert data
INSERT INTO users (email) VALUES ('user@example.com');

// Query data
SELECT * FROM users WHERE email = 'user@example.com';
```

**Security**:
- Use service role key (server-side only)
- Store key in environment variables
- Implement Row Level Security (RLS)
- Audit all database operations

#### PostgreSQL MCP Server

**Capabilities**:
- Execute SQL queries
- Manage schemas
- Run migrations
- Performance analysis

**Setup**:
```json
{
  "mcpServers": {
    "postgresql": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "postgresql://user:password@localhost:5432/dbname"
      }
    }
  }
}
```

### Payment Servers

#### Stripe MCP Server

**Capabilities**:
- Create checkout sessions
- Manage subscriptions
- Handle webhooks
- Process refunds
- Retrieve customer data

**Setup**:
```json
{
  "mcpServers": {
    "stripe": {
      "command": "npx",
      "args": ["-y", "@stripe/mcp-server"],
      "env": {
        "STRIPE_SECRET_KEY": "sk_test_...",
        "STRIPE_WEBHOOK_SECRET": "whsec_..."
      }
    }
  }
}
```

**Usage Examples**:
```typescript
// Create checkout session
const session = await stripe.checkout.sessions.create({
  payment_method_types: ['card'],
  line_items: [{
    price_data: {
      currency: 'usd',
      product_data: { name: 'Pro Plan' },
      unit_amount: 2000,
    },
    quantity: 1,
  }],
  mode: 'payment',
  success_url: 'https://example.com/success',
  cancel_url: 'https://example.com/cancel',
});

// Create subscription
const subscription = await stripe.subscriptions.create({
  customer: 'cus_...',
  items: [{ price: 'price_...' }],
});

// Handle webhook
const event = stripe.webhooks.constructEvent(
  req.body,
  req.headers['stripe-signature'],
  process.env.STRIPE_WEBHOOK_SECRET
);
```

**Security**:
- Use test keys in development
- Store keys in environment variables
- Validate webhook signatures
- Implement idempotency
- Log all transactions

### Hosting Servers

#### Vercel MCP Server

**Capabilities**:
- Deploy projects
- Manage domains
- Configure environment variables
- View deployment logs
- Trigger rebuilds

**Setup**:
```json
{
  "mcpServers": {
    "vercel": {
      "command": "npx",
      "args": ["-y", "@vercel/mcp-server"],
      "env": {
        "VERCEL_TOKEN": "your-vercel-token",
        "VERCEL_PROJECT_ID": "prj_..."
      }
    }
  }
}
```

**Usage Examples**:
```bash
# Deploy project
vercel deploy

# List deployments
vercel ls

# View logs
vercel logs deployment-url

# Set env variable
vercel env add API_KEY
```

#### Cloudflare MCP Server

**Capabilities**:
- Deploy Pages projects
- Manage DNS records
- Configure Workers
- Manage KV storage
- Handle R2 buckets

**Setup**:
```json
{
  "mcpServers": {
    "cloudflare": {
      "command": "npx",
      "args": ["-y", "@cloudflare/mcp-server"],
      "env": {
        "CLOUDFLARE_API_TOKEN": "your-api-token",
        "CLOUDFLARE_ACCOUNT_ID": "your-account-id"
      }
    }
  }
}
```

### Search & Documentation Servers

#### Algolia MCP Server

**Capabilities**:
- Index documents
- Search records
- Configure relevance
- Manage replicas
- Analytics

**Setup**:
```json
{
  "mcpServers": {
    "algolia": {
      "command": "npx",
      "args": ["-y", "@algolia/mcp-server"],
      "env": {
        "ALGOLIA_APP_ID": "your-app-id",
        "ALGOLIA_API_KEY": "your-admin-key"
      }
    }
  }
}
```

#### npm Documentation Server

**Capabilities**:
- Fetch package docs
- View API references
- Get usage examples
- Check versions

**Setup**:
```json
{
  "mcpServers": {
    "npm-docs": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-npm"]
    }
  }
}
```

### Observability Servers

#### Sentry MCP Server

**Capabilities**:
- Query error events
- View stack traces
- Manage releases
- Track performance

**Setup**:
```json
{
  "mcpServers": {
    "sentry": {
      "command": "npx",
      "args": ["-y", "@sentry/mcp-server"],
      "env": {
        "SENTRY_AUTH_TOKEN": "your-auth-token",
        "SENTRY_ORG": "your-org",
        "SENTRY_PROJECT": "your-project"
      }
    }
  }
}
```

## Configuration

### Cursor Settings

Add MCP servers to Cursor settings:

**Location**: Cursor Settings → Advanced → MCP Servers

**Format**:
```json
{
  "mcpServers": {
    "server-name": {
      "command": "command-to-run",
      "args": ["arg1", "arg2"],
      "env": {
        "KEY": "value"
      }
    }
  }
}
```

### Environment Variables

**Best Practices**:
1. Store secrets in `.env` file (gitignored)
2. Use different keys for dev/prod
3. Rotate keys regularly
4. Use least-privilege access
5. Monitor usage

**Example .env**:
```env
# Database
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_ROLE_KEY=xxx

# Payments
STRIPE_SECRET_KEY=sk_test_xxx
STRIPE_WEBHOOK_SECRET=whsec_xxx

# Hosting
VERCEL_TOKEN=xxx
CLOUDFLARE_API_TOKEN=xxx

# Search
ALGOLIA_APP_ID=xxx
ALGOLIA_API_KEY=xxx

# Observability
SENTRY_AUTH_TOKEN=xxx
```

### Permission Scoping

**Principle of Least Privilege**:
- Grant only necessary permissions
- Use read-only keys when possible
- Separate dev and prod credentials
- Audit permissions quarterly

**Example Scopes**:

**Stripe**:
```
✅ payments_read
✅ customers_read
✅ subscriptions_write
❌ accounts_write (not needed)
```

**Vercel**:
```
✅ deployments:read
✅ deployments:write
❌ teams:write (not needed)
```

**Supabase**:
```
✅ Use service role key for admin operations
✅ Implement Row Level Security
✅ Create specific roles for different access levels
```

## Security Best Practices

### 1. Credential Management

```typescript
// ❌ BAD - Hardcoded credentials
const stripe = new Stripe('sk_live_abc123...');

// ✅ GOOD - Environment variables
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!);
```

### 2. Input Validation

```typescript
// Validate before sending to MCP server
function createCheckout(amount: number, currency: string) {
  if (amount <= 0) {
    throw new Error('Invalid amount');
  }
  if (!['usd', 'eur', 'gbp'].includes(currency)) {
    throw new Error('Invalid currency');
  }
  
  // Now safe to use with MCP server
  return stripe.checkout.sessions.create({...});
}
```

### 3. Rate Limiting

```typescript
// Implement rate limiting for MCP calls
const limiter = rateLimit({
  windowMs: 60 * 1000, // 1 minute
  max: 100 // 100 requests per minute
});

app.use('/api/mcp', limiter);
```

### 4. Audit Logging

```typescript
// Log all MCP operations
function auditLog(operation: string, data: any) {
  logger.info('MCP Operation', {
    operation,
    timestamp: Date.now(),
    user: getCurrentUser(),
    data: sanitize(data)
  });
}

auditLog('stripe.checkout.create', { amount: 1000 });
```

### 5. Error Handling

```typescript
// Handle MCP errors gracefully
try {
  const result = await mcpServer.execute(operation);
  return result;
} catch (error) {
  // Log error (don't expose to user)
  logger.error('MCP Error', { error, operation });
  
  // Return user-friendly message
  throw new Error('Operation failed. Please try again.');
}
```

## Integration Patterns

### Pattern 1: Database as Source of Truth

Use MCP server to sync code with database schema:

```typescript
// Agent can query current schema
const schema = await supabase.getSchema();

// Generate TypeScript types
generateTypes(schema);

// Create migration if schema changes detected
if (schemaChanged) {
  await supabase.createMigration(diff);
}
```

### Pattern 2: Payment Flow Generation

Generate complete payment flows:

```typescript
// Agent generates:
// 1. Checkout component
// 2. Webhook handler
// 3. Success/cancel pages
// 4. Email templates

const paymentFlow = await generatePaymentFlow({
  provider: 'stripe',
  products: ['pro-plan'],
  features: ['webhooks', 'subscriptions']
});
```

### Pattern 3: Deploy Preview Automation

Automatically deploy previews for PRs:

```typescript
// On PR open/update:
// 1. Build app
// 2. Deploy to Vercel/Cloudflare
// 3. Comment preview URL on PR
// 4. Run smoke tests

const preview = await deployPreview({
  pr: prNumber,
  branch: branchName,
  envVars: stagingEnv
});

await commentOnPR(prNumber, `Preview: ${preview.url}`);
```

### Pattern 4: Observability Integration

Generate observability setup:

```typescript
// Agent creates:
// 1. Sentry initialization
// 2. Error boundaries
// 3. Performance monitoring
// 4. Custom dashboards

const monitoring = await setupMonitoring({
  framework: 'react',
  tools: ['sentry', 'datadog'],
  metrics: ['web-vitals', 'api-latency']
});
```

## Creating Custom MCP Servers

### Basic Structure

```typescript
import { MCPServer } from '@modelcontextprotocol/sdk';

class CustomMCPServer extends MCPServer {
  constructor() {
    super({
      name: 'custom-server',
      version: '1.0.0'
    });
    
    this.registerTool('customAction', this.customAction);
  }
  
  async customAction(params: any) {
    // Implement action
    return { result: 'success' };
  }
}

// Start server
const server = new CustomMCPServer();
server.start();
```

### Example: GitHub MCP Server

```typescript
class GitHubMCPServer extends MCPServer {
  private octokit: Octokit;
  
  constructor() {
    super({ name: 'github', version: '1.0.0' });
    
    this.octokit = new Octokit({
      auth: process.env.GITHUB_TOKEN
    });
    
    this.registerTool('createIssue', this.createIssue);
    this.registerTool('createPR', this.createPR);
    this.registerTool('getIssues', this.getIssues);
  }
  
  async createIssue(params: {
    owner: string;
    repo: string;
    title: string;
    body: string;
  }) {
    const issue = await this.octokit.issues.create(params);
    return issue.data;
  }
  
  async createPR(params: {
    owner: string;
    repo: string;
    title: string;
    head: string;
    base: string;
    body: string;
  }) {
    const pr = await this.octokit.pulls.create(params);
    return pr.data;
  }
  
  async getIssues(params: {
    owner: string;
    repo: string;
    state?: 'open' | 'closed' | 'all';
  }) {
    const issues = await this.octokit.issues.listForRepo(params);
    return issues.data;
  }
}
```

## Troubleshooting

### Server Not Starting

**Check**:
1. Command is correct and executable
2. Dependencies are installed
3. Environment variables are set
4. Port is not already in use

**Debug**:
```bash
# Test command manually
npx -y @supabase/mcp-server

# Check env vars
echo $SUPABASE_URL

# View Cursor logs
# Cursor → Help → Show Logs
```

### Authentication Failures

**Check**:
1. API keys are correct
2. Keys have necessary permissions
3. Keys are not expired
4. Service is not rate-limited

**Fix**:
```bash
# Rotate key
# Update .env
# Restart Cursor
```

### Performance Issues

**Optimize**:
1. Cache responses
2. Batch requests
3. Use read replicas
4. Implement pagination
5. Set timeouts

## Best Practices

1. **Start Small**: Begin with one MCP server
2. **Test Thoroughly**: Verify before production
3. **Monitor Usage**: Track API calls and costs
4. **Rotate Credentials**: Regular key rotation
5. **Document Access**: Who has what keys
6. **Audit Logs**: Review MCP operations
7. **Graceful Degradation**: Handle server failures
8. **Cost Management**: Set alerts and limits

## Resources

- [MCP Specification](https://spec.modelcontextprotocol.io/)
- [MCP SDK Documentation](https://github.com/modelcontextprotocol/sdk)
- [Cursor MCP Guide](https://cursor.sh/docs/mcp)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)

## Summary

MCP servers extend Cursor's capabilities:
- ✅ Database operations (Supabase, PostgreSQL)
- ✅ Payment processing (Stripe)
- ✅ Deployment automation (Vercel, Cloudflare)
- ✅ Search integration (Algolia)
- ✅ Observability (Sentry)
- ✅ Custom integrations

Use with security in mind, start simple, scale gradually.
