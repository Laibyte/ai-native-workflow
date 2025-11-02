### **5.2. The Seamless Linear-to-GitHub-to-Deploy Workflow**

This is the complete, end-to-end "feature delivery" flow, synthesizing all components of this report. It demonstrates a unified process from issue creation to production deployment.

**Actionable Deliverable: Step-by-Step Workflow**

 1. **Setup:** An administrator connects the Cursor integration to the team's Linear workspace.  
 2. **Triage:** A Product Manager assigns a Linear issue directly to the `@Cursor` user in Linear.  
 3. **Agent Action:** A Cursor Background Agent automatically:  
    * Picks up the Linear issue.
    * Clones the default GitHub repository.
    * Creates a new branch (e.g., `ai-linear-123`).
    * Reads the project context (`.cursor/rules/index.mdc`, `docs/ARCHITECTURE.md`, etc.).
 4. **Development:** The agent develops the feature based on the Linear issue's description.
 5. **Self-Validation (Phase 1):** The "YOLO mode" hook (Section 1.2) automatically runs `vitest` and `tsc`, forcing the agent to iterate until all tests and type checks pass.
 6. **Push (Phase 2):** The agent:
    * Generates a PR description and saves it to `PR_DESCRIPTION.md` (Section 3.3).
    * Generates a Conventional Commit message (Section 1.1).
    * Pushes the branch to the repository.  
 7. **Automation (Phase 3):**
    * The branch push triggers the `.github/workflows/auto-pr.yml` action (Section 3.3), which automatically *creates the Pull Request*, using the `PR_DESCRIPTION.md` file as its body.
 8. **CI/CD (Phase 4):**
    * The PR creation triggers the `.github/workflows/ci-typescript.yml` action (Section 4.1), which runs the full linting, testing, and build pipeline.
 9. **Review (Phase 5):**
    * A human engineer receives a notification for a new PR.
    * The PR is already populated with a description, a link to the Linear issue, and a "green" checkmark from CI.
    * The engineer performs a high-level review of the intent and architecture, aided by the AI's 14-point self-review (Section 3.4).
10. **Deploy (Phase 6):**
    * The engineer approves and merges the PR.
    * The merge to `main` triggers the `.github/workflows/deploy-cloudflare-pages.yml` action (Section 4.4).
    * The feature is now live in production.