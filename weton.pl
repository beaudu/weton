#!/usr/bin/env perl
# WETON Javanese calendar / Wetonan
#
#	Help: weton -h
#
#	Dependency: POSIX Perl module
#
#	Author: Mas François Beauducel
#	Created: 1999-01-27 (Rebo Pahing)
#	Updated: 2015-04-30 (Kemis Wagé)
#	Version: 1.3

#
#	Copyright (c) 1999-2015, François Beauducel, covered by BSD License.
#	All rights reserved.
#
#	Redistribution and use in source and binary forms, with or without 
#	modification, are permitted provided that the following conditions are 
#	met:
#
#	   * Redistributions of source code must retain the above copyright 
#	     notice, this list of conditions and the following disclaimer.
#	   * Redistributions in binary form must reproduce the above copyright 
#	     notice, this list of conditions and the following disclaimer in 
#	     the documentation and/or other materials provided with the distribution
#	                           
#	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
#	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
#	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
#	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
#	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
#	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
#	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
#	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
#	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
#	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
#	POSSIBILITY OF SUCH DAMAGE.


use strict;
use Time::Local;
use POSIX qw/strftime/;

# Pasaran = 5 day-names of javanese week
my @pasaran = ('Pon','Wagé','Kliwon','Legi','Pahing');

# Minggu = 7 day-names of gregorian week
my @minggu = ('Senèn','Selasa','Rebo','Kemis','Jemuwah','Setu','Akad');

# Bulan = Gregorian month names
my @bulan = ('Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember');

# for UTF-8 compatibility
if (grep(/UTF-8/,$ENV{LANG})) {
	$pasaran[1] = 'Wagé';
	$minggu[0] = 'Senèn';
}

my $date;
my $w = 0;
my $debug = 0;

if (@ARGV > 0) {
	if (grep(/^-h|^--help/,@ARGV)) {
		print	"Usage: weton [options] [DATE]\n",
			"Display the current 'Weton' day in the Javanese calendar, a combination of day\n",
			"names in the Gregorian/Islamic 7-day week ('Dinapitu') and Javanese 5-day week\n",
			"('Pasaran').\n\n",
			"Options:\n",
			"  -n#          display # next/previous Weton dates.\n",
			"  -h, --help   display this help.\n\n",
			"DATE display the Weton for a specific date, in the format YYYY-mm-dd\n",
			"and/or with any complement time delay arguments:\n",
			"  [yesterday|tomorrow][N [next|last][day|week|year][ago]].\n\n",
			"Examples:\n",
			"   weton 1968-12-03\n",
			"   weton -n10\n",
			"   weton tomorrow\n",
			"   weton 2 weeks ago\n",
			"   weton next year\n\n",
			"Understand also Indonesian and Ngoko/Krama languages! Ayo coba!\n",
			"\nA tiny utility written by Mas Francois.\n",
			"v1.3 - April 2015 - please report bugs to <beauducel\@ipgp.fr>.\n";
		exit(1);
	}
	my @narg = grep(/^-n/,@ARGV);
	if (@narg) {
		$w = substr($narg[0],2);
	}
	if (grep(/^-debug$/,@ARGV)) {
		$debug = 1;
	}

	# date arguments are all but options
	$date = join(' ',grep(!/^-/,@ARGV));
}

my $d = lc($date);

# makes some basic translations from Indonesian and Javanese (Ngokoh and Krama) 
# to English keywords
$d =~ s/besok|esok|sesuk|mbenjing/tomorrow/g;
$d =~ s/kemarin|wingi|kalawingi/yesterday/g;
$d =~ s/hari|dina|dinten/day/g;
$d =~ s/pekan|minggu|senin/week/g;
$d =~ s/tahun|warsa/year/g;
$d =~ s/yang lalu|sing kepungkur|ingkang kepengker/ago/g;
$d =~ s/lalu|kepungkur|kepengker/last/g;
$d =~ s/depan|ngarep/next/g;

# extracts the date in format "YYYY-mm-dd"
my @dd = grep(/^[0-9]+-[0-9]+-[0-9]+$/,$d);
if (@dd) {
	$date = $dd[0];
} else {
	# or takes today
	$date = strftime('%Y-%m-%d %H:%M',localtime);
}
if ($debug) {
	print "(date = $date)\n";
}
my ($year,$month,$day) = split(/-/,$date);
my $gmt = strftime('%s',0,0,0,1,0,70);
my $dtime = strftime('%s',0,0,0,$day,$month-1,$year-1900);

my $delay = 0;
my $f = 0;
my $n = 0;

# loop on each word
for (split(/\s/,$d)) {

	# extracts the number
	if ($_ =~ /^[0-9]+$/) {
		$n = $_;
		$f = 0;
	}

	if ($_ =~ /day/) {
		$f = 86400;
	}
	if ($_ =~ /week/) {
		$f = 7*86400;
	}
	if ($_ =~ /year/) {
		$f = 365.25*86400;
	}
	if ($_ =~ /tomorrow/) {
		$f = 86400;
		$n = 1;
	}
	if ($_ =~ /yesterday/) {
		$f = 86400;
		$n = -1;
	}
	if ($_ =~ /ago/) {
		$delay *= -1;
		$n = 0;
	}
	if ($_ =~ /next/) {
		$n = 1;
	}
	if ($_ =~ /last/) {
		$n = -1;
	}

	if ($debug) {
		print "$_ (f = $f, n = $n)\n";
	}

	$delay += $f*$n;
}

foreach (($w >= 0 ? (0 .. $w):($w .. 0))) {
	my $n35 = $_ * 35;
	my ($day,$month,$year,$unix) = split(/\//,strftime('%d/%m/%Y/%s',gmtime($dtime + ($n35 + 1)*86400 + $delay + $gmt)));

	# computes the number of days from year 1633 AD (offset is necessary for Linux 1970-01-01 origin date for %s)
	my $ndays = int($unix/86400 + 3500*35);

	my $p = ($ndays+1)%5;
	my $m = ($ndays+3)%7;
	
	my $mulyo = "";
	if ($m == 1 && $p == 2) {
		$mulyo = " (Hanggara Asih)";
	}
	if ($m == 4 && $p == 3) {
		$mulyo = " (Dino Purnomo)";
	}

	if ($debug) {
		print "(gmt = $gmt, dtime = $dtime, unix = $unix, ndays = $ndays, p = $p, m = $m)\n";
	}

	printf("Weton: ~ %s %s%s ~ %s %s %s\n",$minggu[$m],$pasaran[$p],$mulyo,$day,$bulan[$month-1],$year);
}
