@ECHO OFF
REM Setting date format legal for file name in windows 
SET LOGFILE_DATE=%DATE:~-4,4%-%DATE:~-8,3%-%DATE:~-11,2%
SET FILE_DATE=%DATE:~-4,4%-%DATE:~-8,3%-%DATE:~-11,2%_

REM For avoiding space in time 
SET hour=%time:~0,2%
IF "%hour:~0,1%" == " " set hour=0%hour:~1,1%
REM echo hour=%hour%
SET min=%time:~3,2%
IF "%min:~0,1%" == " " set min=0%min:~1,1%
REM echo min=%min%
SET secs=%time:~6,2%
IF "%secs:~0,1%" == " " set secs=0%secs:~1,1%
REM echo secs=%secs%

SET LOGFILE_TIME=%hour%-%min%-%secs%
SET FILE_TIME=%hour%%min%%secs%

SET LOG_FILE=Backup_%LOGFILE_DATE%_%LOGFILE_TIME%.log


REM If file is not shared then then use NET USE with user and pass to map the windows administrative share
SET SRC="\\source\Data"

REM Keep destination name without space, DON'T put "" in DEST var value
SET ROOT=\\Destination_Location
CD /D %ROOT%
MKDIR %FILE_DATE%%FILE_TIME% 

SET DEST=%ROOT%%FILE_DATE%%FILE_TIME%


ROBOCOPY %SRC% %DEST% /E /MT:20 /R:10 /Log:Log_Location\%LOG_FILE% /TEE

