# Intellij case sensistive fs fix

If you are using JetBrains excellent tools on OS X like me and have a case sensitive file system, I guess you are sick and tired of manually editing the idea.properties to match your filesystem. Well, at least I am!

## The problem

Each app from jetBrains (CLion, WebStorm, IntelliJ etc) has it's own config file. By default, this file does not include the directive *idea.case.sensitive.fs=true*. I guess that most of us arent using a case sensitive filesystem. Well, I do. I come from FreeBSD and Linux (for more than one and a half decade. Having a FS which is case insensitive feels just wrong. Hence, I have opted in for case sensitivity.

## The Solution

You need to open the file and add a directive. This is cumbersome. The PERL-script `update.pl` will do this for you automatically. Just place it into your home folder and run when needed.

## Assumptions
Your config files are located in the default location *~/Library/ApplicationSupport/JetBrains*

## Synopsis
    ❯ chmod +x update.pl
    ❯ ./update.pl
Then you will get a report of which files were touched by the script.

## Cron
Maybe place it in your cron-tab and make it run once a day? Then no more nagging and manual editing.

## Disclaimer
I haven't written Perl in a while .. a long while. Use the script at own risk.
