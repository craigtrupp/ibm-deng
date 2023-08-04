## Exercise Items and Summary for Review for Future

<br>

### Initialize Weather Log Report File
* Create a text file called `rx_poc.log`, 
this will be your POC weather report log file, or a text file which contains a growing history of the daily weather data you will scrape. 
    - Each entry in the log file corresponds to a row as in Table 1.
    - Table 1 is simply an extract of a csv file that has the below columns structure

**Next**, Add a header to your weather report!

Your header should consist of the column names from Table 1, delimited by tabs.
Write the header to your weather report..
```sh
# create log file (just within root terminal destination)
touch rx_poc.log

# bind to a variable with command substitution $()
# run at root level for terminal
header=$(echo - e "year\tmonth\tday\tobs_tmp\tfc_temp")
# Redirect output to file and overwrite any existing content
echo $header > rx_poc.log
```

<br>

### Download the Raw Weather Data
* Create a text file called rx_poc.sh and make it an executable Bash script
* Edit rx_poc.sh to download today's weather report from wttr.in
* Download the wttr.in weather report for Casablanca and save it with the filename you created

```sh
# command substitution datastamped file named raw_data_<YYYYMMDD>
weather_report=raw_data_$(date +%Y%m%d)
# raw_data_20230804 

# set city variable, pass to curl command and save it w/filename
city=Casablanca
curl wttr.in/$city --output $weather_report
```

**Let's See What we Got**
```sh
heia@theia-craigtrupp8:/home/project$ touch rx_poc.log
theia@theia-craigtrupp8:/home/project$ ls -l
total 24
-rw-r--r-- 1 theia users 9162 Aug  4 15:55 raw_data_20230804
-rw-r--r-- 1 theia users   31 Aug  4 16:21 rx_poc.log
-rwxr-xr-x 1 theia users  300 Aug  4 15:55 rx_poc.sh
-rwxr-xr-x 1 theia users  354 Aug  4 15:44 sh_test_commands.sh
-rw-r--r-- 1 theia users    0 Aug  4 15:40 weather_shell.sh
theia@theia-craigtrupp8:/home/project$ header=$(echo -e "year\tmonth\tday\tobs_tmp\tfc_temp")
theia@theia-craigtrupp8:/home/project$ echo $header > rx_poc.log
theia@theia-craigtrupp8:/home/project$ ls -l
total 24
-rw-r--r-- 1 theia users 9162 Aug  4 15:55 raw_data_20230804
-rw-r--r-- 1 theia users   31 Aug  4 16:22 rx_poc.log
-rwxr-xr-x 1 theia users  300 Aug  4 15:55 rx_poc.sh
-rwxr-xr-x 1 theia users  354 Aug  4 15:44 sh_test_commands.sh
-rw-r--r-- 1 theia users    0 Aug  4 15:40 weather_shell.sh
theia@theia-craigtrupp8:/home/project$ cat rx_poc.log
year month day obs_tmp fc_temp
theia@theia-craigtrupp8:/home/project$ touch rx_poc.sh
theia@theia-craigtrupp8:/home/project$ chmod +x rx_poc.
chmod: cannot access 'rx_poc.': No such file or directory
theia@theia-craigtrupp8:/home/project$ chmod +x rx_poc.sh 
theia@theia-craigtrupp8:/home/project$ ls -l
total 24
-rw-r--r-- 1 theia users 9162 Aug  4 15:55 raw_data_20230804
-rw-r--r-- 1 theia users   31 Aug  4 16:22 rx_poc.log
-rwxr-xr-x 1 theia users  300 Aug  4 16:23 rx_poc.sh
-rwxr-xr-x 1 theia users  354 Aug  4 15:44 sh_test_commands.sh
-rw-r--r-- 1 theia users    0 Aug  4 15:40 weather_shell.sh
theia@theia-craigtrupp8:/home/project$ weather_report=raw_data_$(date +%Y%m%d)
theia@theia-craigtrupp8:/home/project$ city=Casablanca
theia@theia-craigtrupp8:/home/project$ curl wttr.in/$city --output $weather_report
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  9162  100  9162    0     0  14473      0 --:--:-- --:--:-- --:--:-- 14473
theia@theia-craigtrupp8:/home/project$ ls -l
total 24
-rw-r--r-- 1 theia users 9162 Aug  4 16:25 raw_data_20230804
-rw-r--r-- 1 theia users   31 Aug  4 16:22 rx_poc.log
-rwxr-xr-x 1 theia users  300 Aug  4 16:23 rx_poc.sh
-rwxr-xr-x 1 theia users  354 Aug  4 15:44 sh_test_commands.sh
-rw-r--r-- 1 theia users    0 Aug  4 15:40 weather_shell.sh
theia@theia-craigtrupp8:/home/project$ cat raw_data_20230804 
Weather report: Casablanca

     \  /       Partly cloudy
   _ /"".-.     +24(26) °C     
     \_(   ).   ↙ 19 km/h      
     /(___(__)  6 km           
                0.0 mm         
                                                       ┌─────────────┐                                                       
┌──────────────────────────────┬───────────────────────┤  Fri 04 Aug ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│     \   /     Sunny          │     \   /     Sunny          │     \   /     Sunny          │     \   /     Clear          │
│      .-.      +24(25) °C     │      .-.      +29(31) °C     │      .-.      +28(30) °C     │      .-.      +23(25) °C     │
│   ― (   ) ―   ↘ 7-8 km/h     │   ― (   ) ―   ↘ 15-17 km/h   │   ― (   ) ―   ↓ 13-15 km/h   │   ― (   ) ―   ↓ 9-13 km/h    │
│      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │
│     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘
                                                       ┌─────────────┐                                                       
┌──────────────────────────────┬───────────────────────┤  Sat 05 Aug ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│     \   /     Sunny          │     \   /     Sunny          │     \   /     Sunny          │     \   /     Clear          │
│      .-.      +25(27) °C     │      .-.      +31(35) °C     │      .-.      +29(32) °C     │      .-.      +25(27) °C     │
│   ― (   ) ―   → 6 km/h       │   ― (   ) ―   ↘ 12-14 km/h   │   ― (   ) ―   → 12-14 km/h   │   ― (   ) ―   ↗ 11-17 km/h   │
│      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │
│     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘
                                                       ┌─────────────┐                                                       
┌──────────────────────────────┬───────────────────────┤  Sun 06 Aug ├───────────────────────┬──────────────────────────────┐
│            Morning           │             Noon      └──────┬──────┘     Evening           │             Night            │
├──────────────────────────────┼──────────────────────────────┼──────────────────────────────┼──────────────────────────────┤
│     \   /     Sunny          │     \   /     Sunny          │     \   /     Sunny          │     \   /     Clear          │
│      .-.      +26(28) °C     │      .-.      +31(37) °C     │      .-.      +27(29) °C     │      .-.      +25(27) °C     │
│   ― (   ) ―   ↗ 12-14 km/h   │   ― (   ) ―   → 15-17 km/h   │   ― (   ) ―   → 15-17 km/h   │   ― (   ) ―   → 10-18 km/h   │
│      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │      `-’      10 km          │
│     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │     /   \     0.0 mm | 0%    │
└──────────────────────────────┴──────────────────────────────┴──────────────────────────────┴──────────────────────────────┘
Location: Casablanca ⵜⵉⴳⵎⵉ ⵜⵓⵎⵍⵉⵍⵜ الدار البيضاء, préfecture d'arrondissements de Casablanca-Anfa عمالة مقاطعات الدار البيضاء أنفا, Pachalik de Casablanca, Préfecture de Casablanca عمالة الدار البيضاء, Casablanca-Settat ⵜⵉⴳⵎⵉ ⵜⵓⵎⵍⵉⵍⵜ-ⵙⵟⵟⴰⵜ الدار البيضاء-سطات, ⵍⵎⵖⵔⵉⴱ المغرب [33.5949733,-7.6188008]

Follow @igor_chubin for wttr.in updates
```

* Well ... neat! Let's look at our files again real quick for permissions and the total files
    - The curl command above **"curl wttr.in/$city --output $weather_report"** is what assignes casblanca to the like HTTP request and the --output flack then uses our declared weather report which is using the command prompt return for a dynamic data to make the file we see below now in our project repository
```sh
theia@theia-craigtrupp8:/home/project$ ls -l
total 24
-rw-r--r-- 1 theia users 9162 Aug  4 16:25 raw_data_20230804
-rw-r--r-- 1 theia users   31 Aug  4 16:22 rx_poc.log
-rwxr-xr-x 1 theia users  300 Aug  4 16:23 rx_poc.sh
```

<br>

### **Extract and Load Required Data**
* Edit `rx_poc.sh` to extract the required data from the raw data file and assign them to variables obs_tmp and fc_temp
    - Extracting the required data is a process that will take some trial and error until you get it right. 
    - Study the weather report you downloaded, determine what you need to extract, and look for patterns.

You are looking for ways to 'chip away' at the weather report by:

* Using shell commands to extract only the data you need (the signal)
* Filtering everything else out (the noise)
* Combining your filters into a pipeline (recall the use of pipes to chain filters together)

```sh
# Now we can use the grep to target the values of interest
grep °C $weather_report

# Output is looking at the output we assigned to this value 
   _ /"".-.     +24(26) °C     
│      .-.      +24(25) °C     │      .-.      +29(31) °C     │      .-.      +28(30) °C     │      .-.      +23(25) °C     │
│      .-.      +25(27) °C     │      .-.      +31(35) °C     │      .-.      +29(32) °C     │      .-.      +25(27) °C     │
│      .-.      +26(28) °C     │      .-.      +31(37) °C     │      .-.      +27(29) °C     │      .-.      +25(27) °C     │

# Output to a file 
grep °C $weather_report > temperatures.txt
```

* Extract the current temperature, and store it in a shell variable called `obs_tmp`
Remember to validate your results.

You may have noticed by now that the temperature values extracted from wttr.in are surrounded by special formatting characters. These characters cause the numbers to display in specific color - for example, when you use the cat command to display your log file.

To see these "hidden" characters, you can use an editor such as Vim. When you use Vim or another editor, your records will look something like this:
* 2023 05 16 ^[[38;5;190m20^[[0m ^[[38;5;190m21^[[0m
*  For this example record, you need to strip the values 20 and 21 from the string.

```sh
# extract the current temperature
obs_tmp=$(cat -A temperatures.txt | head -1 | cut -d "+" -f2 | cut -d "m" -f5 | cut -d "^" -f1 )
echo "observed temperature = $obs_tmp"
```

* Extract tomorrow's temperature forecast for noon, and store it in a shell variable called fc_tmp

```sh
fc_temp=$(cat -A temperatures.txt | head -3 | tail -1 | cut -d "+" -f2 | cut -d "(" -f1 | cut -d "^" -f1 )
```

* Store the current hour, day, month, and year in corresponding shell variables
```sh
hour=$(TZ='Morocco/Casablanca' date -u +%H) 
day=$(TZ='Morocco/Casablanca' date -u +%d) 
month=$(TZ='Morocco/Casablanca' date +%m)
year=$(TZ='Morocco/Casablanca' date +%Y)
```

* Merge the fields into a tab-delimited record, corresponding to a single row in Table 1
```sh
# match the tab delimited header from the first output to the log file
record=$(echo -e "$year\t$month\t$day\t$obs_tmp\t$fc_temp")
echo $record>>rx_poc.log
```

<br>

### Script Scheduling
* Determine what time of day to run your script
Recall that you want to load the weather data coresponding to noon, local time, in Casablanca every day.

First, check the time difference between your system's default time zone and UTC.
```sh
theia@theia-craigtrupp8:/home/project$ date
Fri Aug  4 16:44:54 EDT 2023
theia@theia-craigtrupp8:/home/project$ date -u
Fri Aug  4 20:44:57 UTC 2023
```

* Create a cron job that runs your script
```sh
crontab -e

# Add to end of output in nano editor
0 8 * * * /home/project/rx_poc.sh
```
<br>

- File for the entire script within directory

