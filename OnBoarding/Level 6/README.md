# Level 6



- Linux | MacOS | Microsoft WSL2

```
 git checkout -b openssl-3.3 origin/openssl-3.3
```

This command does two things:
It creates a new local branch named "openssl-3.3"
It sets up this new branch to track the remote branch "origin/openssl-3.3"
Alternatively, if you're using a more recent version of Git (2.23 or later), you can use the more explicit:

- Linux | MacOS | Microsoft WSL2

```
git switch -c openssl-3.3 origin/openssl-3.3
```

- Verify your branch

- **To verify that you're now on the correct branch, you can use:**

- Linux | MacOS | Microsoft WSL2

```
git branch -vv
```

This will show your current branch and its tracking information.

- To check out the branch without creating a new local branch:

- Linux | MacOS | Microsoft WSL2

```
git checkout origin/openssl-3.3
```

Remember, after checking out the branch, you'll have a local copy of the branch that tracks the remote "origin/openssl-3.3". 

- **Any changes you make will be on your local branch until you push them back to the remote repository**


