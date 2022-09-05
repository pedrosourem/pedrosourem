-- The column "favorite_food" in the details dataset contains all different preys of the aliens. 
-- This code will add one level of detail by categorizing the preys into their animal classes (mammal, bird, reptile, insects,
-- fish, arachnida, marine invertebrade and amphibian).
CREATE TABLE diet 
AS (
	SELECT detail_id, 
		   prey_name,
		   CASE WHEN (prey_name LIKE '%kangaroo%'
				OR (prey_name LIKE '%rat' AND prey_name NOT LIKE '%kangaroo%') 
				OR prey_name LIKE '%wallaby%' OR prey_name LIKE '%impala%'
				OR prey_name LIKE '%lemur%' OR prey_name LIKE '%quoll%'
				OR prey_name LIKE '%phascogale%' OR prey_name LIKE '%otter%'
				OR prey_name LIKE '%fox%' OR prey_name LIKE '%squirrel%'
				OR prey_name LIKE '%lemming%' OR prey_name LIKE '%bandicoot%'
				OR prey_name LIKE '%echidna%' OR prey_name LIKE '%bear%'
				OR prey_name LIKE '%possum%' OR prey_name LIKE '%whale%'
				OR prey_name LIKE '%sheep%' OR prey_name LIKE '%bat%'
				OR prey_name LIKE '%rhinoceros%' OR prey_name LIKE '%lion%'
				OR prey_name LIKE '%wolf%' OR prey_name LIKE '%deer%'
				OR prey_name LIKE '%antelope%' OR prey_name LIKE '%buffalo%'
				OR prey_name LIKE '%cat%' OR prey_name LIKE '%dog%'
				OR prey_name LIKE '%dolphin%' OR prey_name LIKE '%chipmunk%'
				OR prey_name LIKE '%zorro%' OR prey_name LIKE '%lynx%'
				OR prey_name LIKE '%capuchin%' OR prey_name LIKE '%monkey%'
				OR prey_name LIKE '%dassie%' OR prey_name LIKE '%kudu%'
				OR prey_name LIKE '%hartebeest%' OR prey_name LIKE '%ringtail%'
				OR prey_name LIKE '%pademelon%' OR prey_name LIKE '%colobus%'
				OR prey_name LIKE '%armadillo%' OR prey_name LIKE '%mongoose%'
				OR prey_name LIKE '%grison%' OR prey_name LIKE '%hare%'
				OR prey_name LIKE '%rabbit%' OR prey_name LIKE '%bettong%'
				OR prey_name LIKE '%hyena%' OR prey_name LIKE '%brocket%'
				OR prey_name LIKE '%marmot%' OR prey_name LIKE '%wombat%'
				OR prey_name LIKE '%sloth%' OR prey_name LIKE '%gnu%'
				OR prey_name LIKE '%goat%' OR prey_name LIKE '%meerkat%'
				OR prey_name LIKE '%guerza%' OR prey_name LIKE '%oryx%'
				OR prey_name LIKE '%macaque%' OR prey_name LIKE '%genet%'
				OR prey_name LIKE '%skunk%' OR prey_name LIKE '%anteater%'
				OR prey_name LIKE '%baboon%' OR prey_name LIKE '%glider%'
				OR prey_name LIKE '%chital%' OR prey_name LIKE '%oribi%'
				OR prey_name LIKE '%puma%' OR prey_name LIKE '%tsessebe%'
				OR prey_name LIKE '%onager%' OR prey_name LIKE '%eland%'  
				OR prey_name LIKE '%peccary%' OR prey_name LIKE '%shrew%'
				OR prey_name LIKE '%seal%' OR prey_name LIKE '%coyote%'
				OR prey_name LIKE '%cheetah%' OR prey_name LIKE '%rat%'
				OR prey_name LIKE '%zebra%' OR prey_name LIKE '%cougar%'
				OR prey_name LIKE '%orca%' OR prey_name LIKE '%leopard%'
				OR prey_name LIKE '%langur%' OR prey_name LIKE '%jackal%'
				OR prey_name LIKE '%hedgehog%' OR prey_name LIKE '%wildebeest%'
				OR prey_name LIKE '%koala%' OR prey_name LIKE '%coatimundi%'
				OR prey_name LIKE '%adouri%' OR prey_name LIKE '%moose%'
				OR prey_name LIKE '%porcupine%' OR prey_name LIKE '%gaur%'
				OR prey_name LIKE '%agouti%' OR prey_name LIKE '%badger%'
				OR prey_name LIKE '%pronghorn%' OR prey_name LIKE '%beaver%'
				OR prey_name LIKE '%wambenger%' OR prey_name LIKE '%argalis%'
				OR prey_name LIKE '%manatee%' OR prey_name LIKE '%serval%'
				OR prey_name LIKE '%gopher%' OR prey_name LIKE '%wallaroo%'
				OR prey_name LIKE '%civet%' OR prey_name LIKE '%fisher%'
				OR prey_name LIKE '%llama%' OR prey_name LIKE '%tayra%'
				OR prey_name LIKE '%raccoon%' OR prey_name LIKE '%cuis%'
				OR prey_name LIKE '%tasmanian%' OR prey_name LIKE '%duiker%'
				OR prey_name LIKE '%ferret%' OR prey_name LIKE '%klipspringer%'
				OR prey_name LIKE '%alpaca%' OR prey_name LIKE '%hyrax%'
				OR prey_name LIKE '%wild ass%' OR prey_name LIKE '%tenrec%'
				OR prey_name LIKE '%caribou%' OR prey_name LIKE '%groundhog%'
				OR prey_name LIKE '%cow%' OR prey_name LIKE 'mara'
				OR prey_name LIKE '%dik%' OR prey_name LIKE '%dunnart%'
				OR prey_name LIKE '%sifaka%' OR prey_name LIKE '%tamandua%'
				OR prey_name LIKE '%nyala%' OR prey_name LIKE '%antechinus%'
				OR prey_name LIKE '%vicuna%' OR prey_name LIKE '%sambar%'
				OR prey_name LIKE '%elephant%' OR prey_name LIKE '%lechwe%'
				OR prey_name LIKE '%puku%' OR prey_name LIKE '%mouse'
				OR prey_name LIKE '%bushbaby%' OR prey_name LIKE '%elk%'
				OR prey_name LIKE '%ibex%' OR prey_name LIKE '%caracal%'
				OR prey_name LIKE '%urial%' OR prey_name LIKE '%chimpanzee%'
				OR prey_name LIKE '%gazer%' OR prey_name LIKE '%warthog%'
				OR prey_name LIKE '%bison%' OR prey_name LIKE '%kingfisher%'
				OR prey_name LIKE '%loris%' OR prey_name LIKE '%buck'
				OR prey_name LIKE '%kinkajou%' OR prey_name LIKE '%zorilla%'
				OR prey_name LIKE '%devil%' OR prey_name LIKE '%wapiti%'
				OR prey_name LIKE '%ocelot%' OR prey_name LIKE '%camel%'
				OR prey_name LIKE '%gorilla%' OR prey_name LIKE '%paradoxure%'
				OR prey_name LIKE '%gazelle%' OR prey_name LIKE '%bok'
				OR prey_name LIKE '%gerbil%' OR prey_name LIKE '%dingo%'
				OR prey_name LIKE '%capybara%' OR prey_name LIKE 'paca'
				OR prey_name LIKE '%tapir%' OR prey_name LIKE '%yak%'
				OR prey_name LIKE '%margay%' OR prey_name LIKE '%tiger%'
				OR prey_name LIKE '%gerenuk%' OR prey_name LIKE '%giraffe%'
				OR prey_name LIKE '%platypus%' OR prey_name LIKE '%bushpig%'
				OR prey_name LIKE 'ox' OR prey_name LIKE '%huron%'
				OR prey_name LIKE '%potoroo%' OR prey_name LIKE '%mouflon%'
				OR prey_name LIKE 'ass' OR prey_name LIKE '%marten%'
				OR prey_name LIKE '%hippopotamus%' OR prey_name LIKE '%kongoni%'
				OR prey_name LIKE '%guanaco%' OR prey_name LIKE '%jaguar%'
				OR prey_name LIKE '%nilgai%' OR prey_name LIKE '%woylie%'
				OR prey_name LIKE '%musk ox%' OR prey_name LIKE '%topi%') THEN 'mammal' 
				
				WHEN (prey_name LIKE '%snake%' OR prey_name LIKE '%caiman%'
				OR prey_name LIKE '%crocodile%'OR prey_name LIKE '%gecko%'
				OR prey_name LIKE '%lizard%' OR prey_name LIKE '%tortoise%'
				OR (prey_name LIKE '%dragon%' AND prey_name NOT LIKE '%dragonfly%')
				OR prey_name LIKE '%moccasin%' OR prey_name LIKE '%cobra%'
				OR prey_name LIKE '%iguana%' OR prey_name LIKE '%anaconda%'
				OR prey_name LIKE '%monitor%' OR prey_name LIKE '%boa%'
				OR prey_name LIKE '%sungazer%' OR prey_name LIKE '%legaan%'
				OR prey_name LIKE '%sidewinder%' OR prey_name LIKE '%viper%'
				OR prey_name LIKE '%constrictor%' OR prey_name LIKE '%python%'
				OR prey_name LIKE '%alligator%' OR prey_name LIKE '%chuckwalla%'
				OR prey_name LIKE '%cottonmouth%' OR prey_name LIKE '%racer%'
				OR prey_name LIKE '%turtle%' OR prey_name LIKE '%skink%'
				OR prey_name LIKE '%chameleon%' OR prey_name LIKE '%monster%') THEN 'reptile'
					  
				WHEN (prey_name LIKE '%falcon%' OR prey_name LIKE '%penguin%'
				  OR prey_name LIKE '%crane%' OR (prey_name LIKE '%owl%' AND prey_name NOT LIKE '%fowl%')
				  OR prey_name LIKE '%macaw%' OR prey_name LIKE '%darter%'
				  OR prey_name LIKE '%gonolek%'OR prey_name LIKE '%bee-eater%'
				  OR prey_name LIKE '%dove%' OR prey_name LIKE '%grouse%'
				  OR prey_name LIKE '%goose%' OR prey_name LIKE '%duck%'
				  OR prey_name LIKE '%eagle%' OR prey_name LIKE '%francolin%'
				  OR prey_name LIKE '%crow%' OR prey_name LIKE '%nutcracker%'
				  OR (prey_name LIKE '%bird%' AND prey_name NOT LIKE '%tarantula')
				  OR prey_name LIKE '%pelican%' OR prey_name LIKE '%rhea%'
				  OR prey_name LIKE '%albatross%' OR prey_name LIKE '%albatross%'
				  OR prey_name LIKE '%oystercatcher%' OR prey_name LIKE '%wagtail%'
				  OR prey_name LIKE '%raven%' OR prey_name LIKE '%heron%' 
				  OR prey_name LIKE '%kiskadee%' OR prey_name LIKE '%phalarope%'
				  OR prey_name LIKE '%barbet%' OR prey_name LIKE '%lark%'
				  OR prey_name LIKE '%currasow%' OR prey_name LIKE '%hoopoe%' 
				  OR prey_name LIKE '%hawk%' OR prey_name LIKE '%vulture%'
				  OR prey_name LIKE '%jacana%' OR prey_name LIKE '%flamingo%'
				  OR prey_name LIKE '%hornbill%' OR prey_name LIKE '%gull%'
				  OR prey_name LIKE '%cormorant%' OR prey_name LIKE '%barbet%'
				  OR prey_name LIKE '%crake%' OR prey_name LIKE '%teal%'
				  OR prey_name LIKE '%booby%' OR prey_name LIKE '%skua%'
				  OR prey_name LIKE '%stork%' OR prey_name LIKE '%cockatoo%'
				  OR prey_name LIKE '%creeper%' OR prey_name LIKE '%parrot%'
				  OR prey_name LIKE '%puffin%' OR prey_name LIKE '%robin%'
				  OR prey_name LIKE '%curlew%' OR prey_name LIKE '%woodchuck%'
				  OR prey_name LIKE '%stilt%' OR prey_name LIKE '%starling%'
				  OR prey_name LIKE '%mynah%' OR prey_name LIKE '%frogmouth%'
				  OR prey_name LIKE '%magpie%' OR prey_name LIKE '%toucan%'
				  OR prey_name LIKE '%caracara%' OR prey_name LIKE '%siskin%'
				  OR prey_name LIKE '%fowl%' OR prey_name LIKE '%coot%'
				  OR prey_name LIKE '%swan%' OR prey_name LIKE '%weaver%'
				  OR prey_name LIKE '%tern%' OR prey_name LIKE '%cliffchat%'
				  OR prey_name LIKE '%cardinal%' OR prey_name LIKE '%bulbul%'
				  OR prey_name LIKE '%kite%' OR prey_name LIKE '%waxbill%'
				  OR prey_name LIKE '%spoonbill%' OR prey_name LIKE '%parakeet%'
				  OR prey_name LIKE '%pie%' OR prey_name LIKE '%finch%'
				  OR prey_name LIKE '%boubou%' OR prey_name LIKE '%turkey%'
				  OR prey_name LIKE '%kingfisher%' OR prey_name LIKE '%roadrunner%'
				  OR prey_name LIKE '%trumpeter%' OR prey_name LIKE '%sparrow%'
				  OR prey_name LIKE '%white-eye%' OR prey_name LIKE '%swallow%'
				  OR prey_name LIKE '%pheasant%' OR prey_name LIKE '%pigeon%'
				  OR prey_name LIKE '%ibis%' OR prey_name LIKE '%egret%'
				  OR prey_name LIKE '%cordon bleu%' OR prey_name LIKE '%lourie%'
				  OR prey_name LIKE '%mallard%' OR prey_name LIKE '%bustard%'
				  OR prey_name LIKE '%peacock%' OR prey_name LIKE '%shrike%'
				  OR prey_name LIKE '%lory%' OR prey_name LIKE '%jaeger%'
				  OR prey_name LIKE '%galah%' OR prey_name LIKE '%woodcock%'
				  OR prey_name LIKE '%avocet%' OR prey_name LIKE '%moorhen%'
				  OR prey_name LIKE '%flicker%' OR prey_name LIKE '%turaco%'
				  OR prey_name LIKE '%partridge%' OR prey_name LIKE '%roller%'
				  OR prey_name LIKE '%chickadee%' OR prey_name LIKE '%goldeneye%'
				  OR prey_name LIKE '%lapwing%' OR prey_name LIKE '%drongo%'
				  OR prey_name LIKE '%thrasher%' OR prey_name LIKE '%lorikeet%'
				  OR prey_name LIKE '%bunting%' OR prey_name LIKE '%grebe%'
				  OR prey_name LIKE '%godwit%' OR prey_name LIKE '%kookaburra%'
				  OR prey_name LIKE '%sheathbill%' OR prey_name LIKE '%tinamou%'
				  OR prey_name LIKE '%openbill%' OR prey_name LIKE '%ostrich%'
				  OR prey_name LIKE '%osprey%' OR prey_name LIKE '%skimmer%'
				  OR prey_name LIKE '%screamer%' OR prey_name LIKE '%plover%'
				  OR prey_name LIKE '%pintail%' OR prey_name LIKE '%bleu%'
				  OR prey_name LIKE '%corella%' OR prey_name LIKE '%woodpecker%'	
				  OR prey_name LIKE '%hen' OR prey_name LIKE '%sandpiper%'
				  OR prey_name LIKE 'emu' OR prey_name LIKE '%nuthatch%'
				  OR prey_name LIKE '%quail%' OR prey_name LIKE '%dabchick%') THEN 'bird'
				  
				  WHEN (prey_name LIKE '%admiral%' OR prey_name LIKE '%dragonfly%'
				  OR prey_name LIKE 'Ant (unidentified)' OR prey_name LIKE '%butterfly%'
				  OR prey_name LIKE '%insect%' OR prey_name LIKE '%genoveva%'
				  OR prey_name LIKE '%mantis%') THEN 'insect'
				  WHEN (prey_name LIKE '%shark%' OR prey_name LIKE '%mudskipper%'
				  OR prey_name LIKE '%salmon' OR prey_name LIKE '%grenadier%') THEN 'fish'
				  WHEN (prey_name LIKE '%tarantula%' OR prey_name LIKE '%spider%') THEN 'arachnida'
				  WHEN (prey_name LIKE '%starfish%' OR prey_name LIKE '%crab%') THEN 'marine invertebrate'
				  WHEN (prey_name LIKE '%frog' OR prey_name LIKE '%frog (unidentified)%') THEN 'amphibian'
				  ELSE 0 
			END AS prey_class,
			feeding_frequency,
			aggressive
	FROM (SELECT *, SUBSTRING_INDEX(favorite_food, ',',1) AS prey_name
		  FROM details) AS with_type
	);
    
-- The occupation column in the location dataset contains different types of job titles for each alien.
-- Another level of detail will be added by categorizing the job titles into broader categorization names
-- (Industry, Business Management, Academia, Human Resources, Medical Field, Information Technology, Media Services and 
-- Family Services). 
CREATE TABLE occupation 
AS (
	SELECT *,
		   CASE WHEN occupation LIKE '%engineer%' OR occupation LIKE '%technician%'
				OR occupation LIKE '%product management%' OR occupation LIKE '%general manager%'
				OR occupation LIKE '%operator%' OR occupation LIKE '%project manager%'
				OR occupation LIKE '%automation%'  OR occupation LIKE '%quality control%'
				OR occupation LIKE '%geologist%' OR occupation LIKE '%circuit design%'
				OR occupation LIKE '%food chemist%' OR occupation LIKE '%environment%'
				OR occupation LIKE '%architect%' OR occupation LIKE '%geologist%' THEN 'Industry'

				WHEN occupation LIKE '%accountant%' OR occupation LIKE '%financial%' 
				OR occupation LIKE '%accounting%' OR occupation LIKE '%executive%'
				OR occupation LIKE '%auditor%' OR occupation LIKE '%actuary%'
				OR occupation LIKE '%legal assistant%' OR occupation LIKE '%administrative%'
				OR occupation LIKE '%data%' OR occupation LIKE '%account %'
				OR occupation LIKE '%assistant manager%' OR occupation LIKE '%paralegal%'
				OR occupation LIKE '%office%' OR occupation LIKE '%sales%'
				OR occupation LIKE '%marketing%' THEN 'Business Management'
				
				WHEN occupation LIKE '%scientist%' OR occupation LIKE '%research%'
				OR occupation LIKE '%professor%' OR occupation LIKE '%teacher%'
				OR occupation LIKE '%librarian%'THEN 'Academia'
				
				WHEN occupation LIKE '%recruit%' OR occupation LIKE '%payment%'
				OR occupation LIKE '%human resources%' THEN 'Human Resources'
				
				WHEN occupation LIKE '%pharmacist%' OR occupation LIKE '%nurse%'
				OR occupation LIKE '%health%' OR occupation LIKE '%clinical%'
				OR occupation LIKE '%therap%' OR occupation LIKE '%hygienist%'
				OR occupation LIKE '%pathologist%' THEN 'Medical Field'
					
				WHEN occupation LIKE '%programmer%' OR occupation LIKE '%developer%'
				OR occupation LIKE '%web%' OR occupation LIKE '%analyst%'
				OR occupation LIKE '%database%' OR occupation LIKE '%help desk%'
				OR occupation LIKE '%information%' OR occupation LIKE '%graphic designer%'
				OR occupation LIKE '%systems%' OR occupation LIKE '%software%'
				OR occupation LIKE '%data%' OR occupation LIKE '%statistician%' THEN 'Information Technology'
				
				WHEN occupation LIKE '%media%' OR occupation LIKE '%writer%'
				OR occupation LIKE '%editor%'THEN 'Media Services'
					 
				WHEN occupation LIKE '%social worker%' OR occupation LIKE '%outreach%' THEN 'Family Services'    
		   ELSE 0 END AS occupation_cat
	FROM aliens.location
  );

-- The tables diet and occcupation can then be joined with table aliens to create another table with all information.
-- This final dataset will be imported in Tableau to be further analyzed. 
CREATE TABLE alien_dataset AS (SELECT id, gender, type, birth_year, prey_name, prey_class, feeding_frequency, occupation, occupation_cat, current_location, state, aggressive
							   FROM aliens AS a
							   INNER JOIN diet AS d
							   ON a.id = d.detail_id 
							   INNER JOIN occupation AS o
							   ON a.id = o.loc_id);