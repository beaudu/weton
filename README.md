# WETON: Javanese calendar

![](weton_ex600.png)

## weton.m
The current Javanese calendar was inaugurated by Sultan Agung of Mataram in the Gregorian year 1633. It is based on a combination of the Hindu calendar "Saka" and the Islamic calendar based on the lunar month, and contains different cycles: Pasaran (5-day), Dina Pitu (7-day), Wetonan (35-day), Mangsa (solar month), Wulan (Moon month), Pawukon (210-day), Tahun (Moon year), Windu (8-year), Kurup (120-year). Coincidences of these multiple cycles have special mystical meanings for any Javanese people, for instance the birthday "Weton" or the Noble Days "Dino Mulyo". This is the primary time-keeping system for all matters having cultural, historical, and metaphysical significance in the Java island, Indonesia.

This little script computes dates in the Javanese calendar, indicating Dina Pitu, Pasaran, Dino, Wulan, Tahun, Windu, and Kurup for today or a specific list of days. It indicates also the Noble Days if necessary. If you specify your date of birth, it can calculate your "weton" and a list of your javanese birthdays.

## Examples
```matlab
weton(719135)
weton('3-Dec-1968')
weton(1968,12,3)
```
all return the string "Selasa Kliwon 12 Pasa 1900 Ehé Adi Arbangiyah, 3 Desember 1968".

A second use of this function is to display a month calendar that combines the 5-day "Pasaran" cycle and the 7-day Gregorian/Islamic week, called "Wetonan".


## Author
**François Beauducel**, [IPGP](www.ipgp.fr), [beaudu](https://github.com/beaudu), beauducel@ipgp.fr 

## Documentation
See help for syntax, and script comments for details.
