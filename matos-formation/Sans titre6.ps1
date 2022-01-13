$Date=Get-Date
[int]$UnixWeek=($Date.DayOfYear / 7) + 1
"{0}-{1:d2}" -F $Date.Year,$UnixWeek