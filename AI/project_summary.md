# Task Execution Mandate

This document is the single source of truth for the linting resolution process. All subtasks delegated by the orchestrator **must** read this document and follow the procedures outlined herein. The task-specific instructions from the orchestrator (e.g., the batch of issues to resolve) should be considered as arguments to the procedures defined in this document.

# Project Summary: Linting Issue Resolution Process

This document outlines the systematic process for resolving all linting issues in the codebase.

## Phase 1: Initial Linting and Checklist Generation

1.  A single, comprehensive task is executed to lint the entire codebase using `staticcheck`.
2.  The output is parsed into a Markdown checklist and saved as `AI/linting_checklist.md`. Each item includes the file path, line number, and error message.

## Phase 2: Iterative Issue Resolution

1.  **Run Full Pre-Fix Test Suite:** Before applying any changes, run the **entire** project test suite sequentially to establish a clean baseline. The command must be `go test -p 1 ./...`. Capture the full terminal output.

2.  **Apply the Fix:** Implement the code changes required to resolve the specific linting issue.

3.  **Run Full Post-Fix Test Suite:** After applying the fix, run the **entire** test suite again with `go test -p 1 ./...` to confirm the change has not introduced any regressions. Capture the full terminal output.

4.  **Commit the Verified Fix:** If the post-fix tests pass, commit the changes to version control. The commit message must be clear and descriptive (e.g., `fix(lint): Resolve SA1019 in cmd/cayley/command/repl.go`).
    *   Run `git add .`
    *   Run `git commit -m "..."`

5.  **Verify the Commit:** Immediately after committing, retrieve the last commit's title to ensure it was successful and matches the intended change.
    *   Run `git log -1 --pretty=%s` and capture the output.

6.  **Update Checklist and Batch Next Tasks:**
    *   For each completed issue in the batch, use a spot-editing tool (like `apply_diff`) to change `- [ ]` to `- [x]` in `AI/linting_checklist.md`. This is more efficient than rewriting the entire file.
    *   After updating the checklist, identify the next batch of tasks using the strict heuristic...

7.  **Complete Task with Enhanced Reporting:** Signal completion by using the `attempt_completion` tool. The `result` parameter must be a JSON string with the following keys:
    *   `fix_summary`: A string summarizing the fix(es) that were just applied.
    *   `git_commit_title`: The title of the Git commit.
    *   `test_results_summary`: A JSON object with `pre_fix` and `post_fix` keys confirming the test suite passed.
    *   `next_tasks`: An **array of strings**, where each string is a full checklist item for the next batch of tasks. If no unresolved issues are left, this should be an empty array.
    *   `process_notes`: A mandatory string for reporting anomalies, suggestions, or a reflection on the task's execution. Before completing the task, introspect on the safety, correctness, and efficiency (e.g., token usage, process duration) of the completed steps. If there are specific observations or potential improvements, detail them here. If no issues or improvements are found, state: "I have reflected on the process and found no areas for improvement."

# Phase 3: Comprehensive Code Quality Analysis

After an initial linting pass, a deeper analysis will be performed to guide the next phase of improvements.

1.  **Run Comprehensive Analysis:** A dedicated subtask will run a suite of code quality tools (e.g., `staticcheck`, `go vet`, `gocyclo`). The raw output will be saved to `AI/code_quality_report.md`.

2.  **Generate Grouped Checklist:** A second subtask will parse the raw report and generate a new, intelligent checklist named `AI/quality_checklist.md`. This checklist must group related issues to optimize the fixing process. The format should be as follows:

    -   **File:** `path/to/file.go`
        -   `[ ]` **[Error Code]** `Error Message`
            -   `L{line_number}`: `code snippet`
            -   `L{line_number}`: `code snippet`
            -   ...

## General Directives

-   **File Paths:** All file paths are relative to the project root. The `AI/` directory is located at the root of the project. Subtasks must be proactive in constructing correct file paths (e.g., `AI/linting_checklist.md`). If a file is not found, the task should fail with a clear error message rather than requiring manual intervention.
-   **File Modification:** When updating existing files (like `AI/project_summary.md` or `AI/linting_checklist.md`), subtasks must first read the file's current content, apply the changes in memory, and then write the entire modified content back. This prevents accidental data loss.
-   **Continuous Feedback Loop:** Subtasks must operate with caution. If an unexpected situation arises (e.g., a command fails unexpectedly), the subtask should retry the operation. If the issue persists or seems noteworthy, it must be reported in the `process_notes` field of the final JSON result. This creates a constant feedback loop, allowing the orchestrator to adapt and improve the workflow. Specifically, if a test suite run is inconclusive or fails unexpectedly, the subtask must retry the test command **one time**. If the second attempt is also inconclusive, the subtask should proceed with the commit (assuming the pre-fix tests passed) and must report the test runner instability in the `process_notes`. This prevents transient environment issues from halting the workflow.