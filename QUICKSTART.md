# Quick Start Guide

## Planning Specification

To guide you agent armies, you need to define:

1. main_spec.md: the big picture
2. frontend_spec.md: includes UI reference images and implementation plans
3. backend_spec.md: API design, database schemas, and logic
4. integration_spec.md: how everything fits together across teams

### Example

```
PROJECT: E-commerce Checkout  
GOAL: Implement multi-step checkout

CONSTRAINTS:
- Use existing cart state
- Follow design system
- Max 3 API endpoints
- Commit after each step
DELIVERABLES:
1. Shipping form w/ validation  
2. Payment method selection  
3. Order confirmation page  
4. Success/failure handling
SUCCESS CRITERIA:
- Forms validate
- Payment succeeds  
- DB stores order  
- Emails trigger
```

## Prompt

Create prompt.md that is designed to create agent armies based on your requirement

### Example

```
The specs are located in ~/Projects/EcommApp/Specs.

Create:
- A frontend team (PM, Dev, UI Tester)
- A backend team (PM, Dev, API Tester)
- An Auth team (PM, Dev)
Schedule:
- 15-minute check-ins with PMs
- 30-minute commits from devs
- 1-hour orchestrator status sync
Start frontend and backend on Phase 1 immediately. Start Auth on Phase 2 kickoff.
```

## Execution

1. Navigate to your target directory.
2. Clone the repo:

```
git clone https://github.com/reski-rukmantiyo/tmux-orchestrator
```

3. Start the tmux

```
tmux new-session -s [name-of-agent]
```


4. Run Claude Code

```
claude --dangerously-skip-permissions
```

please note: this command is to run Claude Code action without stopping for your approval 