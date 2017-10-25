<img src="https://orig00.deviantart.net/e0a2/f/2010/297/a/1/horde_by_breathing2004-d31ejvx.jpg
" width="100%" >

# FOR THE HORDE... ZUG ZUG!

#### Why did you choose this data?
- I played world of warcraft with my little brother, friends, and cousins on/off throughout junior high and high school, so it was a formative activity for me.
- Thanks to South Park, world of warcraft players have a negative stereotype as being those which have "no life."  I wanted to see what the data had to say!

#### What questions did you go in hoping to answer?
- What are the most popular race/class combinations?
- What percentage of characters are new/existing?
- How does class popularity vary among races, and vice versa?
- How does character behavior change by hour, day, week, and month?
- What much does the average character play?
- How much of the total population fits the hard-core, South Park stereotype?
- Are any classes faster levelers than others? If so, what archetypes are those classes?
- Do classes have different drop-off rates than others? That is to say, do classes have a variable amount of new characters that never reach the endgame?
- Do characters that reach the endgame keep up their leveling behavior? If not, what changes?

#### Show us something from your model. Maybe an interesting model structure or a tricky join.
- How I sessionized the timestamp data [here](https://dcl.dev.looker.com/projects/wow_thesis/files/zz.master_activity_levelers_only_ENDGAME.view.lkml)

#### Highlight something you learned.
- I do indeed have a life.
- Warriors are the most popular kind of new character, but they have the highest drop-off rate.
- Same races are more varied in their class choices than others.
- Although a small subpopulation of the total, characters that reached level 70 are much more "hard core" than the rest of characters.
- Play time drops off after reaching level 70.

#### How did this change your understanding of our customers?
- Writing a bunch of raw sql can get messy really quickly.  I found myself constantly referencing raw sql I wrote weeks ago to keep my calculations consistent instead of leverging the power of lookml.  Now that months have gone by, I don't remember why I coded what I did as clearly as before, so my confidence in some of my hand-written aggregations is shaken.

#### What questions do you have for the future?
- How do player demographics correlate with character demographics?
- What's the correlation (if any) between playtime and subscription renewal?
- Do players with a few max level characters have a higher likelihood to renew their subscription compared to players with a bunch of lower level characters?
- Have the expansions bridged the leveling/endgame playtime divide?
- Have the expansions made it easier to reach level 70 and therefore curbed drop-off?


#### A little about the data itself
- For as long as a character was being played, timestamps were logged in increments between 5 - 30 minutes.
- There was no concept of session, so I had to sessionize the data using a window function partiotining the data by character/timestamp and marking a new session after a difference between timestamps exceeded 30 minutes.
- The date format was messed up and I couldn't fix it during BQ import, so I used a little python script to loop through the 10,000,000 row csv file and change the format into 'yyyy-mm-dd hh:mm:ss' format.

#### How did you get it into Looker?
- I loaded the CSV into google drive and imported it into BQ.
