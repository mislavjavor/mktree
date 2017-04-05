# `mktree`

A simple tool for quick creation of file structures made in Swift

# Usage

```bash
$ Mislavs-MacBook-Pro:mktree mislavjavor$ .build/debug/mktree ~/Desktop
$ Start creating directory structure
$ Root directory name: MyRootDir
$ {/Users/mislavjavor/Desktop/MyRootDir} ~command >> \dir inner
$ name: inner files: []
$ {/Users/mislavjavor/Desktop/MyRootDir/inner} ~command >> \file abc.js
$ {/Users/mislavjavor/Desktop/MyRootDir/inner} ~command >> \file def.js
$ {/Users/mislavjavor/Desktop/MyRootDir/inner} ~command >> \file des.js
$ {/Users/mislavjavor/Desktop/MyRootDir/inner} ~command >> \up
$ {/Users/mislavjavor/Desktop/MyRootDir} ~command >> \dir holder fileone.js filetwo.js filethree.js
$ name: holder files: ["fileone.js", "filletwo.js", "filethree.js"]
$ {/Users/mislavjavor/Desktop/MyRootDir/holder} ~command >> \end
```

# Commands

`dir` - `\dir <directory-name> <file1> <file2> ... <fileN>`

`file` - `\file <file-name> <file-content>`

# Author

Mislav Javor

mislav.javor@outlook.com
