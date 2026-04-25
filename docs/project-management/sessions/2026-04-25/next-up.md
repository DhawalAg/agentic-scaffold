📋 Complete Scaffold Inventory

Existing Commands (S1 — finalize these)


 #  Command              File                                    Lines  Issue
 ────────────────────────────────────────────────────────────────────────────
 1  /session-start       .claude/commands/session-start.md       48     #4
 2  /session-end         .claude/commands/session-end.md         53     #1
 3  /project-status      .claude/commands/project-status.md      43     #2
 4  /create-issue        .claude/commands/create-issue.md        56     #8
 5  /todo                .claude/commands/todo.md                71     #6
 6  /milestone-progress  .claude/commands/milestone-progress.md  31     #9


New Commands (S2 — implement after S1)


 #  Command   Issue  Source
 ────────────────────────────────────────────────────
 7  /work     #10    workflow-skeleton.md + robzolkos
 8  /ship     #11    workflow-skeleton.md + Hey-Diga
 9  /reflect  #12    robzolkos + eidos


Infra (S3 — hooks & templates)


 #   Item                  Issue  Source
 ─────────────────────────────────────────────────────
 10  Post-compact hook     #13    Dicklesworthstone
 11  Collate reviews       #14    (your review notes)
 12  CLAUDE.md refinement  #15    VILA-Lab + agents-md


Scripts & Templates (existing, not tracked as issues)


 Item                File
 ──────────────────────────────────────────────────────────────────
 Label setup         scripts/setup-github-labels.sh
 Project init        scripts/init-project.sh
 CLAUDE.md template  CLAUDE.md.template
 Vision template     docs/project-management/01-vision.template.md
 Roadmap template    docs/project-management/05-roadmap.template.md
 Session log format  docs/project-management/sessions/README.md


Review Docs (for Dhawal)


 #  Repo                     File                                             Time
 ───────────────────────────────────────────────────────────────────────────────────
 1  coleam00 /prime + /plan  docs/research/reviews/01-coleam00-prime-plan.md  7 min
 2  robzolkos commands       docs/research/reviews/02-robzolkos-commands.md   10 min
 3  eidos spec-driven        docs/research/reviews/03-eidos-spec-driven.md    10 min
 4  Spec-Flow tiered         docs/research/reviews/04-spec-flow-tiered.md     5 min
 5  Post-compact hook        docs/research/reviews/05-post-compact-hook.md    2 min
 6  pi-skills portable       docs/research/reviews/06-pi-skills-portable.md   3 min
 7  Continuous-Claude        docs/research/reviews/07-continuous-claude.md    5 min


----------------------------------------------------------------------------------------------------------------------------------------------------


🎯 My Recommendation for Attack Order

Right now, today: Start with S1 — finalize the 6 existing commands. We can tackle them one by one, I'll read each command, tighten it up, test it
against this very repo, and commit. Suggested order:

 1 /project-status (#2) — smallest, we can test it immediately against our 12 issues
 2 /milestone-progress (#9) — also small, natural pair with status
 3 /session-start (#4) — the entry point for every session
 4 /session-end (#1) — the exit point
 5 /create-issue (#8) — we literally just used it, let's see if the command matches what we did
 6 /todo (#6) — the big one, save for last

Meanwhile, in parallel: You review the 7 repo docs at your pace and drop your notes. When you're done, I'll collate (#14) and we'll fold the best
bits into S2/S3.

Want to start with /project-status (#2)? It's the perfect test case — we have real milestones and issues to run it against right now. 🐕