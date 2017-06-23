# World of Warcraft Write Up

World of Warcraft is a $15.00/month subscription-based, massive multiplayer online role playing game (mmorpg).  In it, characters join one of the two warring factions and explore a vast world rife with monsters, treasure, and adventure.  It was released in 2004, and by the end of 2008, it had **10 million global subscribers** and two released expansions: Burning Crusade and Wrath of the Lich King.  Please note: expansions are add-ons to the original game that unlock new content and levels.

The [dataset](https://www.kaggle.com/mylesoneill/warcraft-avatar-history) from Kaggle is a collection of records that detail information about player characters in the game over time. It includes information about their character level, race, class, location, and social guild. This dataset only includes information about the Horde faction of players from a single game server during 2008.  I chose it for my thesis because it's one of my favorite games and I wanted to look at it through new (data-driven) eyes.  I played from 2004 to 2008 and had two level 70s, both of which were part of the Horde faction.  They were Jimjiminy, the fearsome Undead Shadow-Priest, and Sunnyside, the dynamic Tauren Elamentalist-Shaman.  I stopped playing right before the release of WoLK (Wrath of the Lich King).  Without further ado, let's jump into things, [ZUG ZUG!](http://wow.answers.wikia.com/wiki/What_does_Zug_Zug_mean)

Given the size of one of the three CSV files (~11,000,000 rows) and it's wonky timestamp format, I used a Python [script](https://github.com/philip-martinelli/wow/blob/dev-philip-martinelli-tzqw/sql) to A) split the master file into 12 smaller files and B) format their timestamps correctly before importing them in Google BigQuery.  Once in Google BigQuery, I used a series of SQL queries to re-structure the data into hourly/daily/weekly summary tables.  With the data aggregated this way, I was able to perform operations across the year with reasonable runtimes.

Once connected to Looker, I created views to model character demographics and characters sessions.  After modeling the total population this way, I isolated the subpopulation of characters that started at level 1 and reached level 70 (the max level) and modeled both their leveling and endgame behavior.  Given the layers of aggregation I needed to perform on the data, I used a lot of persisted derived tables.  Below are some thoughts I want to share on the above-mentioned subjects.

### Character Demographics
The first subject I looked at was character demographics.  As noted above, this dataset only covers the Horde faction.  Compared to the refined races of the Alliance faction (Dwarves, Gnomes, Night Elves, Humans, and Draenei) the races of the Horde are relatively rough and fearsome.  Whenever a new character is created, the user chooses a race and a class (i.e. profession).  Classes are generally divided into the **tank** (warrior, paladin, druid), **healer** (paladin, priest, shaman, druid), and **damage-dealing** (priest, hunter, rogue, druid, shaman, death knight) archetypes.  Some classes are pidgeon-holed into one archetype (ex: warrior), whereas others can be molded to fit various archetypes (ex: paladin).  Certain classes can *only* be played by certain races, and for classes without such restriction, there are definitely popular, and less popular, combinations (ex:  orc warriors are popular, troll mages are less so).  For the most part, orcs and tauren lack the class diversity of blood elves, undead, and trolls.

Here are a few questions that inspired me to model the data like I did:

- What are the most popular race/class combinations?
- What percentage of characters are new/existing?
- How does class popularity vary among races, and vice versa?

### Character Sessions
The second subject I looked at was character sessions.  The raw dataset has no concept of "session," so I defined a session as any group of consecutive timestamps recorded within 30 minutes of each another.  I chose 30 as the somewhat arbitrary cutoff because (for the most part) consecutive timestamps were either recorded within 5-30 minutes *or* were more than 100 minutes of each other.  See how I defined session [here](https://github.com/philip-martinelli/wow/blob/dev-philip-martinelli-tzqw/sql).

The more time spent playing, the more recorded timestamps/rows of data.  Although the "hard-core" population is relatively small compared to the "casual" population (see distribution charts) they have an overwhelming presence in the dataset.  Although they are nebulous terms without clear distinction, let me venture to explain the difference between casual and hard-core characters.  Casual characters are those that play around a life full of other priorities (work, school, fitness, relationships, etc.); hard-core characters are those that make the game their priority and otherwise "have no life."  I was very surprised to see how few hard-core characters there were, for World of Warcraft has a reputation for spawning them en masse.  In fact, there is an entire South Park [episode](https://en.wikipedia.org/wiki/Make_Love,_Not_Warcraft) about it.  For the record, I fell somewhere in between casual and hard-core.  If I'm really honest with myself, I probably leaned slightly in the direction of hard-core.

Here are a few questions that inspired me to model the data like I did:

- How does character behavior change by hour, day, week, and month?
- What much does the average character play?
- How much of the total population fits the hard-core, South Park stereotype?
- Do any classes fall out of favor and become less popular throughout the year?

### Leveling
The third subject I looked at was the subpopulation of new characters that started playing and reached level 70 the same year.  I define new characters as characters whose first recorded timestamp has a corresponding level of 1.  I particularly wanted to know how (if at all) their behavior varied by class, how they compared against the total populaton, and how their behavior changed from leveling to endgame.  I define leveling data as data from the first timestamp of level 1 to the first timestamp of level 70, and I define endgame data as data from the first timestamp of level 70 to the last timestamp of level 70.

In the mmorpg (massive multiplayer online role playing game) genre, the differences (and balance) between engaging leveling and endgame experiences are important subjects. There needs to be enough fun content to shuttle players through “the grind” from level 1 to 70, but there also needs to be a robust endgame experience to keep them happy without the motivating factor of reaching the next level.  From a subscription-based business perspective, characters can stop paying at any given time, so it's vital that they are motivated to log back in again, and again, and again, and again.

Here are a few questions that inspired me to model the data like I did:

- Are any classes faster levelers than others?  If so, what archetypes are those classes?
- Do classes have different drop-off rates than others?  That is to say, do classes have a variable amount of new characters that never reach the endgame?
- Do characters that reach the endgame keep up their leveling behavior?  If not, what changes?
