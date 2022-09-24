# Orb Template

Find stale documentation through CI.

`stale.md` is a CircleCI orb that identifies stale documentation (ie 90 days of unchanged `.md` file) and warns developers on maintaining their documentation.

# Usage

```bash
@orb reference TBD

description: >
  Identify Stale Documentation
steps:
  - stale.md/scan
```

# Options

```bash
parameters:
  IGNORED_FILES:
    type: string
    default: "./.github/PULL_REQUEST_TEMPLATE/PULL_REQUEST.md"
    description: "files to be ignored (space-separated)"
  DAYS_THRESHOLD:
    type: string
    default: "90"
    description: "Time threshold in days"
```

[Example here](./src/commands/main.yml).

# Motivation

Inspired by [Software Engineering at Google](https://www.goodreads.com/book/show/48816586-software-engineering-at-google), where there was a reference that Google runs a similar pattern internally to embrace continuous software engineering developments and constantly update their documentation.

By utilizing this orb command, developers are reminded that while their software updates so does their documentation.

This orb aims to treat documentation as a first-class citizen, similar to production level code where documentation is always remaining up to date.

# License

[MIT](./LICENSE)