#!/usr/bin/perl
#with new sensors from mid-July numbers 30-48 plus 5 pressure sensors.#creates csv files from .txt data obtained using Cygwin  -your files must have the .txt extension.
#temp sensors have only a single relevant byte pair while flow/light have two pairs
#also grabs voltage from the battery monitor onboard the mote power board. This can be used to compensate for a battery that's low. 
#Usually the voltage is near enough 5v that our lab calibrations (done at 5v) should be valid.
#but, if you see the battery monitor voltage dropping to 3 or 4 volts, you need to adjust the sensor readings proportionately.

#This file works directly on the data we collect from Cygwin but NOT on Logomatic Datalogger data because of end-of-line character

#Type in the name of your data folder here. Folders should be put in same directory as this program.
$indir = "ProcessMe"; #once you set this folder and save this file you just type perl ConvertSalamanderDataToExcel.pl and your target folder should fill with .csv files readable in Excel

     
$id1 = "20 F3 C3 0A 00 00 00 B3 "; #turbidity sensor 
$id2 = "20 60 CC 09 00 00 00 BC "; #pressure sensor 
$id3 = "20 7A C6 0A 00 00 00 1D "; #turbidity sensor 
$id4 = "28 D1 8E 37 01 00 00 E1 "; #temperatute sensor 
$id5 = "20 86 CD 09 00 00 00 EA "; # pressure (30 psi) Messes Up Others
$id6 = "28 3B 8F 37 01 00 00 CA "; # temperature Messes Up Others
$id7 = "20 01 D4 09 00 00 00 0A "; # pressure 
$id8 = "28 81 94 37 01 00 00 0E "; # temperature 
$id9 = "20 A9 CD 09 00 00 00 78 "; # pressure/turbidity
$id10 = "28 59 90 37 01 00 00 74 "; # temperature
$id11 = "20 CC D1 09 00 00 00 0D "; # pressure/turbidity
$id12 = "28 BC 46 37 01 00 00 74 "; # temperature  
$id13 = "20 39 D3 09 00 00 00 17 "; # pressure 
$id14 = "28 C0 40 37 01 00 00 0D "; # temperature 
$id15 = "20 CC CA 09 00 00 00 01 "; # turbidity 
$id16 = "20 16 C4 0A 00 00 00 20 "; # turbidity
$id17 = "20 E4 D3 09 00 00 00 99 "; # pressure
$id18 = "20 56 D2 09 00 00 00 3D "; # turbidity 
$id19 = "28 86 E2 36 01 00 00 F5 "; # temperature
$id20 = "26 07 EE AD 00 00 00 A8 "; # battery monitor
$id21 = "26 76 E7 AD 00 00 00 F4 "; # battery monitor 
$id22 = "26 37 BC A9 00 00 00 5D "; # battery monitor 
$id23 = "20 1F CD 09 00 00 00 CD "; # flow 

$id24 = "20 34 D3 09 00 00 00 5D "; # flow 
$id25 = "20 B1 CB 09 00 00 00 1E "; # flow 
$id26 = "20 ED 5C 0A 00 00 00 10 "; # turbidity
$id27 = "20 56 C4 0A 00 00 00 55 "; # turbidity
$id28 = "20 8E CC 0A 00 00 00 0E "; # turbidity
$id29 = "20 B7 CD 0A 00 00 00 B8 "; # turbidity
$id30 = "20 B8 CC 09 00 00 00 14 "; # turbidity
$id31 = "20 89 B7 0A 00 00 00 96 "; # turbidity
$id32 = "20 66 D2 09 00 00 00 D0 "; # turbidity
$id33 = "20 5D CC 09 00 00 00 1B "; # pressure
$id34 = "28 CC A9 36 01 00 00 D6 "; # temperature
$id35 = "20 2A D4 09 00 00 00 44 "; #flow July 1 2008 Flume Tests
$id36 = "20 3D CF 09 00 00 00 96 "; #flow July 11 2008
$id37 = "20 C3 CF 09 00 00 00 F7 "; #flow July 11 2008
$id38 = "20 58 CF 09 00 00 00 BE "; #flow July 11 2008
$id39 = "20 6C CA 09 00 00 00 5D "; #flow July 11 2008
$id40 = "20 B5 D1 09 00 00 00 03 "; #flow July 11 2008
$id41 = "20 5B D6 09 00 00 00 68 "; #flow July 11 2008
$id42 = "20 9F D1 09 00 00 00 7A "; #flow July 11 2008
$id43 = "20 48 CD 09 00 00 00 66 "; #flow July 11 2008
$id44 = "20 71 CA 09 00 00 00 4C "; #flow July 11 2008
$id45 = "20 12 D4 09 00 00 00 08 "; #flow July 11 2008
$id46 = "20 37 CF 09 00 00 00 59 "; #flow July 11 2008
$id47 = "20 45 CD 09 00 00 00 2C "; #flow July 11 2008
$id48 = "20 A5 CD 09 00 00 00 05 "; #flow July 11 2008
$id49 = "20 C4 CF 09 00 00 00 72 "; #flow July 11 2008
$id50 = "20 86 D3 09 00 00 00 34 "; #flow July 11 2008
$id51 = "20 C9 D5 09 00 00 00 F9 "; #flow July 11 2008
$id52 = "20 60 D6 09 00 00 00 7D "; #flow July 11 2008
$id53 = "20 A6 CD 09 00 00 00 5C "; #flow July 11 2008
$id54 = "20 3C CF 09 00 00 00 A1 "; #flow July 11 2008
$id55 = "20 CA D5 09 00 00 00 A0 "; #flow July 11 2008
$id56 = "20 8B D7 09 00 00 00 61 "; #flow July 11 2008
$id57 = "20 D0 CA 09 00 00 00 27 "; #turbidity resurrected May 2009

$id58 = "20 74 B7 00 00 00 00 B5 "; #first turbidity sensor made

$id59 = "28 37 01 37 01 00 00 DE "; #temp (w/flow 206CCA090000005D)

$id60 = "28 EA 37 37 01 00 00 48 "; #temp (w/flow 2060D6090000007D)

$id61 = "28 0A 79 37 01 00 00 2A "; #temp (w/flow 2071CA090000004C)

$id62 = "28 63 F8 36 01 00 00 F6 "; #temp (w/flow 20CAD509000000A0)

$id63 = "28 B2 C0 36 01 00 00 BF "; #temp (w/flow 20A6CD090000005C)

$id64 = "28 04 E1 36 01 00 00 3F "; #temp (w/flow 2086D30900000034)

$id65 = "20 AF B8 0A 00 00 00 FD "; #turbidity resurr May 2009

$id66 = "20 BE C5 0A 00 00 00 10 "; #turbidity resurr May 2009

$id67 = "28 21 C8 36 01 00 00 69 "; #temp (w/flow 2045CD090000002C)

$id68 = "28 7B DE 36 01 00 00 68 "; #temp (w/flow 209FD1090000007A)

$id69 = "28 36 03 37 01 00 00 6A "; #temp (w/flow 2048CD0900000066)
$id70 = "28 96 31 37 01 00 00 31 "; #temp
$id71 = "28 87 9A 36 01 00 00 91 "; #temp

$id72 = "28 42 6F 37 01 00 00 1E "; #temp

$id73 = "20 B1 D0 09 00 00 00 12 "; #triplesensor flow and photo: This and the next 11 were on Robert's sticks 4 and 7, may 2010
$id74 = "10 72 6A E8 01 08 00 29 "; #triplesensor temp
$id75 = "20 D3 C9 09 00 00 00 30 "; #triplesensor flow and photo
$id76 = "10 C0 8A E8 01 08 00 9A "; #triplesensor temp
$id77 = "20 96 CC 09 00 00 00 7C "; #triplesensor flow and photo

$id78 = "10 2B 87 E8 01 08 00 A7 "; #triplesensor temp

$id79 = "20 A2 CC 09 00 00 00 4D "; #triplesensor flow and photo

$id80 = "10 B1 8D E8 01 08 00 64 "; #triplesensor temp

$id81 = "20 7A D9 09 00 00 00 86 "; #triplesensor flow and photo

$id82 = "10 2C 82 E8 01 08 00 F0 "; #triplesensor temp

$id83 = "20 D2 C9 09 00 00 00 07 "; #triplesensor flow and photo

$id84 = "10 A3 7E E8 01 08 00 B9 "; #triplesensor temp

$id85 = "20 CA C9 09 00 00 00 FD "; #triplesensor flow and photo  #this is 1 in Ben/Cory's list, June 2010

$id86 = "10 1D 86 E8 01 08 00 35 "; #triplesensor 1 temp

$id87 = "20 8C CC 09 00 00 00 E8 "; #triplesensor 2 flow and photo     
$id88 = "10 C4 85 E8 01 08 00 29 "; #triplesensor 2 temp

$id89 = "20 88 CD 09 00 00 00 F9 "; #triplesensor 3 flow and photo     
$id90 = "10 AE 86 E8 01 08 00 6B "; #triplesensor 3 temp

$id91 = "20 95 CC 09 00 00 00 25 "; #triplesensor 4 flow and photo     
$id92 = "10 19 6E E8 01 08 00 0D "; #triplesensor 4 temp

$id93 = "20 AC D7 09 00 00 00 52 "; #triplesensor 5 flow and photo -now retired     
$id94 = "10 CA 8B E8 01 08 00 98 "; #triplesensor 5 temp -now retired

$id95 = "20 C5 C9 09 00 00 00 D9 "; #triplesensor 6 flow and photo -now retired     
$id96 = "10 F3 6F E8 01 08 00 26 "; #triplesensor 6 temp -now retired

$id97 = "20 6D D7 09 00 00 00 FA "; #triplesensor 7 flow and photo     
$id98 = "10 6C 54 E8 01 08 00 47 "; #triplesensor 7 temp

$id99 = "20 D9 C9 09 00 00 00 FF "; #triplesensor 8 flow and photo     
$id100 = "10 BE 85 E8 01 08 00 7E "; #triplesensor 8 temp

$id101 = "20 B5 D0 09 00 00 00 CE "; #triplesensor 9 flow and photo     
$id102 = "10 EE 70 E8 01 08 00 24 "; #triplesensor 9 temp

$id103 = "20 9A D6 09 00 00 00 C0 "; #triplesensor 10 flow and photo     
$id104 = "10 00 87 E8 01 08 00 E9 "; #triplesensor 10 temp

$id105 = "20 CC C9 09 00 00 00 4F "; #triplesensor 11 flow and photo     
$id106 = "10 6B 68 E8 01 08 00 67 "; #triplesensor 11 temp --revised July 19, 2010

$id107 = "20 99 CD 09 00 00 00 95 "; #triplesensor 12 flow and photo     
$id108 = "10 ED 77 E8 01 08 00 2C "; #triplesensor 12 temp

$id109 = "20 F5 CC 09 00 00 00 E6 "; #triplesensor 13 flow and photo     
$id110 = "10 94 85 E8 01 08 00 07 "; #triplesensor 13 temp

$id111 = "20 AF D0 09 00 00 00 5A "; #triplesensor 14 flow and photo     
$id112 = "10 02 8D E8 01 08 00 3A "; #triplesensor 14 temp

$id113 = "20 09 CB 09 00 00 00 B8 "; #triplesensor 15 flow and photo     
$id114 = "10 81 78 E8 01 08 00 FD "; #triplesensor 15 temp

$id115 = "20 92 CD 09 00 00 00 6D "; #triplesensor 16 flow and photo     
$id116 = "10 EE 87 E8 01 08 00 D3 "; #triplesensor 16 temp

$id117 = "20 F4 CC 09 00 00 00 D1 "; #triplesensor 17 flow and photo     
$id118 = "10 EE 55 E8 01 08 00 0E "; #triplesensor 17 temp

$id119 = "20 D8 C9 09 00 00 00 C8 "; #triplesensor 18 flow and photo     
$id120 = "10 39 83 E8 01 08 00 8D "; #triplesensor 18 temp

$id121 = "20 72 D7 09 00 00 00 85 "; #triplesensor 19 flow and photo     
$id122 = "10 84 8B E8 01 08 00 FE "; #triplesensor 19 temp

$id123 = "20 81 D0 09 00 00 00 FF "; #triplesensor 20 flow and photo     
$id124 = "10 66 69 E8 01 08 00 E0 "; #triplesensor 20 temp

$id125 = "20 18 CC 09 00 00 00 85 "; #triplesensor 21 flow and photo     
$id126 = "10 CF 6D E8 01 08 00 35 "; #triplesensor 21 temp

$id127 = "20 93 D7 09 00 00 00 9B "; #triplesensor 22 flow and photo     
$id128 = "10 7E 41 E8 01 08 00 DC "; #triplesensor 22 temp

$id129 = "20 71 D7 09 00 00 00 DC "; #triplesensor 23 flow and photo

$id130 = "10 17 3F E8 01 08 00 46 "; #triplesensor 23 temp

$id131 = "20 96 D7 09 00 00 00 70 "; #triplesensor 24 flow and photo     
$id132 = "10 99 68 E8 01 08 00 78 "; #triplesensor 24 temp

$id133 = "20 6B D7 09 00 00 00 48 "; #triplesensor 25 flow and photo     
$id134 = "10 D3 87 E8 01 08 00 74 "; #triplesensor 25 temp

$id135 = "20 8E CD 09 00 00 00 4B "; #triplesensor 26 flow and photo

$id136 = "10 A1 6A E8 01 08 00 B4 "; #triplesensor 26 temp

$id137 = "20 54 D6 09 00 00 00 4C "; #triplesensor 27 flow and photo     
$id138 = "10 3D 3E E8 01 08 00 F2 "; #triplesensor 27 temp

$id139 = "20 F8 CC 09 00 00 00 AC "; #triplesensor 28 flow and photo

$id140 = "10 A9 64 E8 01 08 00 B7 "; #triplesensor 28 temp

$id141 = "20 A2 CD 09 00 00 00 80 "; #triplesensor 29 flow and photo     
$id142 = "10 AA E5 E0 01 08 00 F4 "; #triplesensor 29 temp

$id143 = "20 76 D4 0B 00 00 00 10 "; #triplesensor 30 flow and photo     
$id144 = "10 A4 73 E8 01 08 00 D0 "; #triplesensor 30 temp

$id145 = "20 8B DA 0B 00 00 00 8A "; #triplesensor 31 flow and photo     
$id146 = "10 C2 B4 E8 01 08 00 D2 "; #triplesensor 31 temp

$id147 = "20 AD D6 0B 00 00 00 AF "; #triplesensor 32 flow and photo     
$id148 = "10 96 BA E8 01 08 00 82 "; #triplesensor 32 temp

$id149 = "20 86 E4 0B 00 00 00 E6 "; #triplesensor 33 flow and photo     
$id150 = "10 AA 68 E8 01 08 00 CF "; #triplesensor 33 temp

$id151 = "20 29 D1 0B 00 00 00 C8 "; #triplesensor 34 flow and photo     
$id152 = "10 56 BC E8 01 08 00 81 "; #triplesensor 34 temp

$id153 = "20 AB DB 0B 00 00 00 F1 "; #triplesensor 35 flow and photo     
$id154 = "10 8B D2 E8 01 08 00 BC "; #triplesensor 35 temp

$id155 = "20 69 D6 0B 00 00 00 EC "; #triplesensor 36 flow and photo     
$id156 = "10 1F BC E8 01 08 00 62 "; #triplesensor 36 temp

$id157 = "20 38 CF 09 00 00 00 7D "; #triplesensor 37 flow and photo     
$id158 = "10 9B 78 E8 01 08 00 69 "; #triplesensor 37 temp

$id159 = "20 D7 E2 0B 00 00 00 63 "; #triplesensor 38 flow and photo     
$id160 = "10 33 68 E8 01 08 00 E8 "; #triplesensor 38 temp

$id161 = "20 44 C7 0B 00 00 00 A1 "; #triplesensor 39 flow and photo     
$id162 = "10 D8 D4 E8 01 08 00 57 "; #triplesensor 39 temp

$id163 = "20 BB DA 0B 00 00 00 67 "; #triplesensor 40 flow and photo     
$id164 = "10 28 D1 E8 01 08 00 F7 "; #triplesensor 40 temp

$id165 = "20 09 C5 0B 00 00 00 1D "; #triplesensor 41 flow and photo     
$id166 = "10 FD 9F E8 01 08 00 93 "; #triplesensor 41 temp

$id167 = "20 8E DB 0B 00 00 00 AC "; #triplesensor 42 flow and photo     
$id168 = "10 D0 AA E8 01 08 00 39 "; #triplesensor 42 temp

$id169 = "20 39 CA 09 00 00 00 98 "; #triplesensor 43 flow and photo

$id170 = "10 97 7D E8 01 08 00 C6 "; #triplesensor 43 temp

$id171 = "20 76 D9 09 00 00 00 FB "; #triplesensor 44 flow and photo     
$id172 = "10 22 85 E8 01 08 00 B2 "; #triplesensor 44 temp

$id173 = "20 B3 D7 09 00 00 00 2D "; #triplesensor 45 flow and photo     
$id174 = "10 B8 71 E8 01 08 00 75 "; #triplesensor 45 temp

$id175 = "20 CD DF 0B 00 00 00 9F "; #triplesensor 46 flow and photo

$id176 = "10 28 9D E8 01 08 00 3F "; #triplesensor 46 temp

$id177 = "20 A5 C5 0B 00 00 00 3C "; #triplesensor 47 flow and photo     
$id178 = "10 9B CB E8 01 08 00 68 "; #triplesensor 47 temp

$id179 = "20 A0 CD 09 00 00 00 EE "; #triplesensor 48 flow and photo

$id180 = "10 DE 6B E8 01 08 00 C5 "; #triplesensor 48 temp

$id181 = "20 52 C5 0B 00 00 00 CB "; #triplesensor P1-49 PRESSURE

$id182 = "10 A2 CF E8 01 08 00 0C "; #triplesensor P1-49 temp

$id183 = "20 C0 DE 0B 00 00 00 18 "; #triplesensor P2-50 PRESSURE

$id184 = "10 C3 BD E8 01 08 00 16 "; #triplesensor P2-50 temp

$id185 = "20 09 DF 0B 00 00 00 DC "; #triplesensor P3-51 PRESSURE

$id186 = "10 33 D6 E8 01 08 00 05 "; #triplesensor P3-51 temp

$id187 = "20 03 D0 0B 00 00 00 7C "; #triplesensor P4-52 PRESSURE

$id188 = "10 F6 C7 E8 01 08 00 C0 "; #triplesensor P4-52 temp

$id189 = "20 4F D9 0B 00 00 00 87 "; #triplesensor P5-53 PRESSURE

$id190 = "10 A2 AA E8 01 08 00 CF "; #triplesensor P5-53 temp

$id191 = "20 01 E4 0B 00 00 00 89 "; #triplesensor P6-54 PRESSURE standpipe

$id192 = "10 9C C9 E8 01 08 00 6E "; #triplesensor P6-54 temp

$id193 = "26 F1 C9 AD 00 00 00 C1 "; # Battery monitor on board 4 during June 2010 turb/flow tests

$id194 = "26 0F E9 AD 00 00 00 58 "; # Battery monitor on board 7 during June 2010 turb/flow tests

$id195 = "26 50 DA AD 00 00 00 98 "; # Battery monitor on board 6

$id196 = "26 07 EE AD 00 00 00 A8 "; # Battery monitor on board 16 (10 hex)

$id197 = "26 77 AF AD 00 00 00 14 "; # Battery monitor on board 28 (1C hex)

$id198 = "26 3D C6 AD 00 00 00 4C "; # Battery monitor on board 27 (1B hex)

$id199 = "26 27 CB AD 00 00 00 34 "; # Battery monitor on board 17 (11 hex)

$id200 = "26 34 CC AD 00 00 00 67 "; # Battery monitor on board 2

$id201 = "26 D2 CA AD 00 00 00 60 "; # Battery monitor on board 3

$id202 = "26 76 E7 AD 00 00 00 F4 "; # Battery monitor on board 1
#need board 1, board 3, other board 7 from UK.

$outdir = $indir; # use same directory for output
while (defined($currentfile=glob($indir."\/*.txt"))){
print ("now processing $currentfile");
open INFILE1, "<$currentfile" or die "Can't open input file, crumbs";
$outputfile=$currentfile.".csv";
open OUTFILE1, ">$outputfile" or die "can't create output file";
select OUTFILE1; #print here
while (defined($string=<INFILE1>)) {
  $part0=substr($string, 36, 2); #get family code
  $stick=substr($string, 30, 2); #get sensor stick number
  $CRC=substr($string,57,2); #get the CRC number
    
  $ID = substr($string, 36, 24);
  if ($ID eq $id1)  {$key=1;
			   $SensorType[$key]= " Turbidity sensor ";}
  if ($ID eq $id2)  {$key=2;
			   $SensorType[$key]=" Pressure sensor "; }
  if ($ID eq $id3)  {$key=3;
			   $SensorType[$key]=" Turbidity sensor "; }
  if ($ID eq $id4)  {$key=4;
                     $SensorType[$key]=" Temperature sensor ";}
  if ($ID eq $id5)  {$key=5;
			   $SensorType[$key]=" Pressure sensor ";}
  if ($ID eq $id6)  {$key=6;
 			   $SensorType[$key]=" Temperature sensor ";}
  if ($ID eq $id7)  {$key=7;
			   $SensorType[$key]=" Pressure sensor ";}
  if ($ID eq $id8)  {$key=8;
			   $SensorType[$key]= " Temperature sensor ";}
  if ($ID eq $id9)  {$key=9;
	               $SensorType[$key]=" Turbidity sensor ";}
  if ($ID eq $id10) {$key=10;
			   $SensorType[$key]=" Temperature sensor "; }
  if ($ID eq $id11) {$key=11;
			   $SensorType[$key]=" Turbidity sensor ";} #could be pressure sensor...check
  if ($ID eq $id12) {$key=12;
			   $SensorType[$key]=" Temperature sensor ";}
  if ($ID eq $id13) {$key=13;
			   $SensorType[$key]=" Pressure sensor ";}
  if ($ID eq $id14) {$key=14;
			   $SensorType[$key]=" Temperature sensor ";}
  if ($ID eq $id15) {$key=15;
			   $SensorType[$key]=" Turbidity sensor ";}
  if ($ID eq $id16) {$key=16;
			   $SensorType[$key]=" Turbidity sensor ";}
  if ($ID eq $id17) {$key=17;
			   $SensorType[$key]=" Pressure sensor ";}
  if ($ID eq $id18) {$key=18;
			   $SensorType[$key]=" Turbidity sensor ";}
  if ($ID eq $id19) {$key=19;
			   $SensorType[$key]=" Temperature sensor ";}
  if ($ID eq $id20) {$key=20;
			   $SensorType[$key]=" Battery monitor ";}
  if ($ID eq $id21) {$key=21;
			   $SensorType[$key]=" Battery monitor ";}
  if ($ID eq $id22) {$key=22;
                     $SensorType[$key]=" Battery monitor ";}
  if ($ID eq $id23) {$key=23;
			   $SensorType[$key]=" Flow Sensor ";}					
  if ($ID eq $id24) {$key=24;
			   $SensorType[$key]=" Flow Sensor ";}					
  if ($ID eq $id25) {$key=25;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id26) {$key=26;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id27) {$key=27;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id28) {$key=28;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id29) {$key=29;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id30) {$key=30;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id31) {$key=31;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id32) {$key=32;
			   $SensorType[$key]=" Turbidity Sensor ";}
  if ($ID eq $id33) {$key=33;
			   $SensorType[$key]=" Pressure Sensor ";}
  if ($ID eq $id34) {$key=34;
			   $SensorType[$key]=" Temperature Sensor ";}
  if ($ID eq $id35) {$key=35;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id36) {$key=36;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id37) {$key=37;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id38) {$key=38;
 			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id39) {$key=39;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id40) {$key=40;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id41) {$key=41;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id42) {$key=42;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id43) {$key=43;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id44) {$key=44;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id45) {$key=45;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id46) {$key=46;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id47) {$key=47;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id48) {$key=48;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id49) {$key=49;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id50) {$key=50;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id51) {$key=51;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id52) {$key=52;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id53) {$key=53;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id54) {$key=54;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id55) {$key=55;
			   $SensorType[$key]=" Flow Sensor ";}
  if ($ID eq $id56) {$key=56;
			   $SensorType[$key]=" Flow Sensor ";} 

  if ($ID eq $id57) {$key=57; 
			   $SensorType[$key]=" Turbidity Sensor ";}
  
  if ($ID eq $id58) {$key=58; 
			   $SensorType[$key]=" Turbidity Sensor ";}

  if ($ID eq $id59) {$key=59;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id60) {$key=60;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id61) {$key=61;
 			   $SensorType[$key]=" Temperature sensor ";}
  
  if ($ID eq $id62) {$key=62;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id63) {$key=63;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id64) {$key=64;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id65) {$key=65;
 			   $SensorType[$key]=" Turbidity Sensor ";}

  if ($ID eq $id66) {$key=66;
 			   $SensorType[$key]=" Turbidity Sensor ";}
 
  if ($ID eq $id67) {$key=67;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id68) {$key=68;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id69) {$key=69;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id70) {$key=70;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id71) {$key=71;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id72) {$key=72;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id73) {$key=73;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id74) {$key=74;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id75) {$key=75;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id76) {$key=76;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id77) {$key=77;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id78) {$key=78;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id79) {$key=79;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id80) {$key=80;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id81) {$key=81;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id82) {$key=82;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id83) {$key=83;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id84) {$key=84;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id85) {$key=85;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id86) {$key=86;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id87) {$key=87;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id88) {$key=88;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id89) {$key=89;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id90) {$key=90;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id91) {$key=91;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id92) {$key=92;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id93) {$key=93;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id94) {$key=94;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id95) {$key=95;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id96) {$key=96;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id97) {$key=97;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id98) {$key=98;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id99) {$key=99;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id100) {$key=100;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id101) {$key=101;
 			   $SensorType[$key]=" Flow and Light sensor";}
 
  if ($ID eq $id102) {$key=102;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id103) {$key=103;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id104) {$key=104;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id105) {$key=105;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id106) {$key=106;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id107) {$key=107;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id108) {$key=108;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id109) {$key=109;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id110) {$key=110;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id111) {$key=111;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id112) {$key=112;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id113) {$key=113;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id114) {$key=114;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id115) {$key=115;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id116) {$key=116;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id117) {$key=117;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id118) {$key=118;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id119) {$key=119;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id120) {$key=120;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id121) {$key=121;
 			   $SensorType[$key]=" Flow and Light sensor";}
 
  if ($ID eq $id122) {$key=122;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id123) {$key=123;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id124) {$key=124;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id125) {$key=125;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id126) {$key=126;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id127) {$key=127;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id128) {$key=128;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id129) {$key=129;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id130) {$key=130;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id131) {$key=131;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id132) {$key=132;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id133) {$key=133;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id134) {$key=134;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id135) {$key=135;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id136) {$key=136;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id137) {$key=137;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id138) {$key=138;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id139) {$key=139;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id140) {$key=140;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id141) {$key=141;
 			   $SensorType[$key]=" Flow and Light sensor";}

  if ($ID eq $id142) {$key=142;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id143) {$key=143;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id144) {$key=144;
		           $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id145) {$key=145;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id146) {$key=146;
			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id147) {$key=147;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id148) {$key=148;
			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id149) {$key=149;
 			   $SensorType[$key]=" Flow and Light sensor ";}

 if ($ID eq $id150) {$key=150;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id151) {$key=151;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id152) {$key=152;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id153) {$key=153;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id154) {$key=154;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id155) {$key=155;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id156) {$key=156;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id157) {$key=157;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id158) {$key=158;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id159) {$key=159;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id160) {$key=160;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id161) {$key=161;
 			   $SensorType[$key]=" Flow and Light sensor";}
 
  if ($ID eq $id162) {$key=162;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id163) {$key=163;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id164) {$key=164;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id165) {$key=165;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id166) {$key=166;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id167) {$key=167;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id168) {$key=168;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id169) {$key=169;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id170) {$key=170;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id171) {$key=171;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id172) {$key=172;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id173) {$key=173;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id174) {$key=174;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id175) {$key=175;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id176) {$key=176;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id177) {$key=177;
 			   $SensorType[$key]=" Flow and Light sensor ";}

  if ($ID eq $id178) {$key=178;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id179) {$key=179;
 			   $SensorType[$key]=" Flow and Light sensor ";}
 
  if ($ID eq $id180) {$key=180;
 			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id181) {$key=181;
 			   $SensorType[$key]=" Pressure sensor";}

  if ($ID eq $id182) {$key=182;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id183) {$key=183;
 			   $SensorType[$key]=" Pressure sensor ";}

  if ($ID eq $id184) {$key=184;
		           $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id185) {$key=185;
 			   $SensorType[$key]=" Pressure sensor ";}

  if ($ID eq $id186) {$key=186;
			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id187) {$key=187;
 			   $SensorType[$key]=" Pressure sensor ";}

  if ($ID eq $id188) {$key=188;
			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id189) {$key=189;
 			   $SensorType[$key]=" Pressure sensor ";}

  if ($ID eq $id190) {$key=190;
			   $SensorType[$key]=" Temperature sensor ";}

  if ($ID eq $id191) {$key=191;
 			   $SensorType[$key]=" Pressure sensor ";}
 
  if ($ID eq $id192) {$key=192;
 			   $SensorType[$key]=" Temperature sensor ";}
 
  if ($ID eq $id193) {$key=193;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id194) {$key=194;
		           $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id195) {$key=195;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id196) {$key=196;
			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id197) {$key=197;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id198) {$key=198;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id199) {$key=199;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id200) {$key=200;
			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id201) {$key=201;
 			   $SensorType[$key]=" Battery monitor ";}

  if ($ID eq $id202) {$key=202;
 			   $SensorType[$key]=" Battery monitor ";}

 if ($part0 > 0){	  #this checks that it's not eof and is actually a sensor
  $IncidentCounter++;
  $CounterArray[$key][$stick]=$CounterArray[$key][$stick] +1; #increment counter for the sensor that's been found	
  $CRCArray[$key]=$CRC; #use CRC to identify sensors in summary, for now 
  $StickArray[$key][$stick]=$stick; #here is the problem if one sensor is programmed into two sticks

  $TypeArray[$key][$stick]=$part0; #now keep track of the sensor type too

}if ($part0 == "26") #this is a DS2438 battery monitor. we grabbed bytes corresponding to temperature at the radio and actual voltage out of the 5v regulator
    {       #you could also program the mote to get the DS2438's current consumption measurement to keep track of remaining battery life.
    $part1temp= substr($string,-14,2); #get 2nd to last byte (MSB of temperature data)

    $part2temp= substr($string,-11,1); #get first nibble of last byte (LSB of temperature data) #could add in a temperature reading

    $part1volts= substr($string,-8,2); #get 2nd to last byte (MSB of voltage data)

    $part2volts= substr($string,-5,2); #get last byte (LSB of voltage data)

    $part3volts=$part1volts.$part2volts;
 
    $part4volts=sprintf("%d",hex($part3volts)); #convert the hex value to decimal; 500=5V, 1000=10V
     
    $part5volts=$part4volts/100; #here is the sensor voltage divider input in volts as measured by the DS2438

    $ValueArray[$key][$stick][$IncidentCounter][1]=$part5volts; #store every value in an array for printing data columns later
   
    $AvgArray[$key][$stick][1]=$AvgArray[$key][$stick][1] + $part5volts; #increment running total for averaging voltage for this sensor
 		       }
 
  if ($part0 =="20")#Designed for triple sensor boards
    {
    $part1photo= substr($string,-14,2); #get 2nd to last byte (MSB of 12-bit sensor data)

    $part2photo= substr($string,-11,1); #get first nibble of last byte (LSB of 12-bit sensor data)

    $part1flow= substr($string,-8,2); #get 2nd to last byte (MSB of 12-bit sensor data)

    $part2flow= substr($string,-5,1); #get first nibble of last byte (LSB of 12-bit sensor data)
    $part3photo=$part1photo.$part2photo;         #Concatenate all three characters together as a 3 digit hex value
    $part4photo=sprintf ("%d", hex($part3photo));    #Convert the hex value to decimal

    $part3flow=$part1flow.$part2flow;         #Concatenate all three characters together as a 3 digit hex value
    $part4flow=sprintf ("%d", hex($part3flow));    #Convert the hex value to decimal

       {
       $part5photo=$part4photo/4095 * 5;  #Scale the value to a voltage (later, use look up table for calibration)
       $part5flow=$part4flow/4095*5; #do same for flow value
 #      printf ("%1.3f", $part5);      #show what's going on
	 $ValueArray[$key][$stick][$IncidentCounter][1]=$part5photo; #store every value in an array for printing data columns later
	 $AvgArray[$key][$stick][1]=$AvgArray[$key][$stick][1] + $part5photo; #increment running total for averaging voltage for this sensor

         
	 $ValueArray[$key][$stick][$IncidentCounter][2]=$part5flow; #store every value in an array for printing data columns later
	 $AvgArray[$key][$stick][2]=$AvgArray[$key][$stick][2] + $part5flow; #increment running total for averaging voltage for this sensor
       }
    
    }
  
  if ($part0 =="10")# this is one of the new temperature sensors on the triple sensor boards
    {
    #print ("Temperature\: ");
    $signpart=substr($string, -14,1); #get sign (0 is pos, 1 is neg);
    $part1= substr ($string, -13,1); #get 2nd nibble of 1st byte (MSB of temperature data)
    $part2=substr($string, -11,2); #get last byte
    $part3=$part1.$part2; #concatenate to form a 3 digit hex value-last nibble to right of decimal point
                          #so divide by 16 later
    $part4=sprintf("%d", hex($part3)); #convert the hex value to decimal
    $part5=$part4*85/170; #scale the value to a temp in Celsius
 
    $ValueArray[$key][$stick][$IncidentCounter][1]=$part5; #store every value in an array for printing data columns later
    #if ($signpart=="1") {print ("\-")}; #print negative sign if needed
    #printf("%1.3f", $part5); #print value
    #print(" Celsius\n");
    }
}
close (INFILE1);


#print a series of data for each sensor in a comma-delimited format that can go into Excel
#first, print column labels
for ($j=1;$j<=30;$j++) {#look at sensors on separate sticks
   for ($i=1;$i<=202;$i++) { 
    if ( $CounterArray[$i][$j] >0) {
      if ($StickArray[$i][$j]>0){

      
  #THIS TIME get Ben/Cory's list number by (n+1)/2 -42if it's a A/D and n/2-42 if it's a temp sensor
        if (($i>84) & ($i<191))  { #it's one of the sensors on Cory and Ben's June 2010 list
           if ($TypeArray[$i][$j]=="20") {
           $BenAndCoryNickname=($i+1)/2 -42;
           }
           if ($TypeArray[$i][$j]=="10") {
           $BenAndCoryNickname=$i/2 -42;
           }
           
         } 
        
         
           else {
                   $BenAndCoryNickname = " ";  #it's not on their sensor list
                 }
           
        

        print "$BenAndCoryNickname-Sen-$CRCArray[$i]-Stk-$StickArray[$i][$j]";
        if($TypeArray[$i][$j] =="10" ) {
           print "-Temp (C),";
           } #it's a temperature sensor
        
        if ($TypeArray[$i][$j] =="20") {#it's a flow/light OR PRESSURE sensor -print a second label for another data column
           if (($i>84) & ($i<180)) #it's a flow/light sensor
           {
           print "-Photo (V),$BenAndCoryNickname-Sen-$CRCArray[$i]-Stk-$StickArray[$i][$j]-Flow (V),";
           }
           if (($i>180) & ($i<192)) #it's a pressure sensor
           {
           print "-Null (V),$BenAndCoryNickname-Sen-$CRCArray[$i]-Stk-$StickArray[$i][$j]-Pressure (V),";
           } 
        }
        if ($TypeArray[$i][$j] == "26") #it's a battery monitor so print label
           {
           print "-Batt (V),";
           }
						
        }                                                              }
   }
}
print"Time(sec)\n";
$myTime=1; # a counter for each measurement of each sensor
$timer=0; #track time in seconds
@TimeArray=-6;
while ($myTime<$IncidentCounter){
$mycheck=0; #keep looking for at least one nonzero value each time through the loop
 for ($j=1;$j<=30;$j++) {#look at sensors on separate sticks{#display summary of sensor average 
   for ($i=1;$i<=202;$i++) 
   { 
    if ( $CounterArray[$i][$j] >0) {
      if ($StickArray[$i][$j]>0){

         if($ValueArray[$i][$j][$myTime][1] >= 0) {
           $mycheck=1;
           if($ValueArray[$i][$j][$myTime][1]>0) {
                $TimeArray[$j]+=0.5;
              } #increment stick's timer by 0.5 second
           $timer=$TimeArray[$j]-0;
           print "$ValueArray[$i][$j][$myTime][1],";
           if($TypeArray[$i][$j]=="20"){     #print second value if it's a flow/light sensor
              print "$ValueArray[$i][$j][$myTime][2],";
               }
           }
         else {print ",";}

        }
      }
   }
 }
print "$timer\n";
$myTime++;
if ($mycheck==0) {$done=1;}
}
close (OUTFILE1);
reset('a-h');
reset ('j-z');  #now looping through files want to clear all lowercase except i (IDs) and some uppercase variables
reset('A-C');  #this one would trash any input arguments ARGV though
reset('S-V');
reset('I');
}
closedir(DIR);
