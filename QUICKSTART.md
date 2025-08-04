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

## Creating Prompt for Agent

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

1. Navigate to your source directory.

2. Generate Prompt.md 

```
git clone https://github.com/reski-rukmantiyo/claude-tmux-prompt-gen
cd claude-tmux-prompt-gen
chmod +x generate_claude.sh
./generate_claude.sh
cd ..
```

3. Clone the repo:

```
git clone https://github.com/reski-rukmantiyo/tmux-orchestrator
cd tmux-orchestrator
chmod +x schedule_with_note.sh
chmod +x send-claude-message.sh
```

4. Start the tmux

```
tmux new-session -s [name-of-agent]
```


5. Run Claude Code

```
claude --dangerously-skip-permissions
```

please note: this command is to run Claude Code action without stopping for your approval 

6. Test for schedule and test message

```
You are an AI orchestrator. First, let's test that everything works:

1. Check what tmux window you're in:
   Run: tmux display-message -p "#{session_name}:#{window_index}"

2. Test the scheduling script:
   Run: ./schedule_with_note.sh 1 "Test message"

3. If that works, tell me "Setup successful!"

Then I'll give you a project to work on.
```

7. Open prompt.md from specs directory then copy paste into Claude

## Restart

Sometimes, you need to start again your tmux. Here are what you should do

1. Navigate to your source directory.

2. Start the tmux

```
tmux new-session -s [name-of-agent]
```


3. Run Claude Code

```
claude --dangerously-skip-permissions
```

4. Insert into your Claude Code

```
Read again @Claude.md also @LEARNINGS.md, wake all teams then report what's the current status
```
