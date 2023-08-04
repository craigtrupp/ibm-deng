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