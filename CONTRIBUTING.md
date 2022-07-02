# 👋 Welcome to the Safe contributing guide

Thank so much for investing your time in contributing to Safe!

Read our [Code of Conduct](./CODE_OF_CONDUCT.md) to keep our community approachable and respectable.

In this guide you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing, and merging the PR.

## New contributor guide

To get an overview of the project, read the [README](README.md). Here are some resources to help you get started with open source contributions:

- [Finding ways to contribute to open source on GitHub](https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github)
- [Set up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
- [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)

## Getting started

### Commit Convention
One of the most important aspects of versioning is the commits that define changes. However, commits are useless if they don't denote what changes or additions they are making. Given this reason, **we use [performant commits](https://performantcommits-taupe.vercel.app/)**; a commit message convention that consists of three main components:
- **Prefix** (this defines what type of change was made)
- **PWD** (this is where the bulk of the change was made)
- **Change** (this is the actual change that was made)
  
#### Example
>`ft[screens/location] ⇒ 📍 Add Google Maps integration to LocationScreen widget`

1. The `ft` denotes that this is a feature change.
2. The `[screens/location]` denotes that the change is in the screens folder and in the location file.
3. Anything after the `⇒` is the actual commit message describing the change.
### Issues

#### Create a new issue

If you find an issue with the repository or have a feature request with Safe, [search if an issue already exists](https://docs.github.com/en/github/searching-for-information-on-github/searching-on-github/searching-issues-and-pull-requests#search-by-the-title-body-or-comments). If a related issue doesn't exist, you can open a new issue using a relevant [issue form](https://github.com/safedotme/safe/issues/new/choose).

#### Solve an issue

Scan through our [existing issues](https://github.com/safedotme/safe/issues) to find one that interests you. You can narrow down the search using `labels` as filters. See [Labels](https://github.com/safedotme/safe/labels) for more information. If you find an issue to work on, you are welcome to open a PR with a fix.

### Make Changes

#### Make changes locally

This project uses [Flutter](https://doc.rust-lang.org/cargo/getting-started/installation.html). Ensure you have them installed before continuing. Here are the following installation links of Flutter:
- [MacOS](https://docs.flutter.dev/get-started/install/macos)
- [Windows](https://docs.flutter.dev/get-started/install/windows)
- [Linux](https://docs.flutter.dev/get-started/install/linux)

> Note: Safe is being developed primarily on iPhone emulators. Therefore, there might be critical issues when trying to run the app on Android. If you'd like to develop on android, reach out to [mark@joinsafe.me](mailto:mark@joinsafe.me)

- `$ git clone https://github.com/safedotme/safe`
- `$ cd safe`
- For Linux or MacOS users run: `flutter pub get`
  - This will install all of the required dependencies for Safe to build.
- `$ flutter pub run build_runner build --delete-conflicting-outputs ` - Runs all necessary codegen & builds required dependencies.

To quickly run only the iOS app after `prep` you can use:

- `$ open -a Simulator.app` 
- `$ flutter run`

If you are having issues ensure you are using the following versions of Flutter, Dart, and iOS:

- iOS version: **16**
- Dart version: **2.17.5**
- Flutter version: **3.0.3**

### Pull Request

When you're finished with the changes, create a pull request, also known as a PR.

- Fill the "Ready for review" template so that we can review your PR. This template helps reviewers understand your changes as well as the purpose of your pull request.
- Don't forget to [link PR to issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue) if you are solving one.
- Enable the checkbox to [allow maintainer edits](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/allowing-changes-to-a-pull-request-branch-created-from-a-fork) so the branch can be updated for a merge.
  Once you submit your PR, a team member will review your proposal. We may ask questions or request for additional information.
- We may ask for changes to be made before a PR can be merged, either using [suggested changes](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/incorporating-feedback-in-your-pull-request) or pull request comments. You can apply suggested changes directly through the UI. You can make any other changes in your fork, then commit them to your branch.
- As you update your PR and apply changes, mark each conversation as [resolved](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request#resolving-conversations).
- If you run into any merge issues, checkout this [git tutorial](https://lab.github.com/githubtraining/managing-merge-conflicts) to help you resolve merge conflicts and other issues.

### Your PR is merged!

Congratulations 🎉🎉  The Safe team thanks you ✨.

Once your PR is merged, your contributions will be included in the next release of the application.

### Credits

This CONTRIBUTING.md file was modelled after the [github/docs CONTRIBUTING.md](https://github.com/github/docs/blob/main/CONTRIBUTING.md) file, and we thank the original author.