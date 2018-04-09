
DROP TABLE IF EXISTS pricing.airports CASCADE;

CREATE TABLE pricing.airports (
City TEXT,
FAA VARCHAR(3),
IATA VARCHAR(3),
ICA VARCHAR(4),
Airport TEXT,
Airport_Role VARCHAR(3),
Enplanements BIGINT,
Hub_Assignment VARCHAR(3),
is_hub INTEGER
)
DISTRIBUTED BY(FAA);

-- if you are loading this in GPDB then you need to use the following load statement.
-- \copy pricing.airports(city, faa, iata, ica, airport, airport_role, enplanements, hub_assignment, is_hub) from './airports.csv' csv header
SELECT '(' || city || ',' || faa || ',' || iata || ',' || ica || ',' || airport || ',' || airport_role || ',' || enplanements || ',' || hub_assignment || ',' || is_hub  || '),' AS IN_VALUES FROM pricing.airports;

COPY  pricing.airports (city, faa, iata, ica, airport, airport_role, enplanements, hub_assignment, is_hub) FROM stdin;
Birmingham	BHM	BHM	KBHM	Birmingham-Shuttlesworth International Airport	P-S	1443215	DFW	0
Dothan	DHN	DHN	KDHN	Dothan Regional Airport	P-N	41453		0
Huntsville	HSV	HSV	KHSV	Huntsville International Airport (Carl T. Jones Field)	P-S	606127	DFW	0
Mobile	MOB	MOB	KMOB	Mobile Regional Airport	P-N	277232		0
Montgomery	MGM	MGM	KMGM	Montgomery Regional Airport (Dannelly Field)	P-N	194540		0
Anchorage	ANC	ANC	PANC	Ted Stevens Anchorage International Airport	P-M	2599313	LAX	0
Anchorage	MRI	MRI	PAMR	Merrill Field	P-N	15206		0
Aniak	ANI	ANI	PANI	Aniak Airport	P-N	18526		0
Barrow	BRW	BRW	PABR	Wiley Postâ€“Will Rogers Memorial Airport	P-N	40674		0
Bethel	BET	BET	PABE	Bethel Airport	P-N	140291		0
Cordova	CDV	CDV	PACV	Merle K. (Mudhole) Smith Airport	P-N	16640		0
Deadhorse / Prudhoe Bay	SCC	SCC	PASC	Deadhorse Airport (Prudhoe Bay Airport)	P-N	99719		0
Dillingham	DLG	DLG	PADL	Dillingham Airport	P-N	32215		0
Fairbanks	FAI	FAI	PAFA	Fairbanks International Airport	P-S	456947	LAX	0
Gustavus	GST	GST	PAGS	Gustavus Airport	P-N	11828		0
Homer	HOM	HOM	PAHO	Homer Airport	P-N	44288		0
Juneau	JNU	JNU	PAJN	Juneau International Airport	P-S	378741	LAX	0
Kenai	ENA	ENA	PAEN	Kenai Municipal Airport	P-N	96565		0
Ketchikan	KTN	KTN	PAKT	Ketchikan International Airport	P-N	108837		0
King Salmon	AKN	AKN	PAKN	King Salmon Airport	P-N	42310		0
Kodiak	ADQ	ADQ	PADQ	Kodiak Airport	P-N	82057		0
Kotzebue	OTZ	OTZ	PAOT	Ralph Wien Memorial Airport	P-N	66322		0
Manokotak	MBA	KMO	PAMB	Manokotak Airport	P-N	13393		0
Nome	OME	OME	PAOM	Nome Airport	P-N	59984		0
Petersburg	PSG	PSG	PAPG	Petersburg James A. Johnson Airport	P-N	19901		0
Sitka	SIT	SIT	PASI	Sitka Rocky Gutierrez Airport	P-N	68197		0
Skagway	SGY	SGY	PAGY	Skagway Airport	P-N	10727		0
Unalakleet	UNK	UNK	PAUN	Unalakleet Airport	P-N	12327		0
Unalaska	DUT	DUT	PADU	Unalaska Airport (Tom Madsen Airport)	P-N	28234		0
Valdez	VDZ	VDZ	PAVD	Valdez Airport (Pioneer Field)	P-N	14981		0
Wrangell	WRG	WRG	PAWG	Wrangell Airport	P-N	10601		0
Yakutat	YAK	YAK	PAYA	Yakutat Airport	P-N	11028		0
Bullhead City	IFP	IFP	KIFP	Laughlin/Bullhead International Airport	P-N	122192		0
Flagstaff	FLG	FLG	KFLG	Flagstaff Pulliam Airport	P-N	51765		0
Grand Canyon / Tusayan	GCN	GCN	KGCN	Grand Canyon National Park Airport	P-S	294436	ORD	0
Page	PGA	PGA	KPGA	Page Municipal Airport	P-N	33118		0
Peach Springs	1G4	GCW		Grand Canyon West Airport	P-N	65351		0
Phoenix	PHX	PHX	KPHX	Phoenix Sky Harbor International Airport	P-L	19450576	DFW	0
Tucson	TUS	TUS	KTUS	Tucson International Airport	P-M	2070573	LAX	0
Yuma	NYL	YUM	KNYL	Yuma International Airport / MCAS Yuma	P-N	87812		0
Fayetteville	XNA	XNA	KXNA	Northwest Arkansas Regional Airport	P-S	547871	ORD	0
Fort Smith	FSM	FSM	KFSM	Fort Smith Regional Airport	P-N	85095		0
Little Rock	LIT	LIT	KLIT	Little Rock National Airport (Adams Field)	P-S	1181846	ORD	0
Texarkana	TXK	TXK	KTXK	Texarkana Regional Airport (Webb Field)	P-N	29820		0
Arcata / Eureka	ACV	ACV	KACV	Arcata Airport	P-N	106637		0
Bakersfield	BFL	BFL	KBFL	Meadows Field	P-N	141847		0
Burbank	BUR	BUR	KBUR	Bob Hope Airport	P-M	2647287	LAX	0
Carlsbad	CRQ	CLD	KCRQ	McClellan-Palomar Airport	P-N	35033		0
Chico	CIC	CIC	KCIC	Chico Municipal Airport	P-N	24809		0
Crescent City	CEC	CEC	KCEC	Del Norte County Airport (Jack McNamara Field)	P-N	12541		0
Fresno	FAT	FAT	KFAT	Fresno Yosemite International Airport	P-S	600489	LAX	0
Inyokern	IYK	IYK	KIYK	Inyokern Airport	P-N	11149		0
Long Beach	LGB	LGB	KLGB	Long Beach Airport (Daugherty Field)	P-S	1413251	LAX	0
Los Angeles	LAX	LAX	KLAX	Los Angeles International Airport	P-L	28861477		1
Modesto	MOD	MOD	KMOD	Modesto City-County Airport (Harry Sham Field)	P-N	37082		0
Monterey	MRY	MRY	KMRY	Monterey Peninsula Airport	P-N	207964		0
Oakland	OAK	OAK	KOAK	Oakland International Airport	P-M	5583748	LAX	0
Ontario	ONT	ONT	KONT	Ontario International Airport	P-M	2998110	LAX	0
Oxnard	OXR	OXR	KOXR	Oxnard Airport	P-N	15961		0
Palm Springs	PSP	PSP	KPSP	Palm Springs International Airport	P-S	772906	LAX	0
Redding	RDD	RDD	KRDD	Redding Municipal Airport	P-N	63331		0
Sacramento	SMF	SMF	KSMF	Sacramento International Airport	P-M	4986771	LAX	0
San Diego	SAN	SAN	KSAN	San Diego International Airport	P-L	9007617	LAX	0
San Francisco	SFO	SFO	KSFO	San Francisco International Airport	P-L	18135827	LAX	0
San Jose	SJC	SJC	KSJC	Norman Y. Mineta San JosÃ© International Airport	P-M	4780264	LAX	0
San Luis Obispo	SBP	SBP	KSBP	San Luis Obispo County Regional Airport (McChesney Field)	P-N	150089		0
Santa Ana	SNA	SNA	KSNA	John Wayne Airport - Orange County (was Orange County Airport)	P-M	4464380	LAX	0
Santa Barbara	SBA	SBA	KSBA	Santa Barbara Municipal Airport	P-S	413929	LAX	0
Santa Maria	SMX	SMX	KSMX	Santa Maria Public Airport (Capt G. Allan Hancock Field)	P-N	54925		0
Santa Rosa	STS	STS	KSTS	Charles M. Schulz - Sonoma County Airport	P-N	100676		0
Stockton	SCK	SCK	KSCK	Stockton Metropolitan Airport	P-N	36935		0
Aspen	ASE	ASE	KASE	Aspen-Pitkin County Airport (Sardy Field)	P-N	213381		0
Colorado Springs	COS	COS	KCOS	City of Colorado Springs Municipal Airport	P-S	997348	ORD	0
Denver	DEN	DEN	KDEN	Denver International Airport	P-L	24287939	DFW	0
Durango	DRO	DRO	KDRO	Durango-La Plata County Airport	P-N	134386		0
Eagle	EGE	EGE	KEGE	Eagle County Regional Airport	P-N	212832		0
Fort Collins / Loveland	FNL	FNL	KFNL	Fort Collins-Loveland Municipal Airport	P-N	31094		0
Grand Junction	GJT	GJT	KGJT	Grand Junction Regional Airport (Walker Field)	P-N	212588		0
Gunnison	GUC	GUC	KGUC	Gunnison-Crested Butte Regional Airport	P-N	36035		0
Hayden	HDN	HDN	KHDN	Yampa Valley Airport (Yampa Valley Regional)	P-N	136600		0
Montrose	MTJ	MTJ	KMTJ	Montrose Regional Airport	P-N	85868		0
Telluride	TEX	TEX	KTEX	Telluride Regional Airport	P-N	13325		0
New Haven	HVN	HVN	KHVN	Tweed New Haven Regional Airport	P-N	33988		0
Windsor Locks	BDL	BDL	KBDL	Bradley International Airport	P-M	3006362	MIA	0
Daytona Beach	DAB	DAB	KDAB	Daytona Beach International Airport	P-N	282784		0
Fort Lauderdale	FLL	FLL	KFLL	Fort Lauderdale-Hollywood International Airport	P-L	11020091	MIA	0
Fort Myers	RSW	RSW	KRSW	Southwest Florida International Airport	P-M	3770681	MIA	0
Gainesville	GNV	GNV	KGNV	Gainesville Regional Airport	P-N	136623		0
Jacksonville	JAX	JAX	KJAX	Jacksonville International Airport	P-M	2965973	MIA	0
Key West	EYW	EYW	KEYW	Key West International Airport	P-N	231339		0
Melbourne	MLB	MLB	KMLB	Melbourne International Airport	P-N	145117		0
Miami	MIA	MIA	KMIA	Miami International Airport	P-L	16377488		1
Orlando	MCO	MCO	KMCO	Orlando International Airport	P-L	17288480	MIA	0
Orlando	SFB	SFB	KSFB	Orlando Sanford International Airport	P-S	927188	MIA	0
Pensacola	PNS	PNS	KPNS	Pensacola Gulf Coast Regional Airport	P-S	771917	MIA	0
Sarasota / Bradenton	SRQ	SRQ	KSRQ	Sarasota-Bradenton International Airport	P-S	753126	MIA	0
St. Petersburg	PIE	PIE	KPIE	St. Petersburg-Clearwater International Airport	P-N	363725		0
Tallahassee	TLH	TLH	KTLH	Tallahassee Regional Airport	P-S	399094	MIA	0
Tampa	TPA	TPA	KTPA	Tampa International Airport	P-L	8871917	MIA	0
Valparaiso	VPS	VPS	KVPS	Northwest Florida Regional Airport / Eglin Air Force Base	P-N	373808		0
West Palm Beach	PBI	PBI	KPBI	Palm Beach International Airport	P-M	3232009	MIA	0
Albany	ABY	ABY	KABY	Southwest Georgia Regional Airport	P-N	39200		0
Atlanta	ATL	ATL	KATL	Hartsfield-Jackson Atlanta International Airport	P-L	43761280	MIA	0
Augusta	AGS	AGS	KAGS	Augusta Regional Airport at Bush Field	P-N	176097		0
Brunswick	BQK	BQK	KBQK	Brunswick Golden Isles Airport	P-N	29594		0
Columbus	CSG	CSG	KCSG	Columbus Airport	P-N	51288		0
Macon	MCN	MCN	KMCN	Middle Georgia Regional Airport	P-N	10029		0
Savannah	SAV	SAV	KSAV	Savannah/Hilton Head International Airport	P-S	959037	MIA	0
Valdosta	VLD	VLD	KVLD	Valdosta Regional Airport	P-N	38269		0
Hilo	ITO	ITO	PHTO	Hilo International Airport	P-S	648263	LAX	0
Honolulu	HNL	HNL	PHNL	Honolulu International Airport / Hickam AFB	P-L	9013440	LAX	0
Kahului	OGG	OGG	PHOG	Kahului Airport	P-M	2652335	MIA	0
Kailua/Kona	KOA	KOA	PHKO	Kona International Airport at Keahole	P-S	1332667	LAX	0
Kaunakakai	MKK	MKK	PHMK	Molokai Airport	P-N	89468		0
Lanai City	LNY	LNY	PHNY	Lanai Airport	P-N	52075		0
Lihue (Lihu'e)	LIH	LIH	PHLI	Lihue Airport (Lihu'e Airport)	P-S	1287696	LAX	0
Boise	BOI	BOI	KBOI	Boise Airport (Boise Air Terminal) (Gowen Field)	P-S	1574210	ORD	0
Hailey	SUN	SUN	KSUN	Friedman Memorial Airport	P-N	64233		0
Idaho Falls	IDA	IDA	KIDA	Idaho Falls Regional Airport (Fanning Field)	P-N	148584		0
Lewiston	LWS	LWS	KLWS	Lewiston-Nez Perce County Airport	P-N	64379		0
Pocatello / Arbon Valley	PIH	PIH	KPIH	Pocatello Regional Airport	P-N	25756		0
Twin Falls	TWF	TWF	KTWF	Magic Valley Regional Airport (Joslin Field)	P-N	29606		0
Belleville	BLV	BLV	KBLV	MidAmerica St. Louis Airport / Scott Air Force Base	P-N	27002		0
Bloomington / Normal	BMI	BMI	KBMI	Central Illinois Regional Airport at Bloomington-Normal	P-N	262846		0
Champaign / Urbana	CMI	CMI	KCMI	University of Illinois - Willard Airport	P-N	98225		0
Chicago	ORD	ORD	KORD	Chicago O'Hare International Airport	P-L	33683991		1
Moline	MLI	MLI	KMLI	Quad City International Airport	P-S	476532	ORD	0
Rockford	RFD	RFD	KRFD	Chicago Rockford International Airport	P-N	110151		0
Springfield	SPI	SPI	KSPI	Abraham Lincoln Capital Airport	P-N	56771		0
Evansville	EVV	EVV	KEVV	Evansville Regional Airport	P-N	193349		0
Fort Wayne	FWA	FWA	KFWA	Fort Wayne International Airport	P-N	282449		0
Indianapolis	IND	IND	KIND	Indianapolis International Airport	P-M	4061450	MIA	0
South Bend	SBN	SBN	KSBN	South Bend Regional Airport	P-S	357168	ORD	0
Cedar Rapids	CID	CID	KCID	The Eastern Iowa Airport	P-S	499600	ORD	0
Des Moines	DSM	DSM	KDSM	Des Moines International Airport	P-S	919990	ORD	0
Dubuque	DBQ	DBQ	KDBQ	Dubuque Regional Airport	P-N	42870		0
Mason City	MCW	MCW	KMCW	Mason City Municipal Airport	P-N	11678		0
Sioux City	SUX	SUX	KSUX	Sioux Gateway Airport (Col. Bud Day Field)	P-N	49871		0
Waterloo	ALO	ALO	KALO	Waterloo Regional Airport	P-N	26831		0
Garden City	GCK	GCK	KGCK	Garden City Regional Airport	P-N	11453		0
Manhattan	MHK	MHK	KMHK	Manhattan Regional Airport	P-N	16489		0
Wichita	ICT	ICT	KICT	Wichita Mid-Continent Airport	P-S	780756	ORD	0
Covington	CVG	CVG	KCVG	Cincinnati/Northern Kentucky International Airport	P-L	5194214	ORD	0
Lexington	LEX	LEX	KLEX	Blue Grass Airport	P-S	450464	MIA	0
Louisville	SDF	SDF	KSDF	Louisville International Airport (Standiford Field)	P-S	1622804	MIA	0
Paducah	PAH	PAH	KPAH	Barkley Regional Airport	P-N	18452		0
Alexandria	AEX	AEX	KAEX	Alexandria International Airport	P-N	179129		0
Baton Rouge	BTR	BTR	KBTR	Baton Rouge Metropolitan Airport (Ryan Field)	P-S	382687	MIA	0
Lafayette	LFT	LFT	KLFT	Lafayette Regional Airport	P-N	220211		0
Lake Charles	LCH	LCH	KLCH	Lake Charles Regional Airport	P-N	65340		0
Monroe	MLU	MLU	KMLU	Monroe Regional Airport	P-N	100419		0
New Orleans	MSY	MSY	KMSY	Louis Armstrong New Orleans International Airport	P-M	4088037	DFW	0
Shreveport	SHV	SHV	KSHV	Shreveport Regional Airport	P-N	237945		0
Bangor	BGR	BGR	KBGR	Bangor International Airport	P-S	355508	ORD	0
Bar Harbor	BHB	BHB	KBHB	Hancock County-Bar Harbor Airport	P-N	10562		0
Portland	PWM	PWM	KPWM	Portland International Jetport	P-S	876102	LAX	0
Presque Isle	PQI	PQI	KPQI	Northern Maine Regional Airport at Presque Isle	P-N	13385		0
Rockland	RKD	RKD	KRKD	Knox County Regional Airport	P-N	13866		0
Baltimore / Glen Burnie	BWI	BWI	KBWI	Baltimore/Washington International Thurgood Marshall Airport	P-L	10215225	ORD	0
Salisbury	SBY	SBY	KSBY	Salisbury-Ocean City Wicomico Regional Airport	P-N	58863		0
Boston	BOS	BOS	KBOS	Gen. Edward Lawrence Logan International Airport	P-L	12820489	JFK	0
Hyannis	HYA	HYA	KHYA	Barnstable Municipal Airport (Boardman/Polando Field)	P-N	191906		0
Nantucket	ACK	ACK	KACK	Nantucket Memorial Airport	P-N	258214		0
New Bedford	EWB	EWB	KEWB	New Bedford Regional Airport	P-N	13908		0
Provincetown	PVC	PVC	KPVC	Provincetown Municipal Airport	P-N	11468		0
Vineyard Haven	MVY	MVY	KMVY	Martha's Vineyard Airport	P-N	45002		0
Charlevoix	CVX	CVX	KCVX	Charlevoix Municipal Airport	P-N	17854		0
Detroit / Romulus	DTW	DTW	KDTW	Detroit Metropolitan Wayne County Airport	P-L	16998174	ORD	0
Flint	FNT	FNT	KFNT	Bishop International Airport	P-S	526492	LAX	0
Grand Rapids	GRR	GRR	KGRR	Gerald R. Ford International Airport	P-S	902925	LAX	0
Hancock / Calumet	CMX	CMX	KCMX	Houghton County Memorial Airport	P-N	25354		0
Kalamazoo / Battle Creek	AZO	AZO	KAZO	Kalamazoo/Battle Creek International Airport	P-N	168687		0
Lansing	LAN	LAN	KLAN	Capital Region International Airport (was Lansing Capital City)	P-N	217437		0
Marquette / Gwinn	SAW	MQT	KSAW	Sawyer International Airport	P-N	56172		0
Muskegon	MKG	MKG	KMKG	Muskegon County Airport	P-N	30051		0
Pellston	PLN	PLN	KPLN	Pellston Regional Airport of Emmet County	P-N	26222		0
Saginaw	MBS	MBS	KMBS	MBS International Airport	P-N	162703		0
Sault Ste. Marie	CIU	CIU	KCIU	Chippewa County International Airport	P-N	13269		0
Traverse City	TVC	TVC	KTVC	Cherry Capital Airport	P-N	183357		0
Bemidji	BJI	BJI	KBJI	Bemidji Regional Airport	P-N	22007		0
Brainerd	BRD	BRD	KBRD	Brainerd Lakes Regional Airport	P-N	16665		0
Duluth	DLH	DLH	KDLH	Duluth International Airport	P-N	147793		0
International Falls	INL	INL	KINL	Falls International Airport	P-N	16590		0
Minneapolis	MSP	MSP	KMSP	Minneapolis-St. Paul International Airport (Wold-Chamberlain Field)	P-L	16369324		0
Rochester	RST	RST	KRST	Rochester International Airport	P-N	151250		0
St. Cloud	STC	STC	KSTC	St. Cloud Regional Airport	P-N	20161		0
Columbus / West Point / Starkville	GTR	GTR	KGTR	Golden Triangle Regional Airport	P-N	36329		0
Gulfport / Biloxi	GPT	GPT	KGPT	Gulfport-Biloxi International Airport	P-S	461072	MIA	0
Hattiesburg / Laurel	PIB	PIB	KPIB	Hattiesburg-Laurel Regional Airport	P-N	13766		0
Jackson	JAN	JAN	KJAN	Jackson-Evers International Airport	P-S	618373	MIA	0
Meridian	MEI	MEI	KMEI	Meridian Regional Airport (Key Field)	P-N	16871		0
Tunica	UTA	UTM	KUTA	Tunica Municipal Airport	P-N	65907		0
Tupelo	TUP	TUP	KTUP	Tupelo Regional Airport (C.D. Lemons Field)	P-N	12749		0
Columbia	COU	COU	KCOU	Columbia Regional Airport	P-N	12719		0
Kansas City	MCI	MCI	KMCI	Kansas City International Airport	P-M	5386242	DFW	0
Springfield	SGF	SGF	KSGF	Springfield-Branson National Airport	P-S	779995	MIA	0
St. Louis	STL	STL	KSTL	Lambert-St. Louis International Airport	P-M	6740468	ORD	0
Billings	BIL	BIL	KBIL	Billings Logan International Airport	P-S	422494	JFK	0
Bozeman	BZN	BZN	KBZN	Gallatin Field Airport	P-N	349550		0
Butte	BTM	BTM	KBTM	Bert Mooney Airport	P-N	30431		0
Great Falls	GTF	GTF	KGTF	Great Falls International Airport	P-N	143811		0
Helena	HLN	HLN	KHLN	Helena Regional Airport	P-N	85649		0
Kalispell	GPI	FCA	KGPI	Glacier Park International Airport	P-N	186450		0
Missoula	MSO	MSO	KMSO	Missoula International Airport	P-N	288071		0
Omaha	OMA	OMA	KOMA	Eppley Airfield	P-M	2083973	ORD	0
Lincoln	LNK	LNK	KLNK	Lincoln Airport (was Lincoln Municipal)	P-N	142507		0
Grand Island	GRI	GRI	KGRI	Central Nebraska Regional Airport	P-N	20136		0
Scottsbluff	BFF	BFF	KBFF	Western Nebraska Regional Airport (William B. Heilig Field)	P-N	9221		0
Boulder City	BVU	BLD	KBVU	Boulder City Municipal Airport	P-N	300553		0
Elko	EKO	EKO	KEKO	Elko Regional Airport (J.C. Harris Field)	P-N	25523		0
Las Vegas	LAS	LAS	KLAS	McCarran International Airport	P-L	21024443	DFW	0
North Las Vegas	VGT	VGT	KVGT	North Las Vegas Airport	P-N	67389		0
Reno	RNO	RNO	KRNO	Reno-Tahoe International Airport	P-M	2150816	ORD	0
Manchester	MHT	MHT	KMHT	Manchester-Boston Regional Airport	P-M	1834875	JFK	0
Portsmouth	PSM	PSM	KPSM	Portsmouth International Airport at Pease	P-N	49962		0
Atlantic City	ACY	ACY	KACY	Atlantic City International Airport	P-S	527873	JFK	0
Newark	EWR	EWR	KEWR	Newark Liberty International Airport	P-L	17599578	JFK	0
Albuquerque	ABQ	ABQ	KABQ	Albuquerque International Sunport	P-M	3158971	DFW	0
Farmington	FMN	FMN	KFMN	Four Corners Regional Airport	P-N	17044		0
Albany	ALB	ALB	KALB	Albany International Airport	P-S	1365854	JFK	0
Binghamton	BGM	BGM	KBGM	Greater Binghamton Airport (Edwin A. Link Field)	P-N	125368		0
Buffalo	BUF	BUF	KBUF	Buffalo Niagara International Airport	P-M	2744501	JFK	0
Elmira / Corning	ELM	ELM	KELM	Elmira/Corning Regional Airport	P-N	104508		0
Islip	ISP	ISP	KISP	Long Island MacArthur Airport	P-S	1048768	JFK	0
Ithaca	ITH	ITH	KITH	Ithaca Tompkins Regional Airport	P-N	91866		0
New York	JFK	JFK	KJFK	John F. Kennedy International Airport	P-L	23620948		1
New York	LGA	LGA	KLGA	LaGuardia Airport (and Marine Air Terminal)	P-L	11567586	ORD	0
Newburgh	SWF	SWF	KSWF	Stewart International Airport	P-N	392464		0
Rochester	ROC	ROC	KROC	Greater Rochester International Airport	P-S	1349694	JFK	0
Syracuse	SYR	SYR	KSYR	Syracuse Hancock International Airport	P-S	1105143	JFK	0
White Plains	HPN	HPN	KHPN	Westchester County Airport	P-S	904482	JFK	0
Asheville	AVL	AVL	KAVL	Asheville Regional Airport	P-N	682306		0
Charlotte	CLT	CLT	KCLT	Charlotte/Douglas International Airport	P-L	18281425	JFK	0
Fayetteville	FAY	FAY	KFAY	Fayetteville Regional Airport (Grannis Field)	P-N	202597		0
Greensboro	GSO	GSO	KGSO	Piedmont Triad International Airport	P-S	863745	JFK	0
Greenville	PGV	PGV	KPGV	Pitt-Greenville Airport	P-N	52287		0
Jacksonville	OAJ	OAJ	KOAJ	Albert J. Ellis Airport	P-N	126947		0
New Bern	EWN	EWN	KEWN	Coastal Carolina Regional Airport (was Craven Co. Regional)	P-N	111184		0
Raleigh	RDU	RDU	KRDU	Raleigh-Durham International Airport	P-M	4868492	JFK	0
Wilmington	ILM	ILM	KILM	Wilmington International Airport	P-N	469993		0
Bismarck	BIS	BIS	KBIS	Bismarck Municipal Airport	P-N	178005		0
Fargo	FAR	FAR	KFAR	Hector International Airport	P-N	326941		0
Grand Forks	GFK	GFK	KGFK	Grand Forks International Airport	P-N	88093		0
Minot	MOT	MOT	KMOT	Minot International Airport	P-N	71595		0
Akron	CAK	CAK	KCAK	Akron-Canton Regional Airport	P-S	715367	JFK	0
Cleveland	CLE	CLE	KCLE	Cleveland-Hopkins International Airport	P-M	4704329	DWF	0
Columbus	CMH	CMH	KCMH	Port Columbus International Airport	P-M	3096515	JFK	0
Dayton	DAY	DAY	KDAY	James M. Cox Dayton International Airport	P-S	1240848	MIA	0
Toledo	TOL	TOL	KTOL	Toledo Express Airport	P-N	93669		0
Youngstown / Warren	YNG	YNG	KYNG	Youngstown-Warren Regional Airport / Youngstown ARS	P-N	17391		0
Lawton	LAW	LAW	KLAW	Lawton-Fort Sill Regional Airport	P-N	77533		0
Oklahoma City	OKC	OKC	KOKC	Will Rogers World Airport	P-S	1838709	ORD	0
Tulsa	TUL	TUL	KTUL	Tulsa International Airport	P-S	1606622	MIA	0
Eugene	EUG	EUG	KEUG	Eugene Airport (Mahlon Sweet Field)	P-N	358819		0
Klamath Falls	LMT	LMT	KLMT	Klamath Falls Airport (Kingsley Field)	P-N	26970		0
Medford	MFR	MFR	KMFR	Rogue Valley International-Medford Airport	P-N	287688		0
North Bend	OTH	OTH	KOTH	Southwest Oregon Regional Airport (was North Bend Municipal)	P-N	35458		0
Portland	PDX	PDX	KPDX	Portland International Airport	P-M	7090526	LAX	0
Redmond	RDM	RDM	KRDM	Redmond Municipal Airport (Roberts Field)	P-N	235192		0
Allentown	ABE	ABE	KABE	Lehigh Valley International Airport	P-S	392039	MIA	0
Erie	ERI	ERI	KERI	Erie International Airport (Tom Ridge Field)	P-N	124667		0
Harrisburg / Middletown	MDT	MDT	KMDT	Harrisburg International Airport	P-S	635627	ORD	0
Latrobe	LBE	LBE	KLBE	Arnold Palmer Regional Airport	P-N	18946		0
Philadelphia	PHL	PHL	KPHL	Philadelphia International Airport	P-L	15586852	JFK	0
Pittsburgh	PIT	PIT	KPIT	Pittsburgh International Airport	P-M	4292546	JFK	0
State College	UNV	SCE	KUNV	University Park Airport	P-N	133777		0
Wilkes-Barre / Scranton	AVP	AVP	KAVP	Wilkes-Barre/Scranton International Airport	P-N	219745		0
Williamsport	IPT	IPT	KIPT	Williamsport Regional Airport	P-N	23901		0
Providence / Warwick	PVD	PVD	KPVD	Theodore Francis Green State Airport	P-M	2342593	JFK	0
Charleston	CHS	CHS	KCHS	Charleston International Airport / Charleston AFB	P-S	1174667	ORD	0
Columbia	CAE	CAE	KCAE	Columbia Metropolitan Airport	P-S	565938	ORD	0
Florence	FLO	FLO	KFLO	Florence Regional Airport	P-N	64835		0
Greer	GSP	GSP	KGSP	Greenville-Spartanburg International Airport (Roger Milliken Field)	P-S	699805	ORD	0
Hilton Head Island	HXD	HHH	KHXD	Hilton Head Airport	P-N	79912		0
Myrtle Beach	MYR	MYR	KMYR	Myrtle Beach International Airport	P-S	705430	ORD	0
Aberdeen	ABR	ABR	KABR	Aberdeen Regional Airport	P-N	23225		0
Pierre	PIR	PIR	KPIR	Pierre Regional Airport	P-N	15983		0
Rapid City	RAP	RAP	KRAP	Rapid City Regional Airport	P-N	273151		0
Sioux Falls	FSD	FSD	KFSD	Sioux Falls Regional Airport (Joe Foss Field)	P-S	367874	ORD	0
Bristol / Johnson City / Kingsport	TRI	TRI	KTRI	Tri-Cities Regional Airport (Tri-Cities Regional TN/VA)	P-N	202730		0
Chattanooga	CHA	CHA	KCHA	Chattanooga Metropolitan Airport (Lovell Field)	P-N	300796		0
Knoxville	TYS	TYS	KTYS	McGhee Tyson Airport	P-S	839266	DFW	0
Memphis	MEM	MEM	KMEM	Memphis International Airport	P-M	5376818	ORD	0
Nashville	BNA	BNA	KBNA	Nashville International Airport (Berry Field)	P-M	4648000	ORD	0
Abilene	ABI	ABI	KABI	Abilene Regional Airport	P-N	73605		0
Amarillo	AMA	AMA	KAMA	Rick Husband Amarillo International Airport	P-S	394593	DFW	0
Austin	AUS	AUS	KAUS	Austin-Bergstrom International Airport	P-M	4201136	DFW	0
Beaumont / Port Arthur	BPT	BPT	KBPT	Southeast Texas Regional Airport	P-N	17394		0
Brownsville	BRO	BRO	KBRO	Brownsville/South Padre Island International Airport	P-N	84401		0
College Station	CLL	CLL	KCLL	Easterwood Airport (Easterwood Field)	P-N	72188		0
Corpus Christi / Kingsville	CRP	CRP	KCRP	Corpus Christi International Airport	P-N	339193		0
Dallas	DAL	DAL	KDAL	Dallas Love Field	P-M	3783407	DFW	0
Dallas-Fort Worth	DFW	DFW	KDFW	Dallas-Fort Worth International Airport	P-L	27100656		1
Del Rio	DRT	DRT	KDRT	Del Rio International Airport	P-N	13180		0
El Paso	ELP	ELP	KELP	El Paso International Airport	P-S	1509093	DFW	0
Fort Hood / Killeen / Temple	GRK	GRK	KGRK	Killeen-Fort Hood Regional Airport / Robert Gray Army Airfield	P-N	243861		0
Harlingen	HRL	HRL	KHRL	Valley International Airport	P-S	373438	DFW	0
Houston	IAH	IAH	KIAH	George Bush Intercontinental Airport	P-L	19528627	DFW	0
Houston	HOU	HOU	KHOU	William P. Hobby Airport	P-M	4357835	DFW	0
Laredo	LRD	LRD	KLRD	Laredo International Airport	P-N	112520		0
Longview	GGG	GGG	KGGG	East Texas Regional Airport	P-N	21830		0
Lubbock	LBB	LBB	KLBB	Lubbock Preston Smith International Airport	P-S	508858	DFW	0
McAllen	MFE	MFE	KMFE	McAllen-Miller International Airport	P-N	344302		0
Midland	MAF	MAF	KMAF	Midland International Airport	P-S	445043	JFK	0
San Angelo	SJT	SJT	KSJT	San Angelo Regional Airport (Mathis Field)	P-N	56021		0
San Antonio	SAT	SAT	KSAT	San Antonio International Airport	P-M	3916320	DWF	0
Tyler	TYR	TYR	KTYR	Tyler Pounds Regional Airport	P-N	74357		0
Waco	ACT	ACT	KACT	Waco Regional Airport	P-N	61401		0
Wichita Falls	SPS	SPS	KSPS	Wichita Falls Municipal Airport / Sheppard Air Force Base	P-N	44296		0
Salt Lake City	SLC	SLC	KSLC	Salt Lake City International Airport	P-L	9993198	DFW	0
Burlington	BTV	BTV	KBTV	Burlington International Airport	P-S	747559	JFK	0
Charlottesville	CHO	CHO	KCHO	Charlottesville-Albemarle Airport	P-N	169843		0
Lynchburg	LYH	LYH	KLYH	Lynchburg Regional Airport (Preston Glenn Field)	P-N	55307		0
Newport News	PHF	PHF	KPHF	Newport News/Williamsburg International Airport	P-S	504292	JFK	0
Norfolk	ORF	ORF	KORF	Norfolk International Airport	P-M	1786594	ORD	0
Richmond	RIC	RIC	KRIC	Richmond International Airport (Byrd Field)	P-S	1733668	JFK	0
Roanoke	ROA	ROA	KROA	Roanoke Regional Airport (Woodrum Field)	P-N	315293		0
Washington, D.C. (Arlington County)	DCA	DCA	KDCA	Ronald Reagan Washington National Airport	P-L	8704466	JFK	0
Washington, D.C. (Chantilly / Dulles)	IAD	IAD	KIAD	Washington Dulles International Airport	P-L	11348775	JFK	0
Bellingham	BLI	BLI	KBLI	Bellingham International Airport	P-N	277281		0
Friday Harbor	FHR	FRD	KFHR	Friday Harbor Airport	P-N	13835		0
Pasco	PSC	PSC	KPSC	Tri-Cities Airport	P-N	242483		0
Port Angeles	CLM	CLM	KCLM	William R. Fairchild International Airport	P-N	12672		0
Pullman / Moscow, Idaho	PUW	PUW	KPUW	Pullman-Moscow Regional Airport	P-N	32108		0
Seattle	BFI	BFI	KBFI	King County International Airport (Boeing Field)	P-N	34597		0
Seattle / Tacoma (SeaTac)	SEA	SEA	KSEA	Seattle-Tacoma International Airport	P-L	15839504	LAX	0
Spokane	GEG	GEG	KGEG	Spokane International Airport (Geiger Field)	P-S	1691345	JFK	0
Walla Walla	ALW	ALW	KALW	Walla Walla Regional Airport	P-N	29672		0
Wenatchee	EAT	EAT	KEAT	Pangborn Memorial Airport	P-N	48275		0
Yakima	YKM	YKM	KYKM	Yakima Air Terminal (McAllister Field)	P-N	69835		0
Charleston	CRW	CRW	KCRW	Yeager Airport	P-N	243793		0
Huntington	HTS	HTS	KHTS	Tri-State Airport (Milton J. Ferguson Field)	P-N	83531		0
Appleton	ATW	ATW	KATW	Outagamie County Regional Airport	P-N	259340		0
Eau Claire	EAU	EAU	KEAU	Chippewa Valley Regional Airport	P-N	18762		0
Green Bay	GRB	GRB	KGRB	Austin Straubel International Airport	P-S	410348	JFK	0
La Crosse	LSE	LSE	KLSE	La Crosse Municipal Airport	P-N	111462		0
Madison	MSN	MSN	KMSN	Dane County Regional Airport (Truax Field)	P-S	728075	JFK	0
Milwaukee	MKE	MKE	KMKE	General Mitchell International Airport	P-M	3861333	ORD	0
Mosinee	CWA	CWA	KCWA	Central Wisconsin Airport	P-N	154312		0
Rhinelander	RHI	RHI	KRHI	Rhinelander-Oneida County Airport	P-N	26193		0
Casper	CPR	CPR	KCPR	Casper/Natrona County International Airport	P-N	74167		0
Cheyenne	CYS	CYS	KCYS	Cheyenne Regional Airport (Jerry Olson Field)	P-N	16697		0
Cody	COD	COD	KCOD	Yellowstone Regional Airport	P-N	25863		0
Gillette	GCC	GCC	KGCC	Gillette-Campbell County Airport	P-N	28232		0
Jackson	JAC	JAC	KJAC	Jackson Hole Airport	P-N	305566		0
Laramie	LAR	LAR	KLAR	Laramie Regional Airport	P-N	10371		0
Riverton	RIW	RIW	KRIW	Riverton Regional Airport	P-N	17035		0
Rock Springs	RKS	RKS	KRKS	Rock Springs â€“ Sweetwater County Airport	P-N	25541		0
Sheridan	SHR	SHR	KSHR	Sheridan County Airport	P-N	17710		0