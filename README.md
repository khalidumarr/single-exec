# single-exec
Avoid executing the same file if its already being executed.
This little script creates a PID file for each script file which is executed through it. Doesn't allow same script file to be executed if its PID is in the file and still running. Replaces the old PID in the file with the new PID if process is not running anymore.

## Use Case
Imagine we have one "sync.php" file which is responsible for performing concurrency critical operations. Let's add it to the cron with frequency of every 5 minutes.

If execution of sync.php took bit more than 5 minutes, cron will execute another process for sync.php. At the end we'll end up having too many processes of same script.

This Little file was built to avoid such senarios.

## Usage 
Script works with following two parameters:
1- Directory to store temp process file. (we'll use /tmp in example)
2- Command for executing the task

./single-exec.sh {TEMP_DIR_PATH} {COMMAND_TO_RUN_SCRIPT}

## Example
Running script without single-exec.
```
php sync.php {PARAMS}
```

Now, running with single-exec.
```
./single-exec.sh /tmp php sync.php {PARAMS}
```
