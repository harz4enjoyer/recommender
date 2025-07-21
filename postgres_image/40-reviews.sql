COPY public.app_user (username, password_argon2_hash) FROM stdin;
bla	$argon2id$v=19$m=19456,t=2,p=1$isNuj8m4MF/h2aEDr4xxYw$kph/iF34Eycv7Rrr5ue8F28ad8G2DS/+WzIFgNOdaR0
blub	$argon2id$v=19$m=19456,t=2,p=1$jCjLJaNtfTQGMjUKjFHnLw$HpqhLQuQy/+aca6rgAeM5wtNBcam9jf4961J3U2AmFI
admin	$argon2id$v=19$m=19456,t=2,p=1$u20l+Nu36qJwGfUFs4Nm8A$BNItL7qHI0RMJVWx3dla4znVsmqZjnmhzQiaEGs783I
admin2	$argon2id$v=19$m=19456,t=2,p=1$LSS0xouNH4p+j5NutFTfyg$mxtCV+pbXLnVF4F3rJpduNu+8o0UvrVOV7RnGzw3JDE
admin3	$argon2id$v=19$m=19456,t=2,p=1$SU79x93kG0JaUl5X6XDOvQ$j3QwS45BpdTQRiBEdoalKdb2X5Au4Vxr/kS2TcFLWBg
\.

COPY public.review (username, item_name, item_category, rating) FROM stdin;
bla	AnimeGenius	ai_tool	2
bla	Riku	ai_tool	4
bla	Taskade	ai_tool	2
bla	RankPress	ai_tool	1
bla	Eloise AI	ai_tool	4
bla	Dashworks	ai_tool	10
blub	chatgpt	ai_tool	3
blub	POLITICO Berlin Playbook	podcast	1
blub	Coda AI	ai_tool	10
blub	life is felicious	podcast	3
blub	Grammarly	ai_tool	3
blub	Wahre Verbrechen - True Crime Podcast	podcast	1
blub	Photosonic	ai_tool	10
blub	Weird Crimes	podcast	6
blub	Besser als Sex	podcast	4
blub	Exolyt	ai_tool	2
blub	AI Detector Pro	ai_tool	3
blub	Soofy	ai_tool	4
blub	Toasty AI	ai_tool	4
admin	Der Tag	podcast	4
admin	Hexometer	ai_tool	7
admin	Automata	ai_tool	3
admin	Fathom	ai_tool	8
admin	Spitzengespräch	podcast	2
admin	Secta Labs	ai_tool	8
admin	Skybox Lab	ai_tool	2
admin	POLITICO Berlin Playbook	podcast	2
admin	Pferdeschwänze	podcast	4
admin	aiCarousels	ai_tool	6
admin	Typefully	ai_tool	6
admin	Einschlafen mit Hogwarts	podcast	3
admin2	Hobbylos	podcast	6
admin2	Fathom	ai_tool	3
admin2	15 Minuten. Der tagesschau-Podcast am Morgen	podcast	7
admin2	Claude	ai_tool	2
admin2	Ecommerce Prompts	ai_tool	6
admin2	Media.io	ai_tool	3
admin2	Marketing Megaprompts	ai_tool	6
admin2	Tugan	ai_tool	3
admin2	Chance AI	ai_tool	5
admin2	AISEO Art	ai_tool	3
admin2	Visily	ai_tool	6
admin2	Writers brew	ai_tool	8
admin2	chatgpt5	ai_tool	4
admin2	Paula Lieben Lernen	podcast	2
admin2	DAS PODCAST UFO	podcast	6
admin2	Kurt Krömer - Feelings	podcast	3
admin2	Riverside Audio Transcription	ai_tool	7
admin2	Talkio	ai_tool	4
admin2	Make Economy Great Again	podcast	2
admin2	Tripo AI	ai_tool	8
admin2	VideoIdeas.ai	ai_tool	6
admin2	Github Autopilot	ai_tool	5
admin2	aiCarousels	ai_tool	6
admin2	HEIGHTS AI	ai_tool	6
admin2	Verbrechen von nebenan: True Crime aus der Nachbarschaft	podcast	2
admin2	Theresa Kirchner	podcast	6
admin2	Gemini	ai_tool	7
admin2	Raum & Zeit	podcast	4
admin2	Frame	ai_tool	5
admin2	WebWave	ai_tool	2
admin2	GAMMA.AI	ai_tool	6
admin2	Monic AI	ai_tool	4
admin2	Wondershare Virbo	ai_tool	5
admin2	Alman Arabica	podcast	6
admin2	DALL.E	ai_tool	4
admin2	5 Minuten Harry Podcast von Coldmirror	podcast	7
admin2	Originality AI	ai_tool	4
admin2	Lovable	ai_tool	6
admin2	Quarks Science Cops	podcast	4
admin2	AI Voice Detector	ai_tool	7
admin2	Visme AI	ai_tool	4
admin2	Elephas	ai_tool	4
admin2	OMR Podcast	podcast	6
admin2	Link Whisper AI	ai_tool	7
admin2	Boomy	ai_tool	2
admin2	DescriptionWise	ai_tool	6
admin2	Glasp	ai_tool	8
admin2	Gemischtes Hack	podcast	4
admin2	Monkeebrain	ai_tool	7
admin2	Lage der Nation - der Politik-Podcast aus Berlin	podcast	4
admin2	Fireflies	ai_tool	6
admin2	Terra X History - Der Podcast	podcast	8
admin2	ChatGPT Writer	ai_tool	6
admin2	TRUE LOVE	podcast	4
admin2	SocialBee	ai_tool	3
admin2	AnimeGenius	ai_tool	7
admin2	Playground AI	ai_tool	5
admin2	n8n	ai_tool	5
admin2	guidde	ai_tool	6
admin2	Pictory	ai_tool	3
admin2	User Evaluation	ai_tool	5
admin2	Pixlr	ai_tool	8
admin2	AISEO	ai_tool	4
admin2	Niemand muss ein Promi sein - Deutschlands Nr. 1 Gossip-Podcast!	podcast	3
admin2	Automata	ai_tool	2
admin2	Ohne Bewährung - True Crime von hier	podcast	6
admin2	Process AI	ai_tool	6
admin2	Das wahre Leben – Der NACHTCAFÉ Podcast	podcast	4
admin2	Caspar AI	ai_tool	6
admin2	Die Nervigen	podcast	7
admin2	Make	ai_tool	7
admin2	G Spot mit Stefanie Giesinger	podcast	4
admin2	Zyro	ai_tool	3
admin2	laserluca	podcast	7
admin2	happy, holy & confident® Dein Podcast fürs Herz und den Verstand	podcast	3
admin2	tinyEinstein	ai_tool	8
admin2	So bin ich eben! Stefanie Stahls Psychologie-Podcast für alle "Normalgestörten"	podcast	5
admin2	Vecteezy AI	ai_tool	4
admin2	Hazel Thomas Hörerlebnis	podcast	6
admin2	JoggAI	ai_tool	3
admin2	SKYNET	ai_tool	7
admin2	RenderLion	ai_tool	3
admin2	Skybox Lab	ai_tool	6
admin2	Linguix	ai_tool	4
admin2	Betreutes Fühlen	podcast	7
admin2	Vidalgo	ai_tool	3
admin2	AIPRM	ai_tool	4
admin2	Picsart	ai_tool	7
admin2	Kling AI	ai_tool	3
admin2	Alle meine Eltern – Der Real Talk mit Evelyn Weigert	podcast	6
admin2	YourMove AI	ai_tool	7
admin2	Hypernatural	ai_tool	3
admin2	Creaitor	ai_tool	3
admin2	Brawler's World	podcast	6
admin2	Bubble AI	ai_tool	7
admin2	Serienkiller - Mörder und ihre Geschichten	podcast	5
admin2	BetterPic	ai_tool	7
admin2	Vista Social	ai_tool	4
admin2	Dante	ai_tool	6
admin2	Inworld	ai_tool	7
admin2	StoryNest	ai_tool	6
admin2	Soofy	ai_tool	4
admin2	Wavel AI	ai_tool	3
admin2	CopySpace	ai_tool	7
admin2	Freeflo	ai_tool	3
admin2	Email Magic	ai_tool	6
admin2	MindPal	ai_tool	7
admin2	Profile Picture AI	ai_tool	3
admin2	stealth writer	ai_tool	5
admin2	Poised	ai_tool	3
admin2	OK, America?	podcast	7
admin2	Synthesia	ai_tool	8
admin2	Photosonic	ai_tool	6
admin2	perplexity	ai_tool	5
admin2	Murf	ai_tool	3
admin2	One Click Human	ai_tool	5
admin2	LearnWorlds AI	ai_tool	7
admin2	ContentShake	ai_tool	5
admin2	Clockk	ai_tool	3
admin2	HypeFury	ai_tool	2
admin	PPSPY	ai_tool	6
admin	GPTinf	ai_tool	6
admin	MagicReply	ai_tool	2
admin	dudes.	podcast	7
admin	DALL.E	ai_tool	4
admin	Zwei Vermengte	podcast	3
admin	Keine Echten Männer	podcast	6
admin	Stimmen im Kopf - True-Crime / Mystery Podcast	podcast	7
admin	OpusClip	ai_tool	3
admin	copyAI	ai_tool	6
admin	Bayern 3 True Crime - Schuld und Unschuld	podcast	8
admin	Biread	ai_tool	3
admin	QR Galaxy	ai_tool	6
admin	Dark Matters – Geheimnisse der Geheimdienste	podcast	7
admin	Blaze	ai_tool	4
admin	Die Deutschen Podcast	podcast	7
admin	DRINNIES	podcast	6
admin	Weltspiegel Podcast	podcast	3
admin	Validly	ai_tool	7
admin	grokai	ai_tool	4
admin3	Text Cortex	ai_tool	8
admin3	MagicReply	ai_tool	5
admin3	TalkPal	ai_tool	4
admin3	Verbrechen von nebenan: True Crime aus der Nachbarschaft	podcast	7
admin3	Zum Scheitern Verurteilt	podcast	3
admin3	Paragraph AI	ai_tool	5
admin3	So bin ich eben! Stefanie Stahls Psychologie-Podcast für alle "Normalgestörten"	podcast	8
admin3	chatgpt	ai_tool	7
admin3	Eagle	ai_tool	4
admin3	Thoughtly	ai_tool	2
admin3	StoryNest	ai_tool	7
admin3	DeepBrain	ai_tool	4
admin3	11KM: der tagesschau-Podcast	podcast	8
admin3	iSpring Page	ai_tool	3
admin3	Sysarchitect	ai_tool	7
admin3	Durable	ai_tool	8
admin3	Handelsblatt Morning Briefing - News aus Wirtschaft, Politik und Finanzen	podcast	3
admin3	Darwin gefällt das	podcast	7
admin3	maischberger. der podcast	podcast	4
admin3	Aktenzeichen XY… Unvergessene Verbrechen	podcast	7
admin3	Upmetrics	ai_tool	4
admin3	MicMonster	ai_tool	7
admin3	ProductScope	ai_tool	3
admin3	Simplified	ai_tool	6
admin3	IMAI	ai_tool	4
admin3	Zentask	ai_tool	7
admin3	Dings und Bums	podcast	8
admin3	Link Whisper AI	ai_tool	4
admin3	LogicLister	ai_tool	7
admin3	Softr AI	ai_tool	8
admin3	Terra X History - Der Podcast	podcast	4
admin3	chatgpt50	ai_tool	5
admin3	Phrasly	ai_tool	7
admin3	Marketing Megaprompts	ai_tool	4
admin3	Merlin	ai_tool	6
admin3	SongR	ai_tool	8
admin3	Acht Milliarden - Der Auslandspodcast des SPIEGEL	podcast	9
admin3	Magai	ai_tool	9
admin3	Apokalypse & Filterkaffee	podcast	9
admin3	Reif ist live – Fußball Talk von BILD	podcast	9
admin3	Automata	ai_tool	9
admin3	Jung & Naiv	podcast	9
admin3	Talkio	ai_tool	9
admin3	Copa TS	podcast	9
admin3	Dieser eine Moment – Der Podcast mit Philipp Fleiter	podcast	9
admin3	Dzine	ai_tool	9
admin3	Verbrechen	podcast	9
admin3	Psychologie to go!	podcast	9
admin3	ContentBot	ai_tool	9
admin3	DET Practice	ai_tool	9
admin3	Ecommerce Prompts	ai_tool	9
admin3	SEOmatic	ai_tool	9
admin3	Alex Freerun	podcast	9
admin3	Parsio	ai_tool	9
admin3	Creaitor	ai_tool	9
admin3	Jay & Arya - Der eigentlich ganz gute Podcast	podcast	9
admin3	chatgpt13	ai_tool	9
admin3	SEOPress	ai_tool	9
admin3	Adobe Firefly	ai_tool	9
admin3	AI Dating	ai_tool	9
admin3	SEO GPT	ai_tool	9
admin3	Divi AI	ai_tool	9
admin3	AITable	ai_tool	9
admin3	Trinka AI	ai_tool	9
admin3	Creatify	ai_tool	9
admin3	Profile Picture AI	ai_tool	9
admin3	One Click Human	ai_tool	9
admin3	Im Visier – Verbrecherjagd in Berlin und Brandenburg	podcast	9
admin3	Benx	podcast	9
admin3	Grammarly	ai_tool	9
admin3	Gysi gegen Guttenberg – Der Deutschland Podcast	podcast	9
admin3	Haschimitenfürst – Der Bobcast	podcast	9
admin3	OutGrow	ai_tool	9
admin3	Puppetry	ai_tool	9
admin3	Was jetzt?	podcast	9
admin3	VideoGen	ai_tool	9
admin3	Kalk & Welk - Die fabelhaften Boomer Boys	podcast	9
admin3	HEIGHTS AI	ai_tool	9
admin3	Writesonic	ai_tool	9
admin3	Kaulitz Hills - Senf aus Hollywood	podcast	9
admin3	deepseek	ai_tool	9
admin3	Magic Hour	ai_tool	9
admin3	InLinks	ai_tool	9
admin3	Artflow	ai_tool	9
admin3	HeyGen	ai_tool	9
admin3	Ehrenwort - Ein Podcast über Skandale	podcast	9
admin3	Riku	ai_tool	9
admin3	Mixo	ai_tool	9
admin3	Was bisher geschah - Geschichtspodcast	podcast	9
admin3	EinfachGustaf | Dein Minecraft Kanal!	podcast	9
admin3	Pika Labs	ai_tool	9
admin3	Pferdeschwänze	podcast	8
admin3	Poised	ai_tool	4
admin3	ChatGPT	ai_tool	9
admin3	Notion AI	ai_tool	9
admin3	WellSaid Labs	ai_tool	9
admin3	happy, holy & confident® Dein Podcast fürs Herz und den Verstand	podcast	9
admin3	Super	ai_tool	9
admin3	GPT zero	ai_tool	9
admin3	Murf	ai_tool	9
admin3	Google Workspace	ai_tool	9
admin3	REimagineHome	ai_tool	9
admin3	Zyro	ai_tool	9
admin3	Einschlafen mit Hogwarts	podcast	9
admin3	Nie & Immer	podcast	9
admin3	Vecteezy AI	ai_tool	9
admin3	perplexity	ai_tool	9
admin3	CodiumAI	ai_tool	9
admin3	WordTune	ai_tool	9
admin3	HypeFury	ai_tool	9
admin3	Stimmen im Kopf - True-Crime / Mystery Podcast	podcast	9
admin3	n8n	ai_tool	9
admin3	Monkeebrain	ai_tool	9
admin3	Chivvy	ai_tool	9
admin3	Einschlafen mit Wikipedia	podcast	9
admin3	GoCharlie	ai_tool	9
admin3	Serienkiller - Mörder und ihre Geschichten	podcast	9
admin3	Munch	ai_tool	9
admin3	Shortspilot	ai_tool	9
admin3	GPTinf	ai_tool	9
admin3	Der Sophie Passmann Podcast	podcast	9
admin3	Audo	ai_tool	9
admin3	Puppies and Crime	podcast	9
admin3	Bodt	ai_tool	9
admin3	Luna	ai_tool	9
admin3	Dark Matters – Geheimnisse der Geheimdienste	podcast	9
admin3	Geschichten aus der Geschichte	podcast	9
admin3	Procys	ai_tool	9
admin3	Hexofy	ai_tool	9
admin3	Easy Peasy	ai_tool	9
admin3	Coursebox AI	ai_tool	9
admin3	Blaze	ai_tool	9
admin3	Vista Social	ai_tool	9
admin3	Rask	ai_tool	9
admin3	Make	ai_tool	9
admin3	ZEIT WISSEN. Woher weißt Du das?	podcast	9
admin3	Das Wissen | SWR	podcast	9
admin3	Cuppa	ai_tool	9
admin3	CheckPod - Der Podcast mit Checker Tobi	podcast	9
admin3	blackboxAI	ai_tool	9
admin3	Syllaby	ai_tool	9
admin3	Nara	ai_tool	9
admin3	GEMINI	ai_tool	9
admin3	Winston ai	ai_tool	9
admin3	Alliteration Am Arsch	podcast	9
admin3	Spikes Studio	ai_tool	9
admin3	15 Minuten. Der tagesschau-Podcast am Morgen	podcast	9
admin3	Toasty AI	ai_tool	9
admin3	synthesia	ai_tool	9
admin3	FATHOM	ai_tool	9
admin3	Neural Love	ai_tool	9
admin3	Dante	ai_tool	9
admin3	ProfilePro	ai_tool	9
admin3	GPTkit	ai_tool	9
admin3	Submagic	ai_tool	9
admin3	Hansei	ai_tool	9
admin3	Tailwind Ghostwriter	ai_tool	9
admin3	Dick & Doof	podcast	9
admin3	QUILTBOT	ai_tool	9
admin3	Youtify	podcast	9
admin3	Speak AI	ai_tool	9
admin3	CustomGPT	ai_tool	9
admin3	Reeze	podcast	9
admin3	Viralkit	ai_tool	9
admin3	Runway	ai_tool	9
admin3	Quickads	ai_tool	9
admin3	laserluca	podcast	9
admin3	Squirrly SEO	ai_tool	9
admin3	SiteSpeakAI	ai_tool	9
admin3	Neuraltext	ai_tool	9
admin3	chatgpt16	ai_tool	9
admin3	NeuralNewsletters	ai_tool	9
admin3	FUSSBALL MML	podcast	9
admin3	Sanebox	ai_tool	9
admin3	Ghost Writer	ai_tool	9
admin3	Quizgecko	ai_tool	9
admin3	10Web	ai_tool	9
admin3	RepublicLabs	ai_tool	9
admin3	Tabnine	ai_tool	9
admin3	AI Lawyer	ai_tool	9
admin3	Gummysearch	ai_tool	9
admin3	Eyes in the Dark	podcast	9
admin3	chatgpt40	ai_tool	9
admin3	GetGenie	ai_tool	9
admin3	Wissen mit Johnny	podcast	9
admin3	Ulle & Rick	podcast	9
admin3	Sonic Link	ai_tool	9
admin3	Formula Bot	ai_tool	9
admin3	Geld für die Welt	podcast	9
admin3	Letterly	ai_tool	9
admin3	TikTok	ai_tool	9
admin3	RankIQ	ai_tool	9
admin3	Offline + Ehrlich	podcast	9
admin3	TRUE LOVE	podcast	9
admin3	Fellow	ai_tool	9
admin3	Jupitrr	ai_tool	9
admin3	HookSounds AI Studio	ai_tool	9
admin3	dudes.	podcast	9
admin3	Hazel Thomas Hörerlebnis	podcast	9
admin3	Dashworks	ai_tool	9
admin3	Lunacy by Icons8	ai_tool	9
admin3	Picsart	ai_tool	9
admin3	PDF ai	ai_tool	9
admin3	Research Studio	ai_tool	9
admin3	Codeleaks	ai_tool	9
admin3	tl;dv	ai_tool	9
admin3	Decktopus	ai_tool	9
admin3	Hypernatural	ai_tool	9
admin3	The Joe Rogan Experience	podcast	9
admin3	Typeshare	ai_tool	9
admin3	CoachVox	ai_tool	9
admin3	Reelio	ai_tool	9
admin3	Inworld	ai_tool	9
admin3	Der Tag	podcast	9
admin3	Profile Pic Maker	ai_tool	9
admin3	Verbrechen der Vergangenheit	podcast	9
admin3	CALCIO BERLIN	podcast	9
admin3	Augstein & Blome	podcast	9
admin3	Writers brew	ai_tool	9
admin3	Paula Lieben Lernen	podcast	9
admin3	Filmora	ai_tool	9
admin3	Aha! Zehn Minuten Alltags-Wissen	podcast	9
admin3	Politik mit Anne Will	podcast	9
admin3	Framer	ai_tool	9
admin3	Surfer SEO	ai_tool	9
admin3	Baywatch Berlin	podcast	9
admin3	Adobe Podcast	ai_tool	9
admin3	PietCast	podcast	9
admin3	Recast	ai_tool	9
admin3	BatchTable	ai_tool	9
admin3	Die Lage	podcast	9
admin3	Media.io	ai_tool	9
admin3	Quarks Science Cops	podcast	9
admin3	Das Politikteil	podcast	9
admin3	Besser als Sex	podcast	9
admin3	Audio writer	ai_tool	9
admin3	Rytr	ai_tool	9
admin3	aiCarousels	ai_tool	9
admin3	Simple Phones	ai_tool	9
admin3	The Pioneer Briefing	podcast	9
admin3	chatgpt43	ai_tool	9
admin3	AI Detector Pro	ai_tool	9
admin3	Feel The News	podcast	9
admin3	Guidejar	ai_tool	9
admin3	Tugan	ai_tool	9
admin3	Hobbylos	podcast	9
admin3	Edeltalk - mit Dominik & Kevin	podcast	9
admin3	Johannesmlz	podcast	9
admin3	Harpa AI	ai_tool	9
admin3	Hexowatch	ai_tool	9
admin3	Shuffll	ai_tool	9
admin3	F.A.Z. Frühdenker - Die Nachrichten am Morgen	podcast	9
admin3	GAMMA.AI	ai_tool	9
admin3	Skandal, Skandal	podcast	9
admin3	Ohne Bewährung - True Crime von hier	podcast	9
admin3	QR Galaxy	ai_tool	9
admin3	Jasper	ai_tool	9
admin3	SE Ranking	ai_tool	9
admin3	stealth writer	ai_tool	9
admin3	Table Today	podcast	9
admin3	HIX Bypass	ai_tool	9
admin3	Alle meine Eltern – Der Real Talk mit Evelyn Weigert	podcast	9
admin3	PDF Flex	ai_tool	9
admin3	Netus AI	ai_tool	9
admin3	Gling	ai_tool	9
admin3	Simplicissimus	podcast	9
admin3	Chance AI	ai_tool	9
admin3	Adalo	ai_tool	9
admin3	Future Desk	ai_tool	9
admin3	Raum & Zeit	podcast	9
admin3	Elementor AI	ai_tool	9
admin3	Deblank	ai_tool	9
admin3	Looka	ai_tool	9
admin3	CRIME TIME	podcast	9
admin3	PodStash	ai_tool	9
admin3	Aragon	ai_tool	9
admin3	Reflect	ai_tool	9
admin3	Wahre Verbrechen - True Crime Podcast	podcast	9
admin3	Adobe Express	ai_tool	9
admin3	InterviewSpark	ai_tool	9
admin3	Monica	ai_tool	9
admin3	cluade	ai_tool	9
admin3	Mit den Waffeln einer Frau	podcast	9
admin3	Katteb	ai_tool	9
admin3	WindsorAI	ai_tool	9
admin3	UNFASSBAR – ein Simplicissimus Podcast	podcast	9
admin3	Plagiashield	ai_tool	9
admin3	Mensch! Promi Skandale und ihre Geschichte	podcast	9
admin3	Tatort Deutschland – Wahre Kriminalfälle und Verbrechen	podcast	9
admin3	Papaplatte	podcast	9
admin3	Betreutes Fühlen	podcast	9
admin3	Tripo AI	ai_tool	9
admin3	Was tun, Herr General? - Der Podcast zum Ukraine-Krieg	podcast	9
admin3	Eloise AI	ai_tool	9
admin3	Todoist AI Assistant	ai_tool	9
admin3	Biread	ai_tool	9
admin3	Bizway	ai_tool	9
admin3	PromptLayer	ai_tool	9
admin3	Safuri	ai_tool	9
admin3	MindPal	ai_tool	9
admin3	Kling AI	ai_tool	9
admin3	ClipBuddy	ai_tool	9
admin3	BIXBY	ai_tool	9
admin3	Freeflo	ai_tool	9
admin3	Gemini	ai_tool	9
admin3	Tweet Hunter	ai_tool	9
admin3	Alles gesagt?	podcast	9
admin3	Coda AI	ai_tool	9
admin3	Die Deutschen Podcast	podcast	9
admin3	Die Nervigen	podcast	9
admin3	Lexica	ai_tool	9
admin3	iApply	ai_tool	9
admin3	Schwarze Akte - True Crime	podcast	9
admin3	Luma AI	ai_tool	9
admin3	Skybox Lab	ai_tool	9
admin3	Typefully	ai_tool	9
admin3	KIVA	ai_tool	9
admin3	too many tabs – der Podcast	podcast	9
admin3	Wie geht's? mit Robin Gosens	podcast	9
admin3	Insolito - Nur ein weiterer TrueCrime-Podcast	podcast	9
admin3	Bayern 3 True Crime - Schuld und Unschuld	podcast	9
admin3	Fest & Flauschig	podcast	9
admin3	Castmagic	ai_tool	9
admin3	Brand24	ai_tool	9
admin3	AutoShorts	ai_tool	9
admin3	HypeAuditor	ai_tool	9
admin3	Quarks Daily	podcast	9
admin3	Lyro by Tidio	ai_tool	9
admin3	Gemischtes Hack	podcast	9
admin3	50+2 - Der Fussballpodcast mit Nico & Niklas	podcast	9
admin3	Devi AI	ai_tool	9
admin3	Exolyt	ai_tool	9
admin3	JoggAI	ai_tool	9
admin3	Vidgen	ai_tool	9
admin3	Wissen Weekly	podcast	9
admin3	Scribe	ai_tool	9
admin3	Qodex	ai_tool	9
admin3	Craiyon	ai_tool	9
admin3	0630 - der News-Podcast	podcast	9
admin3	Descript	ai_tool	9
admin3	Endless VN	ai_tool	9
admin3	ElevenLabs	ai_tool	9
admin3	DAS PODCAST UFO	podcast	9
admin3	Brawler's World	podcast	9
admin3	Deciphr	ai_tool	9
admin3	Prompt Hunt	ai_tool	9
admin3	Manatal	ai_tool	9
admin3	Hexomatic	ai_tool	9
admin3	CopySpace	ai_tool	9
admin3	Gefühlte Fakten	podcast	9
admin3	Linguix	ai_tool	9
admin3	DigitalFirst	ai_tool	9
admin3	Photosonic	ai_tool	9
admin3	Lalal AI	ai_tool	9
admin3	Describely	ai_tool	9
admin3	Semrush outline builder	ai_tool	9
admin3	F.A.Z. Podcast für Deutschland	podcast	9
admin3	SKYNET	ai_tool	9
admin3	notebooklm	ai_tool	9
admin3	Runway ML	ai_tool	9
admin3	Im Bett mit Anna-Maria und Anis Ferchichi - Der Bushido Podcast	podcast	9
admin3	Auf den Punkt	podcast	9
admin3	Frame	ai_tool	9
admin3	guidde	ai_tool	9
admin3	AIPRM	ai_tool	9
admin3	DRINNIES	podcast	9
admin3	Clockk	ai_tool	9
admin3	Hiver	ai_tool	9
admin3	Copilot	ai_tool	9
admin3	Girls Girls 	podcast	9
admin3	Fathom	ai_tool	9
admin3	ProPhotos	ai_tool	9
admin3	THE BIG HEAD JUAN SHOW (NSFW)	podcast	9
admin3	Cliptalk	ai_tool	9
admin3	Handelsblatt Today - Der Finanzpodcast mit News zu Börse, Aktien und Geldanlage	podcast	9
admin3	Keyword Insights	ai_tool	9
admin3	Nekton AI	ai_tool	9
admin3	Landr	ai_tool	9
admin3	tinyEinstein	ai_tool	9
admin3	GhostContent	ai_tool	9
admin3	Email Magic	ai_tool	9
admin3	TeacherMatic	ai_tool	9
admin3	Glasp	ai_tool	9
admin3	Eine Stunde History - Deutschlandfunk Nova	podcast	9
admin3	NOTION AI	ai_tool	9
admin3	Einfach mal Luppen	podcast	9
admin3	RONZHEIMER.	podcast	9
admin3	life is felicious	podcast	9
admin3	Hotel Matze	podcast	9
admin3	AI Room Planner	ai_tool	9
admin3	Hubspot AI	ai_tool	9
admin3	NovelAI	ai_tool	9
admin3	Elai	ai_tool	9
admin3	Olympia	ai_tool	9
admin3	Lage der Nation - der Politik-Podcast aus Berlin	podcast	9
admin3	Claude	ai_tool	9
admin3	Vidalgo	ai_tool	9
admin3	Speechify	ai_tool	9
admin3	DimeADozen	ai_tool	9
admin3	Synthesia	ai_tool	9
admin3	Elephas	ai_tool	9
admin3	chatgpt2	ai_tool	9
admin3	User Evaluation	ai_tool	9
admin3	LearnWorlds AI	ai_tool	9
admin3	Catbird	ai_tool	9
admin3	Character AI	ai_tool	9
admin3	ViscaTabak - Der Fußball Podcast	podcast	9
admin3	Äffchen mit Käffchen	podcast	9
admin3	Tim Gabel Podcast	podcast	9
admin3	Freundschaft Minus	podcast	9
admin3	Riverside Audio Transcription	ai_tool	9
admin3	Motiva	ai_tool	9
admin3	FOOTBALL BROMANCE	podcast	9
admin3	KeywordsPeopleUse	ai_tool	9
admin3	Taskade	ai_tool	9
admin3	Klap	ai_tool	9
admin3	Recast Studio	ai_tool	9
admin3	Icon	ai_tool	9
admin3	Bannerbear	ai_tool	9
admin3	AdCreative.ai	ai_tool	9
admin3	Hoss & Hopf	podcast	9
admin3	LensGo	ai_tool	9
admin3	Was die Woche wichtig war – Der funk-Podcast	podcast	9
admin3	Visme AI	ai_tool	9
admin3	{ungeskriptet} - Gespräche, die dich weiter bringen	podcast	9
admin3	Github Autopilot	ai_tool	9
admin3	Remove BG	ai_tool	9
admin3	Voluum	ai_tool	9
admin3	Wonderplan	ai_tool	9
admin3	CourseAI	ai_tool	9
admin3	InsightBaseAI	ai_tool	9
admin3	Process AI	ai_tool	9
admin3	Wondershare VirtuLook	ai_tool	9
admin3	Liner	ai_tool	9
admin3	Play.ht	ai_tool	9
admin3	Firewall: Jedes System hat eine Schwachstelle	podcast	9
admin3	chatgpt5	ai_tool	9
admin3	QUILTBOT 2.0	ai_tool	9
admin3	SUPERMACHINE	ai_tool	9
admin3	The Diary Of A CEO with Steven Bartlett	podcast	9
admin3	HeadshotPro	ai_tool	9
admin3	Wavel AI	ai_tool	9
admin3	VideoIdeas.ai	ai_tool	9
admin3	G Spot mit Stefanie Giesinger	podcast	9
admin3	Jasper Ai	ai_tool	9
admin3	RenderLion	ai_tool	9
admin3	Mubert	ai_tool	9
admin3	Validly	ai_tool	9
admin3	AIVA	ai_tool	9
admin3	Theresa Kirchner	podcast	9
admin3	Kafkai	ai_tool	9
admin3	Followr	ai_tool	9
admin3	Spitzengespräch	podcast	9
admin3	5 Minuten Harry Podcast von Coldmirror	podcast	9
admin3	Sekten & Kulte - Im Namen des Bösen	podcast	9
admin3	Die Nachrichten	podcast	9
admin3	OK, America?	podcast	9
admin3	tagesschau in 100 Sekunden (Audio-Podcast)	podcast	9
admin3	MidJourney	ai_tool	9
admin3	Galaxy AI	ai_tool	9
admin3	AimReply	ai_tool	9
admin3	Compose AI	ai_tool	9
admin3	GetResponse	ai_tool	9
admin3	Bratwurst und Baklava - mit Özcan Cosar und Bastian Bielendorfer	podcast	9
admin3	Snoooz	ai_tool	9
admin3	TurnCage	ai_tool	9
admin3	stern Crime - Spurensuche	podcast	9
admin3	Bertha AI	ai_tool	9
admin3	Brain FM	ai_tool	9
admin3	MutterSöhnchen	podcast	9
admin3	TubeBuddy	ai_tool	9
admin3	Artsmart AI	ai_tool	9
admin3	Zwei Vermengte	podcast	9
admin3	Creatr	ai_tool	9
admin3	Machtwechsel – mit Dagmar Rosenfeld und Robin Alexander	podcast	9
admin3	DescriptionWise	ai_tool	9
admin3	Magic Studio	ai_tool	9
admin3	Luna AI	ai_tool	9
admin3	FYLM.ai	ai_tool	9
admin3	Soundverse	ai_tool	9
admin3	StealthGPT	ai_tool	9
admin3	Koala AI	ai_tool	9
admin3	Midjourney	ai_tool	9
admin3	Der Politikpodcast	podcast	9
admin3	Hotpot	ai_tool	9
admin3	Hify	ai_tool	9
admin3	Leadpages AI Engine	ai_tool	9
admin3	BetterPic	ai_tool	9
admin3	Caspar AI	ai_tool	9
admin3	MimicPC	ai_tool	9
admin3	LANZ & PRECHT	podcast	9
admin3	Wondershare Virbo	ai_tool	9
admin3	Make Economy Great Again	podcast	9
admin3	tagesschau (Audio-Podcast)	podcast	9
admin3	AISEO Art	ai_tool	9
admin3	Replit	ai_tool	9
admin3	YourMove AI	ai_tool	9
admin3	Midjourney Prompt Generator	ai_tool	9
admin3	Kurt Krömer - Feelings	podcast	9
admin3	Leonardo	ai_tool	9
admin3	Ziemlich beste Fremde	podcast	9
admin3	Down Set Talk! - Der NFL Podcast von RTL	podcast	9
admin3	Pixlr	ai_tool	9
admin3	Postwise	ai_tool	9
admin3	RepliQ	ai_tool	9
admin3	HoppyCopy	ai_tool	9
admin3	ProWritingAid	ai_tool	9
admin3	Monic AI	ai_tool	9
admin3	Handelsblatt Crime - spannende Streitfälle der deutschen Wirtschaft	podcast	9
admin3	Deutschland3000 - 'ne gute Stunde mit Eva Schulz	podcast	9
admin3	copyAI	ai_tool	9
admin3	Lovo	ai_tool	9
admin3	Clare on Air	podcast	8
admin3	El Margo	podcast	8
admin3	PLOT HOUSE	podcast	8
admin3	CodeDesign	ai_tool	8
admin3	Rick Azas	podcast	8
admin3	Yera	ai_tool	8
admin3	Flowrite	ai_tool	8
admin3	Niemand muss ein Promi sein - Deutschlands Nr. 1 Gossip-Podcast!	podcast	9
admin3	Die Drei Rabauken	podcast	9
admin3	Das wahre Leben – Der NACHTCAFÉ Podcast	podcast	9
admin3	Weird Crimes	podcast	9
admin3	Adoptivbrüder – mit Hannes & Jeremy	podcast	9
admin3	tomatolix	podcast	9
admin3	Alman Arabica	podcast	9
admin3	Aura AI	ai_tool	8
admin3	Talk ohne Gast	podcast	8
admin3	ContentStudio AI	ai_tool	8
admin3	Secta Labs	ai_tool	8
admin3	Zigpoll	ai_tool	8
admin3	AI Voice Detector	ai_tool	8
admin3	Streitkräfte und Strategien	podcast	8
admin3	Keine Echten Männer	podcast	8
admin3	Photoshop Generative AI	ai_tool	8
admin3	Lewinray 	podcast	8
admin3	Hotreach AI	ai_tool	8
admin3	AISEO	ai_tool	8
admin3	Altered	ai_tool	8
admin3	Podium	ai_tool	8
admin3	Visily	ai_tool	8
admin3	Kudra	ai_tool	8
admin3	Julia Leischik: Spurlos	podcast	8
admin3	WebWave	ai_tool	8
admin3	Browse AI	ai_tool	8
admin3	Nanonets	ai_tool	8
admin3	Boomy	ai_tool	8
admin3	Vidnoz	ai_tool	8
admin3	AnimeGenius	ai_tool	8
admin3	BeforeSunset AI	ai_tool	8
admin3	OpusClip	ai_tool	8
admin3	Cheatlayer	ai_tool	8
admin3	Apify	ai_tool	8
admin3	Stammplatz – Fußball News täglich	podcast	8
admin3	RankPress	ai_tool	8
admin3	SudoWrite	ai_tool	8
admin3	BLIND DATING 💔 mit Ceddo	podcast	8
admin3	Marketmuse	ai_tool	8
admin3	Quillbot	ai_tool	8
admin3	OHNE AKTIEN WIRD SCHWER - Tägliche Börsen-News	podcast	8
admin3	Eclipse AI	ai_tool	8
admin3	Steve AI	ai_tool	8
admin3	Originality AI	ai_tool	8
admin3	Kampf der Unternehmen	podcast	8
admin3	aiApply	ai_tool	8
admin3	SocialBee	ai_tool	8
admin3	Nachmittagsjause mit Ankat	podcast	8
admin3	Feathery	ai_tool	8
admin3	Alles auf Aktien – Die täglichen Finanzen-News	podcast	8
admin3	Mord am Mittwoch - True Crime	podcast	8
admin3	Stahl aber herzlich – Der Psychotherapie-Podcast mit Stefanie Stahl	podcast	9
admin3	Paarspektiven	podcast	8
admin3	Pictory	ai_tool	8
admin3	Science Crimes	podcast	8
admin3	Podcastle	ai_tool	8
admin3	DALL.E	ai_tool	8
admin3	Fireflies	ai_tool	8
admin3	Lovable	ai_tool	8
admin3	Lästerschwestern	podcast	8
admin3	MosaChat-AI	ai_tool	8
admin3	MORD AUF EX	podcast	8
admin3	ChatGPT Writer	ai_tool	8
admin3	Finanzfluss Podcast	podcast	8
admin3	Kaffee mit Zitrone 	podcast	8
admin3	Logo AI	ai_tool	8
admin3	TweetMonk	ai_tool	8
admin3	ContentShake	ai_tool	8
admin3	ARD Crime Time – Der True Crime Podcast	podcast	8
admin3	Adobe Sensei	ai_tool	8
admin3	Moonbeam	ai_tool	8
admin3	Referral Factory	ai_tool	8
admin3	Gnu	podcast	8
admin3	Henke's Corner	podcast	8
admin3	Macht und Millionen – Der Podcast über echte Wirtschaftskrimis	podcast	8
admin3	Typing Mind	ai_tool	7
admin3	Alphana	ai_tool	7
admin3	Black Friday Deals	ai_tool	8
admin3	Clickup	ai_tool	8
admin3	Recut	ai_tool	8
admin3	Soundraw	ai_tool	8
admin3	PPSPY	ai_tool	8
admin3	Playground AI	ai_tool	8
admin3	Zeigler & Köster - Der Fußball-Podcast von 11FREUNDE	podcast	8
admin3	PromptPal	ai_tool	8
admin3	DeepL	ai_tool	8
admin3	Chaindesk	ai_tool	8
admin3	chatgpt3	ai_tool	8
admin3	Weltspiegel Podcast	podcast	8
admin3	Lately	ai_tool	8
admin3	grokai	ai_tool	8
admin3	My GPT Wizard	ai_tool	8
admin3	Beste Freundinnen	podcast	8
admin3	Cleanvoice	ai_tool	8
admin3	Sternstunde Philosophie	podcast	8
admin3	OMR Podcast	podcast	8
admin3	Hexometer	ai_tool	8
admin3	VEED	ai_tool	8
admin3	Sharp API	ai_tool	8
admin3	TeamSmart AI	ai_tool	8
admin3	Letterdrop	ai_tool	8
admin3	GROK	ai_tool	8
admin3	His2Go - Geschichte Podcast	podcast	8
admin3	Frase	ai_tool	8
admin3	Sicherheitshalber	podcast	8
admin3	vnoyd	ai_tool	8
admin3	Yaara	ai_tool	8
admin3	Soofy	ai_tool	8
admin3	Mordlust	podcast	8
admin3	Bubble AI	ai_tool	8
admin3	AgentGPT	ai_tool	8
admin3	ChatPlayground	ai_tool	8
admin3	POLITICO Berlin Playbook	podcast	8
admin3	Waxwing	ai_tool	8
admin3	Phrasenmäher - Fußball Talk mit Henning Feindt und André Albers	podcast	8
admin3	Numerous AI	ai_tool	8
\.
