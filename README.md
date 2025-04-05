# Grader-chan testcase converter

This script enables you to convert the testcase from polygon package (linux) into [Grader-chan](https://firefly.gchan.moe/) format instantly

To run it, go to your testcase directory (usually /tests), it will create the following

- input folder
- output folder
- tasks.json

tasks.json format:

```
{
    "ninput": $test_count,
    "name": "problem_name",
    "timelimit": 1000,
    "memorylimit": 64000,
    "mode": "simple",
    "maxscore": 100,
    "subtasks": [
        {
            "input": $test_count,
            "maxscore": 100,
            "group": true
        }
    ]
}
```
where $test_count is automatically filled with the number of testcases present

In case the testcase is out of order or seems to be missing, the tasks.json file will not be generated and a warning message will be displayed

The script will abort if a file or directory named input, output or tasks.json already exists

By default, the script will move the original file (01, 01.a, etc.) to their respective directory. To preserve it simply add -p as an argument, for example:
```
./gc_convert.sh -p
```
