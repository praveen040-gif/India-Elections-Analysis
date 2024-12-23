-- States Tab;e

create table states(State_ID varchar(10) primary key,State_name char(100));

select * from states;

-- Parties Table


create table partywise_results(Party char(100),Won	int,Party_ID int primary key);

select * from partywise_results;

-- State_Wise results Table


create table statewise_results(Constituency char(100),Const_No int,Parliament_Constituency char(100) primary key,
Leading_Candidate char(100),Trailing_Candidate char(100),Margin int,Status char(100),
State_ID varchar(10),foreign key(State_ID) references	states(State_ID),state_name char(100));

select * from statewise_results;

--constituencywise_results Table
create table constituencywise_results(S_No int,Parliament_Constituency char(100),foreign key(Parliament_Constituency) references
statewise_results(Parliament_Constituency),Constituency_Name char(100),Winning_Candidate char(100),Total_Votes int,	
Margin int,Constituency_ID varchar(100) primary key,Party_ID int,foreign key(Party_ID) references partywise_results(Party_ID));

select * from constituencywise_results;

--constituencywise_details Table
create table constituencywise_details(S_No int,Candidate char(100),Party char(100),EVM_Votes int,Postal_Votes int,
Total_Votes int,percentage_of_Votes float,Constituency_ID varchar(20),foreign key(Constituency_ID) 
references constituencywise_results(Constituency_ID));


select * from constituencywise_details;

-- Table join between states and statewise_results

select * from states as s join statewise_results sr on s.State_ID=sr.State_ID ;

--1.No.of parliament seats in state wise

select sr.State_ID,s.State_name,count(sr.State_ID) as total_seats from states as s join statewise_results sr on s.State_ID=sr.State_ID 
group by sr.State_ID,s.State_name order by s.State_name ;

-- 2.total no.of loksabha seats
select count(*) as lokasabha_seats from statewise_results;

-- 3.Total Seats Won by NDA Allianz


select sum(won) as NDA_Total_Seats_Won from partywise_results where party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM');

-- 4.Seats Won by NDA Allianz Parties

select party,won as NDA_Total_Seats_Won from partywise_results where party in ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') order by 2 desc;


-- 5.Total Seats Won by I.N.D.I.A. Allianz

select sum(won) as INDIA_Total_Seats_Won from partywise_results where party in (                
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK');


-- 6.Seats Won by I.N.D.I.A. Allianz Parties

select party,won as INDIA_Total_Seats_Won from partywise_results where party in (                
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK') order by 2 desc;

-- 6.Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

Alter table  partywise_results add party_alliance varchar(100);

update partywise_results set party_alliance='NDA' where party in(	
				'Bharatiya Janata Party - BJP',
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM');

update partywise_results set party_alliance='INDIA' where party in(
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK');

update partywise_results set party_alliance='Others' where party_alliance is null;

select * from partywise_results;

-- 7.Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

select party_alliance,count(*) from partywise_results as pr join constituencywise_results as cr on pr.Party_ID=cr.Party_ID
group  by party_alliance order by 2 desc;


-- 8.Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

select cr.winning_candidate,pr.party,cr.total_votes,cr.margin,s.State_name from partywise_results as pr join constituencywise_results as cr on pr.Party_ID=cr.Party_ID join 
statewise_results as sr on cr.Parliament_Constituency=sr.Parliament_Constituency join states s on sr.State_ID=s.State_ID
where s.State_name='Andhra Pradesh';

-- 9.What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

select cd.candidate,cd.party,cd.evm_votes,cd.postal_votes,cd.total_votes,cr.constituency_name from constituencywise_details as cd join constituencywise_results as cr on 
cd.constituency_id=cr.constituency_id where cr.constituency_name='ANANTHAPUR';

-- 10.Which parties won the most seats in s State, and how many seats did each party win?


select pr.party as Andhra_Pradesh,count(pr.party) from partywise_results as pr join constituencywise_results as cr on pr.Party_ID=cr.Party_ID join 
statewise_results as sr on cr.Parliament_Constituency=sr.Parliament_Constituency join states s on sr.State_ID=s.State_ID
where sr.state_name='Andhra Pradesh' group by pr.party order by 2 desc;


--11. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

select s.State_name, 
sum(case when pr.party_alliance='NDA' then 1
     else 0 end)  as NDA,sum(case when pr.party_alliance='INDIA' then 1
     else 0 end)  as INDIA,sum(case when pr.party_alliance='Others' then 1
     else 0 end)  as Others from partywise_results as pr join constituencywise_results as cr on pr.Party_ID=cr.Party_ID join 
statewise_results as sr on cr.Parliament_Constituency=sr.Parliament_Constituency join states s on sr.State_ID=s.State_ID
where pr.party_alliance in ('NDA','INDIA','Others') group by s.State_name order by 1;


-- 12.Which candidate received the highest number of EVM votes in each constituency (Top 10)?

select cr.constituency_name,cd.candidate,cd.party,cd.evm_votes from constituencywise_details as cd join 
constituencywise_results as cr on cd.constituency_id=cr.constituency_id order by cd.evm_votes desc limit 10;


-- 13.Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?


with ranked as (select cr.constituency_id,cr.constituency_name,cd.candidate,cd.party,(cd.evm_votes+cd.postal_votes) as votes,
Rank() over(partition by cr.constituency_name order by cd.evm_votes+cd.postal_votes desc) as ranking
,s.state_name from constituencywise_details as cd join 
constituencywise_results as cr on cd.constituency_id=cr.constituency_id  join 
statewise_results sr on cr.parliament_constituency=sr.parliament_constituency join states as s on sr.state_id=s.state_id 
join partywise_results pr on cr.party_id = pr.party_id where s.state_name ='Andhra Pradesh')
select cr.constituency_name,
max(case
when r.ranking=1 then r.candidate
end) as winner,
max(case
when r.ranking=2 then r.candidate
end )as Runner from ranked as r join  
constituencywise_results as cr on r.constituency_id=cr.constituency_id group by cr.constituency_name;


-- 14.For the state of Maharashtra, what are the total number of seats, total number 
-- of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?



select s.state_name,count(distinct(cr.constituency_name)) as constituencies,count(cd.candidate) as candidates,count(distinct(cd.party)) as parties,sum(cd.evm_votes) as evm_votes
,sum(cd.postal_votes) as postal_votes,sum(cd.total_votes) as total_votes
from constituencywise_details as cd join 
constituencywise_results as cr on cd.constituency_id=cr.constituency_id  join 
statewise_results sr on cr.parliament_constituency=sr.parliament_constituency join states as s on sr.state_id=s.state_id 
join partywise_results pr on cr.party_id = pr.party_id where s.state_name ='Andhra Pradesh' group by s.state_name








				





