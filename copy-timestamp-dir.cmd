@ECHO OFF

REM Before running this code check the date format in windows and remove REM in below lines where necessary

REM If date format is (dd-mmm-yy) then use below code by removing REM in below two lines
REM SET LOGFILE_DATE=%DATE%
REM SET FOLDER_DATE=%DATE%_


REM If date format is (dd/mmm/yyyy) then use below code by removing REM in below two lines
REM SET LOGFILE_DATE=%DATE:~-4,4%-%DATE:~-8,3%-%DATE:~-11,2%
REM SET FOLDER_DATE=%DATE:~-4,4%-%DATE:~-8,3%-%DATE:~-11,2%_


REM If date format is (m/dd/yyy) then use below code removing REM in below two lines
REM SET LOGFILE_DATE=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%
REM SET FOLDER_DATE=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_


REM For avoiding space in time when time is 24 hour format
SET hour=%time:~0,2%
IF "%hour:~0,1%" == " " SET hour=0%hour:~1,1%
SET min=%time:~3,2%
IF "%min:~0,1%" == " " SET min=0%min:~1,1%
SET secs=%time:~6,2%
IF "%secs:~0,1%" == " " SET secs=0%secs:~1,1%

SET LOGFILE_TIME=%hour%-%min%-%secs%

SET FOLDER_TIME=%hour%%min%%secs%

SET LOG_FILE=Backup_%LOGFILE_DATE%_%LOGFILE_TIME%.log

REM If file is not shared then then use NET USE with user and pass to map the windows administrative share
SET SRC=\\source\Data

REM Keep destination name without space, DON'T put "" in ROOT var value
SET ROOT=\\Destination_Location
CD /D %ROOT%
MKDIR %FOLDER_DATE%%FOLDER_TIME% 

SET DEST=%ROOT%%FOLDER_DATE%%FOLDER_TIME%

REM Finally copy the file
ROBOCOPY %SRC% %DEST% /E /MT:20 /R:10 /Log:Log_Location\%LOG_FILE% /TEE

