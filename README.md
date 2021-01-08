# WETON: Javanese calendar

The current Javanese calendar was inaugurated by Sultan Agung of Mataram in the Gregorian year 1633 CE. It is based on a combination of the Hindu calendar "Saka" and the Islamic calendar based on the lunar month and year, and contains different cycles: **Pasaran** (5-day), **Dinapitu** (7-day), **Wetonan** (35-day), **Wulan** (lunar month), **Pawukon** (210-day), **Taun** (lunar year), **Windu** (8 lunar year), and **Kurup** (120 lunar year). Coincidences of these multiple cycles have special mystical meanings for any Javanese people, for instance the birthday "Weton" or the Noble Days "Dino Mulyo". This is the primary time-keeping system for all matters having cultural, historical, and metaphysical significance in the Java island, Indonesia.

The Javanese calendar has been created and starts on 8 July 1633 CE, which corresponds to "1 Sura 1555 AJ Alip Kuntara Jamingiyah", "AJ" means _Anno Javanico_. Presently, the calender is only defined until 25 August 2052 CE, the last day of the current Kurup. Any future date is speculative since the sequences of Wulan and Taun, proper to each Kurup, have not been defined yet by the Javanese Kings of Yogyakarta and Surakarta.

![](weton_ex600.jpg)

## weton.m
This script computes dates in the full Javanese calendar, indicating Dinapitu, Pasaran, Dino, Wulan, Tahun, Windu, and Kurup for today or a specific list of days. It indicates also the Noble Days if necessary. If you specify your date of birth, it can calculate your "weton" and a list of your Javanese birthdays.

```matlab
>> weton(719135)
>> weton('3-Dec-1968')
>> weton(1968,12,3)
```
all return the string "Slasa Kliwon Julungwangi 13 Pasa 1900 AJ Ehé Adi Langkir Salasiyah (Asapon),  3 Desember 1968 CE".

A second use of this function is to display a month calendar that combines the 5-day "Pasaran" cycle and the 7-day Gregorian/Islamic week, called "Wetonan".

```matlab
>> weton(2020,10)
```
returns the following table:

```
------------------------ WETONAN BULAN    OKTOBER 2020 -------------------------                    
Awal:  Kêmis Kliwon Langkir 13 Sapar 1954 AJ Jimakir Sêngara Langkir Salasiyah (Asapon),  1 Oktober 2020 CE
Akhir: Sêtu Kliwon Kuruwelut 14 Mulud 1954 AJ Jimakir Sêngara Langkir Salasiyah (Asapon), 31 Oktober 2020 CE
--------------------------------------------------------------------------------                    
                Sênèn    Slasa     Rêbo    Kêmis Jumungah     Sêtu   Ngahad                         
         Pon       19        -       14       29       09       24       04                         
        Wage       05       20        -       15       30       10       25                         
      Kliwon       26       06       21       01       16       31       11                         
        Lêgi       12       27       07       22       02       17        -                         
       Paing        -       13       28       08       23       03       18      
```

A third use is a search mode, looking for regular expression in the full Javanese date string. For example, looking for the next new year "1 Sura":

```matlab
>> weton(' 1 sura')
Slasa Pon Kulawu  1 Sura 1955 AJ Alip Sêngara Langkir Salasiyah (Asapon), 10 Agustus 2021 CE (SIJI SURA)
```
which falls logically on the weton 'Slasa Pon' since we are in the Kurup 4 named 'Asapon'.

## weton.pl
This is a little script written in Perl that computes only the "weton" for any dates in the Gregorian calendar. It uses the POSIX `strftime` function capabilities.

```
$ weton.pl -h
Usage: weton [options] [DATE]
Display the current 'Weton' day in the Javanese calendar, a combination of day
names in the Gregorian/Islamic 7-day week ('Dinapitu') and Javanese 5-day week
('Pasaran').

Options:
  -n#          display # next/previous Weton dates.
  -h, --help   display this help.

DATE display the Weton for a specific date, in the format YYYY-mm-dd
and/or with any complement time delay arguments:
  [yesterday|tomorrow][N [next|last][day|week|year][ago]].

Examples:
   weton 1968-12-03
   weton -n10
   weton tomorrow
   weton 2 weeks ago
   weton next year

Understand also Indonesian and Ngoko/Krama languages! Ayo coba!

A tiny utility written by Mas Francois.
v1.3 - April 2015 - please report bugs to <beauducel@ipgp.fr>.
```

## weton.c
This is a little script written in C that computes only the "weton" for a given date in the Gregorian calendar. It uses a specific formula adapted from Zeller's congruence.

```
$ weton
Usage: weton DAY MONTH YEAR.
$ weton 3 12 1968
~ Selasa Kliwon ~
```

## Author
**François Beauducel**, [IPGP](www.ipgp.fr), [beaudu](https://github.com/beaudu), beauducel@ipgp.fr

The script `weton.m` and the congruence formula developed in `weton.c` have been presented in the following article:
> Karjanto & Beauducel (2020), An ethnoarithmetic excursion into the Javanese calendar, https://arxiv.org/abs/2012.10064

## Documentation
See help for syntax, and script comments for details. See also [![View weton on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://fr.mathworks.com/matlabcentral/fileexchange/30844-weton) for users community comments.
