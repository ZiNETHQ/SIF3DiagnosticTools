# Git
This folder contains scripts and advice to help management of A4L Git repositories.

## Frequently Asked Questions

### What is Git?
Git is a popular version control system (VCS). [Read more about Git](https://git-scm.com/about).

### What is the structure of the locale and global repositories?
This is explained each framework's wiki page titled "Structure of Sif Framework repositories" ([.NET](https://github.com/Access4Learning/sif3-framework-dotnet/wiki/Structure%20of%20Sif%20Framework%20repositories), [Java](https://github.com/Access4Learning/sif3-framework-java/wiki/Structure%20of%20Sif%20Framework%20repositories)).

### How do I contribute?
First, check the contributing guidlines the framework you want to work on ([.NET](https://github.com/Access4Learning/sif3-framework-dotnet/wiki/Contributing%20to%20Sif%203%20Framework%20.NET), [Java](https://github.com/Access4Learning/sif3-framework-java/wiki/Contributing%20to%20Sif%203%20Framework%20Java)).

Make sure to read the coding style guide for your chosen framework ([.NET](https://github.com/Access4Learning/sif3-framework-dotnet/wiki/SIF%203%20Framework%20.NET%20coding%20style), [Java](https://github.com/Access4Learning/sif3-framework-java/wiki/SIF3%20Framework%20Java%20coding%20style)).

And make sure to read any appropriate documentation in youre chosen framework.

### With global and locale repositories, how to I ensure my repositories are up to date?
Syncing your local repositories can be achieved manually in Git. These instructions assume you are working on the `develop` branch of a forked project from the locale appropriate to you ([AU](https://github.com/nsip), NA, or [UK](https://github.com/Access4LearningUK)).

First, make sure you have an `upstream` remote that points to your locale repository. Note that it is possible that the A4L Git Guardian for your locale has not yet synced the locale repository to ensure it has all recent changes. To make sure you have all available changes you may also want to add a `global` remote too. For example, if you are using the UK locale's .NET framework do:
```git
git remote add upstream https://github.com/Access4LearningUK/sif3-framework-dotnet.git
git remote add global https://github.com/Access4Learning/sif3-framework-dotnet.git
```
Then, pull in any changes from your `origin` and your `upstream`:
```git
git checkout develop
git pull origin develop
git pull upstream develop
git pull global develop
```

### I have been nominated as A4L Git Guardian for my locale, how to I ensure my locale repositories are up to date?
Congratulations!

Being an A4L Git Guardian comes with some responsibility. One of which will be to make sure your locale is regularly up to date with the global repositories of the frameworks.

As an A4L Git Guardian you will have been granted `pull` rights from the global repository and `push` rights to your locale's repository.

Syncing your locale's repositories can be achieved manually in Git by first getting a clean clone of your locale's repository and setting it up with the right `upstream` remote and branches:
```git
git clone [localeURL]/[framework].git
git remote add upstream [globalURL]/[framework].git
git checkout -b develop origin/develop
```

Then in both the `master` and `develop` branches `pull` any changes from `upstream` and `push` them back to `origin`:  
```git
git checkout [branch]
git pull origin [branch]
git pull upstream [branch]
git push origin [branch]
```

But, this can get tedious, so in this folder there are three scripts that automate this process for you:
- `au-locale-sync.cmd`
- `na-locale-sync.cmd`
- `uk-locale-sync.cmd`

Each script has been set up with current repository URLs (correct as of 2016-07-20, *__NB:__ NA locale is not yet established, script will intentionally fail*). It will fail should the error code of any command return a non-zero error state, meaning if a `pull` needs action to merge incomming changes the script stops so you can address those conflicts. The script can then be run again to complete the process. 

For example, as a A4L Git Guardian for the UK you might:
1. Make a new directory on your desktop, let's call it `a4lsync`
2. Copy the script `uk-locale-sync.cmd` into `a4lsync`
3. Open a Git Bash shell inside the `a4lsync` folder
4. Type `./uk-locale-sync.cmd` to execute the script
5. Fix any sync issues until all completes successfully

The `a4lsync` folder can be retained for future use, but its deletion is recommended. This is reduce the possibility of using these repositories for any purpose other than to sync global changes into locale repositories. That is, to keep these clones of the locale repositories clean from any local changes.