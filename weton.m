function varargout = weton(year,month,day,n)
%WETON	Javanese calendar / Wetonan.
%	WETON without input argument returns the javanese date for today,
%	in the form:
%	   DINAPITU PASARAN WUKU DINA WULAN T TAUN WINDU LAMBANG KURUP, DAY MONTH YEAR (DINA MULYA)
%	where:
%	   DINAPITU PASARAN = combination of 7-day and 5-day cycles names, i.e.,
%	   the "Weton" (35 different),
%	   WUKU = Javanese/Balinese 7-day week name (30 different),
%	   DINA = day number in the Javanese lunar month (1 to 29 or 30),
%	   WULAN = Javanese lunar month name,
%	   T = Javanese lunar year number "Anno Javanico" (starts on 1555 AJ),
%	   TAUN = Javanese lunar year name (8 different, 12-Wulan cycle),
%	   WINDU = 8 lunar years (4 different, 8-Taun cycle),
%	   LAMBANG = 8 lunar years name (2 different, 8-Taun cycle),
%	   KURUP = 120 lunar years name (all specific, 15-Windu cycle),
%	   DINA MULYA = "noble day" name (if necessary).
%
%	The Javanese calendar has been created on 8 July 1633 CE which
%	corresponds to "1 Sura 1555 AJ Alip Kuntara Jamingiyah". An error will
%	occur for any previous date. Also, the calender is presently defined
%	until 25 August 2052 CE, the last day of the current kurup. Any future
%	date is speculative and will produce a warning.
%
%	WETON(YEAR,MONTH,DAY) returns the full javanese date corresponding to
%	YEAR-MONTH-DAY in the Gregorian/Islamic calendar.
%
%	WETON(YEAR,MONTH,DAY,N) returns the list of your N first javanese
%	birthdays (from the 35-day "Wetonan" cycle). Example: if you are born
%	on Dec 3, 1968 then
%	   weton(1968,12,3,10)
%	returns your 10 first Wetons. Thanks to the Matlab flexibility,
%	   weton(1968,12,3+35*(0:9))
%	will do the same job...
%
%	WETON(T) uses date T which can be Matlab date scalar, vector, matrix
%	or any valid string for DATENUM function. Examples:
%	   weton(719135)
%	   weton('3-Dec-1968')
%	   weton([1968,12,3])
%	all return the string
%	   'Selasa Kliwon Julungwangi 12 Pasa 1900 AJ Eh Adi Arbangiyah, 3 Desember 1968 CE'
%
%
%	-- Calendar mode --
%
%	WETON(YEAR,MONTH) returns a javanese calendar for YEAR and MONTH in a
%	table combining the 5-day "Pasaran" cycle and 7-day Gregorian week.
%	Example: weton(1994,4) returns the following:
%
%	---------------------- WETONAN BULAN     APRIL 1994 -------------------
%	Awal:  Jumungah Kliwon Sungsang 19 Sawal 1926 AJ Jé Sancaya Salasiyah (Asapon),  1 April 1994 CE
%	Akhir: Sêtu Wage Mandasiya 19 Sela 1926 AJ Jé Sancaya Salasiyah (Asapon), 30 April 1994 CE
%	-----------------------------------------------------------------------
%               Sênèn    Slasa     Rêbo    Kêmis Jumungah     Sêtu   Ngahad 
%        Pon       04       19        -       14       29       09       24                     
%       Wage       25       05       20        -       15       30       10                     
%     Kliwon       11       26       06       21       01       16        -                     
%       Lêgi        -       12       27       07       22       02       17                     
%      Paing       18        -       13       28       08       23       03     
%
%	where "Awal:" is the first day of the month, "Akhir:" the last one.
%
%	-- Search mode --
%
%	WETON(REGEXP) will search the next match REGEXP into the full Javanese
%	date string from today (limited to the next 8 years).
%
%	WETON(YEAR,REGEXP) will search the match REGEXP into the current YEAR.
%
%	WETON(T,REGEXP) searches the string match REGEXP into date vector T
%	(DATENUM format).
%
%
%	W = WETON(...) returns a structure W with corresponding fields instead
%	of displaying strings. To see the field names, try
%	   disp(weton)
%
%	Examples:
%	   W = weton(2016,1,1:35);
%	   datestr(cat(1,W.date))	% use Matlab datenum
%	   cat(1,char(W.weton))		% display full date strings
%	   weton('30 rejeb')		% looks for the next "30 Rejeb"
%
%
%	Author: Mas François Beauducel, alias Pak Mancung
%
%	References:
%	   https://id.wikipedia.org/wiki/Kalender_Jawa
%	   https://www.sastra.org
%
%	Created: 1999-01-27 (Rêbo Paing), in Paris (France)
%	Updated: 2020-10-20 (Slasa Wage)

%	Copyright (c) 2020, François Beauducel, covered by BSD License.
%	All rights reserved.
%
%	Redistribution and use in source and binary forms, with or without
%	modification, are permitted provided that the following conditions are
%	met:
%
%	   * Redistributions of source code must retain the above copyright
%	     notice, this list of conditions and the following disclaimer.
%	   * Redistributions in binary form must reproduce the above copyright
%	     notice, this list of conditions and the following disclaimer in
%	     the documentation and/or other materials provided with the distribution
%
%	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
%	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%	POSSIBILITY OF SUCH DAMAGE.

% origin date = 1 Sura 1555 AJ Alip Kuntara Jamingiyah = 8 July 1633 CE
AJ = 1555;
t0 = datenum(1633,7,8);

% last date defined in the calendar = 25 August 2052 (current kurup)
% NOTE: if the Kings of Yogyakarta and Surakarta might have the
% thoughtfulness in defining the Taun "Dal" sequence of Wulan for the next
% Kurup, tl date might be updated, also the kurup table below, and wtd and
% hw sequences (only if it differs from the Kurup 4).
tl = datenum(2052,8,25); 

% Pasaran = 5 day-names of javanese pasaran
pasaran = {'Pon','Wage','Kliwon','Lêgi','Paing'};

% Minggu = 7 day-names of gregorian week
minggu = {'Sênèn','Slasa','Rêbo','Kêmis','Jumungah','Sêtu','Ngahad'};

% Wuku = 30 week names in the Javanese/Balinese calendar
wuku = {'Sinta','Landep','Wukir','Kurantil','Tolu','Gumbreg', ...
	'Warigalit','Warigagung','Julungwangi','Sungsang','Galungan','Kuningan', ...
	'Langkir','Mandasiya','Julungpujut','Pahang','Kuruwelut','Marakeh', ...
	'Tambir','Medangkungan','Maktal','Wuye','Manahil','Prangbakat', ...
	'Bala','Wugu','Wayang','Kulawu','Dukut','Watugunung'};

% Bulan = Gregorian month names
bulan = {'Januari','Februari','Maret','April','Mei','Juni', ...
	'Juli','Agustus','September','Oktober','November','Desember'};

% Wulan = Javanese month names (1/12 of Moon year)
wulan = {'Sura','Sapar','Mulud','Bakdamulud','Jumadilawal','Jumadilakhir', ...
	'Rêjêb','Ruwah','Pasa','Sawal','Sela','Bêsar'};

% Taun = Moon year, alternate 354 and 355-day length (depending on taun and kurup)
taun = {'Alip','Ehé','Jimawal','Jé','Dal','Bé','Wawu','Jimakir'};

% Windu and Lambang = 8-taun cycle = 81-wetonan = 2835-day
windu = {'Adi','Kuntara','Sêngara','Sancaya'};
lambang = {'Kulawu','Langkir'};

% Kurup = 120-taun cycle (-1 day), if normal
% [name,shortname,first Taun AJ, Taun offset
kurup = { ...
	'Jamingiyah','A''ahgi', 1555, 0; % first Kurup (120 taun)
	'Kamsiyah',  'Amiswon', 1675, 0; % second Kurup (74 taun)
	'Arbangiyah','Aboge',   1749, 2; % third Kurup (118 taun)
	'Salasiyah', 'Asapon',  1867, 0; % fourth Kurup (120 taun)
%	'Isneniyah', 'Anenhing',1987, 0; % fifth Kurup (120 taun)
%	'Akadiyah', 'Akadgi',   2107, 0; % sixth Kurup (120 taun)
%	'Sabtiyah', 'Atuwon',   2227, 0; % seventh Kurup (120 taun)
	};
kft = cat(1,kurup{:,3}); % vector of Kurup 1st taun

if nargin > 4
	error('Too many input arguments.');
end

if nargin == 2
	% if year is a 4-digit value, supposes it is not a datenum date
	if year < 10000 && ischar(month)
		year = datenum(year,1,1:366);
	end
end

if nargin > 2 && ~isnumeric(day)
	error('DAY argument must be numeric.')
end

if nargin == 4 && (~isnumeric(n) ||  numel(n) > 1)
	error('N argument must be scalar.')
end

search = '';

switch nargin
case 1
	try
		dt = datenum(year);
	catch
		if ischar(year)
			dt = now + (1:366*8);	% will search from today to 8 years ahead
			search = year;
		else
			error('T is not a valid date (DATENUM).')
		end
	end
case 2
	if ischar(month)
		search = month;
		dt = datenum(year);
	else
		% calculates the number of days in month using DATEVEC
		ct = datevec(datenum(year,month,1:31));
		year = ct(1,1);
		month = ct(1,2);
		day = max(ct(:,3));
		dt = datenum(year,month,1:day);
	end
case 3
	dt = datenum(year,month,day);
case 4
	dt = datenum(year,month,day) + 35*(0:n)';
otherwise
	dt = now;
end
dt = floor(dt);

if any(dt < t0)
	error('Some dates are unvalid (before %s)',datestr(t0));
end
if any(dt > tl)
	warning('Some dates are speculative (after %s)',datestr(tl));
end

% approximates the maximum kurup
nkrp = ceil(max(dt(:)-t0)/(15*81*7*5 - 1)) + 1;


% --- makes the windu/taun table
WT = zeros(12,120*nkrp);

% for each Windu, determine a vector of number of days
w354 = 29+[1,0,1,0,1,0,1,0,1,0,1,0]';	% Tahun 1,3,4/5,6,7
w355 = 29+[1,0,1,0,1,0,1,0,1,0,1,1]';	% Tahun 2,4/5,8
wtd1 = 29+[1,0,1,0,1,0,1,0,1,0,1,1]';	% Tahun 5 (Dal) Kurup 1
wtd2 = 29+[1,1,0,0,1,0,1,0,1,0,1,1]';	% Tahun 5 (Dal) Kurup 2
wtd3 = 29+[1,1,0,0,0,0,1,0,1,0,1,1]';	% Tahun 5 (Dal) Kurup 3
wtd4 = 29+[1,0,1,0,1,0,1,0,1,0,1,0]';	% Tahun 5 (Dal) Kurup>3

for k = 1:nkrp
	% Windu matrix (size 12x8) of Wulan x Tahun, depending on the Kurup
	switch k
		case 1
			hw = [w354,w355,w354,w354,wtd1,w354,w354,w355];
		case 2
			hw = [w354,w355,w354,w354,wtd2,w354,w354,w355];
		case 3
			hw = [w354,w355,w354,w355,wtd3,w354,w354,w355];
		otherwise
			hw = [w354,w355,w354,w355,wtd4,w354,w354,w355];
	end
	krp = repmat(hw,1,15); % full Kurup matrix of 15 Windu
	if k < size(kurup,1)
		itn = kurup{k,3}:kurup{k+1,3}-1; % index of Taun
		dtn =  kurup{k,4};
	else
		itn = kurup{end,3} + 120*(k-size(kurup,1)) + (0:119);
		dtn = 0;
	end
	
	% removes 1 day at the end of the Kurup
	kend = itn(end) - itn(1) + 1;
	krp(end,kend) = krp(end,kend) - 1;
	
	% fills the tw matrix
	WT(:,itn - AJ + 1) = krp(:,itn - itn(1) + dtn + 1);
	
end
% computes the cumulative number of days
WT = reshape(cumsum(WT(:)),size(WT));


% --- computes the Javanese date for all dt
for i = 1:numel(dt)
	X(i) = javcal(dt(i));
end
s = cat(1,{X.weton});

if ~isempty(search)
	X = X(~cellfun(@isempty,regexp(s,search,'ignorecase')));
	if isempty(X)
		s = 'no match.';
	else
		% looks only for the first match
		if nargin == 1
			X = X(1);
			s = X(1).weton;
		else
			s = cat(1,{X.weton});
		end
	end
end

if nargin == 2 && isempty(search)
	s = cell(10,1);

	kal = cell(5,7);
	kal(:) = {' -'};
	for i = 1:day
		kal{mod(dt(i)+2,5)+1,mod(dt(i)+4,7)+1} = sprintf('%02d',i);
	end
	s{1} = sprintf('------------------------ WETONAN BULAN %10s %d -------------------------', ...
	   upper(X(1).month),X(1).year);
	s{2} = sprintf('Awal:  %s',X(1).weton);
	s{3} = sprintf('Akhir: %s',X(end).weton);
	s{4} = sprintf('%s',repmat('-',80,1));
	s{5} = sprintf('%15s',' ');
	for i = 1:length(minggu)
		s{5} = [s{5},sprintf('%-9s',minggu{i})];
	end
	for i = 1:length(pasaran)
		s{5+i} = [sprintf('%12s',pasaran{i}),sprintf('%9s',kal{i,:})];
	end
end


if nargout == 0
	disp(char(s));
else
	varargout{1} = X;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X=javcal(dt)
% computes the full Javanese calendar from CE date DT

	% relative day number from origin
	dti = dt - t0 + 1;
	% finds the Wulan and Tahun into the table of Windu
	kk = find(WT(:) >= dti,1);
	[wulan_index,taun_aj] = ind2sub(size(WT),kk);
	% computes the day number
	if kk > 1
		dina = dti - WT(kk-1);
	else
		dina = dti;
	end
	% t: taun number
	t = taun_aj + AJ - 1;
	taun_index = mod(taun_aj - 1,8) + 1;
	pasaran_index = mod(dt + 2,5) + 1;
	minggu_index = mod(dt + 4,7) + 1;
	wuku_index = mod(floor((dt - 2)/7) + 25,30) + 1;
	windu_index = mod(floor(dti/(81*7*5)) + 1,4) + 1;
	lambang_index = mod(floor(dti/(81*7*5)),2) + 1;
	if t < (kft(end) + 120)
		kurup_index = find(t>=kft,1,'last');
	else
		kurup_index = floor((t - kft(end))/120) + size(kurup,1);
	end
	ct = datevec(dt);
	X.pasaran = pasaran{pasaran_index};
	X.dinapitu = minggu{minggu_index};
	X.wuku = wuku{wuku_index};
	X.date = dt;
	X.dina = dina;
	X.wulan = wulan{wulan_index};
	X.aj = t;
	X.taun = taun{taun_index};
	X.windu = windu{windu_index};
	X.lambang = lambang{lambang_index};
	if kurup_index <= size(kurup,1)
		X.kurup = kurup{kurup_index,1};
		X.kurup_short = kurup{kurup_index,2};
	else
		X.kurup = sprintf('Kurup %d',kurup_index);
		X.kurup_short = '';
	end
	X.day = ct(3);
	X.month = bulan{ct(2)};
	X.year = ct(1);

	% "Dina Mulya": noble days
	mulya = '';
	if dina == 1 && wulan_index == 1
		mulya = 'Siji Sura';	% 1 Sura (new year)
	end
	if taun_index == 1 && wulan_index == 3 && pasaran_index == 2
		mulya = 'Aboge';	% Alip Rebo Wage
	end
	if taun_index == 5 && minggu_index == 6 && pasaran_index == 4
		mulya = 'Daltugi';	% Dal Setu Legi
	end
	if wuku_index == 12 && minggu_index == 6 && pasaran_index == 3
		mulya = 'Kuningan';	% Setu Kliwon Kuningan
	end
	if wuku_index == 29 && minggu_index == 2 && pasaran_index == 3
		mulya = 'Hanggara Asih';	% Selasa Kliwon Dukut
	end
	if wuku_index == 30 && minggu_index == 5 && pasaran_index == 3
		mulya = 'Dina Mulya';	% Jemuwah Kliwon Watugunung
	end
	if minggu_index == 5 && pasaran_index == 4
		mulya = 'Dina Purnama'; % Jemuwah Legi
	end
	X.mulyo = mulya;

	ss = sprintf('%s %s %s %2d %1s %4d AJ %s %s %s %s (%s), %2d %s %4d CE', ...
	   X.dinapitu,X.pasaran,X.wuku, X.dina, X.wulan, X.aj, X.taun, ...
	   X.windu, X.lambang, X.kurup, X.kurup_short, X.day, X.month, X.year);
	if ~isempty(mulya)
		ss = sprintf('%s (%s)',ss,upper(mulya));
	end
	X.weton = ss;
end
end
