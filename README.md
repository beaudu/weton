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

```matlab
>> weton(2016,8)
```
returns the following table:

```
--------------------- WETONAN BULAN AGUSTUS 2016 ---------------------
Awal:  Senen Pon/Petak Gumbreg 26 Sawal 1949 Jimawal Sengara Salasiyah,  1 Agustus 2016
Akhir: Rebo Pon/Petak Sungsang 27 Dulkangidah 1949 Jimawal Sengara Salasiyah, 31 Agustus 2016
--------------------------------------------------------------------
                Senen   Selasa  Rebo    Kemis   Jemuwah Setu    Akad
   Pon/Petak      01      16      31      11      26      06      21
 Wage/Cemeng      22      02      17       -      12      27      07
 Kliwon/Asih      08      23      03      18       -      13      28
  Legi/Manis      29      09      24      04      19       -      14
Pahing/Pahit      15      30      10      25      05      20       -
```

A third use is a search mode, looking for regular expression in the full Javanese date string. For example, looking for the next "30 Rejeb" date:

```matlab
>> weton('30 rejeb')
Kemis Pahing/Pahit Mandasiya 30 Rejeb 1950 Je Sengara Salasiyah, 27 April 2017.
```

## Author
**François Beauducel**, [IPGP](www.ipgp.fr), [beaudu](https://github.com/beaudu), beauducel@ipgp.fr 

## Documentation
See help for syntax, and script comments for details.
