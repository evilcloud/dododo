# DoDoDo - ephermal microtask manager ad reductum

## What is this?

DoDoDo is a CLI microtask manager designed for simplicity. It acknowledges the fleeting nature of tasks, encouraging users to view them as brief actions rather than daunting commitments. At their core, tasks are human-made constructs — set up to help us organize life's complexities. However, these arbitrary criteria often become tyrants of our attention, emotions, guilt, and distractions, pulling us away from the actual goals we set out to achieve.

With DoDoDo, tasks are tools, not treasures. They serve a purpose and then move on. Life is chaotic, and the strictness of tasks in such a world is absurd. This tool hopes to be a step towards liberation from the tyranny of productivity.

## Why Haskell?

Because why the fuck not? It's a beautiful language, not terribly complex, and is almost guaranteed to work with no bugs, **_if_** you get it to compile. I don't really know Haskell that well at all, and I had heavily used ChatGPT to help me out. But so what? The architecture is mine, the hand-holding is mine, and the software is mine too.

## How to use it?

Below is the basic set of commands. They are infinitley expandable, and will be part of the very editable Config file.

`new` [task message] - the genesis of the task

`done` [optional: taskID optional: status] - marks the task with the status, and withit deprioritising it in the view. `done` with no arguments will mark with status `done` the latest task

`undone` [optional: taskID] - reopens the task by removing the status. `undone` with no arguments will open the latest market task moving it back to the prioritised list

`help` - this help

`edit` - a shortcut to the text editor with the `current.txt` loaded, in case the user wants to edit tasks manually. Edit will automatically invoke default editor. If such is not defined, the software will invoke `editor`

`editor` - an editor choser. DoDoDo will check for the presence of the most common editors, including vim, nvim, nano, emacs etc. and let user pick what they like
