# cron setup
All users crontab - at /etc/..., better to specify for each user:

* To edit (or create) your crontab file, use the command crontab -e, and this
will load up the editor specified in the environment variables EDITOR
`export EDITOR=emacs && crontab -e`

* If you want to write your crontab without using the crontab command, you can
write it in a normal text file, using your editor of choice, and then use the
crontab command to replace your current crontab with the file you just wrote.
`crontab <file>` - to replace your existing crontab with the one


# edit crontab
`m    h    day-of-month    month    day-of-week    user    command`
### ...
* `59 11 * * 1,2,3,4,5 root echo "This command is run at 11:59 Monday, Tuesday, Wednesday, Thursday and Friday"`
* `59 11 * * 1-5 root echo "Same as abowe"`
### ...
* `01 * * * * root echo "This command is run at one min past every hour"`
* `17 8 * * * root echo "This command is run daily at 8:17 am"`
* `17 20 * * * root echo "This command is run daily at 8:17 pm"`
* `00 4 * * 0 root echo "This command is run at 4 am every Sunday"`
* `* 4 * * Sun root echo "Same as abowe"`
* `42 4 1 * * root echo "This command is run 4:42 am every 1st of the month"`
### ...
* `01 * 19 07 * root echo "This command is run hourly on the 19th of July"`


# 'step' values.
A value of */2 in the dom field would mean the command runs every two
days and likewise, */5 in the hours field would mean the command runs every 5 hours.


# commands

### list current crontab
`crontab -l `

### remove (i.e. delete) your current crontab
`crontab -r`


# Notes:
* Under dow 0 and 7 are both Sunday.
* If both the dom and dow are specified, the command will be executed when either of the events happen. 
* the output from cron gets mailed to the owner of the process, or the person specified in the MAILTO variable
so `cmd >> log.file` or `cmd > /dev/null`.

