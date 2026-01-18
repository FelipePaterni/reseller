# Security Policy

We take security seriously. Please follow this policy to report vulnerabilities and keep users safe.

## Supported Versions

We actively maintain and accept security fixes for:
- Main branch (active development)
- 0.1.x releases

Older versions may not receive fixes. Please upgrade to the latest version.

## Reporting a Vulnerability

- Do NOT open a public issue.
- Submit a private report via GitHub Security Advisories:
  - https://github.com/FelipePaterni/reseller/security/advisories/new
- Include:
  - A clear description of the issue and potential impact
  - Steps to reproduce and, if possible, a minimal proof-of-concept
  - Affected version/commit and environment details (Flutter/Dart versions, platform)
  - Any suggested remediation or patches (optional)

We appreciate responsible disclosure and will credit reporters (if desired).

## Disclosure Policy & Timelines

- Acknowledgement: within 3 business days
- Triage & initial assessment: within 7 days
- Fix timeline: typically within 30 days; critical issues prioritized (target 14 days)
- Coordination: we will publish a new release and changelog entry with mitigation instructions

If exploitation in the wild is suspected, we will expedite timelines and may issue interim guidance.

## Scope

In scope:
- Application code, configuration, and build scripts within this repository

Out of scope:
- Third-party dependencies (please report upstream as well; we will track and patch via updates)
- Issues requiring physical access, social engineering, or vendor OS/runtime vulnerabilities

## Security Best Practices for Contributors

- Do not hardcode secrets, API keys, or credentials in code or configuration
- Avoid storing sensitive data; if necessary, use platform-secure storage
- Validate and sanitize all external inputs
- Prefer safe serialization/deserialization; avoid dynamic `eval`-like behavior
- Limit permissions and follow least-privilege principles
- Use the `security` label for security-related PRs/issues to aid triage

## Dependencies & Supply Chain

If you discover a vulnerability in a dependency used by this project:
- Open a private advisory (above) and include details
- Link the upstream advisory or issue if available
- We will evaluate mitigation (update, replace, or patch)

## Credit & Bounty

We currently do not run a bug bounty program. However, we will acknowledge researchers in release notes when requested.

## Contact

For security matters only, use GitHub Security Advisories:
- https://github.com/FelipePaterni/reseller/security/advisories/new

For general questions, use GitHub Issues with the `question` label or Discussions.
