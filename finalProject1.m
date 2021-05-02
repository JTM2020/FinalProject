function[] = finalProject1()
global baseball;
% My global variable baseball that will be used throughout all my code
baseball.atbats = 0 ;
baseball.battingAverage = 0.000;
baseball.single = 0;
baseball.double = 0;
baseball.triple = 0;
baseball.homerun = 0; %These values will be my intial values for the baseball statistics calculator
baseball.hits = 0;
baseball.walks = 0;
baseball.hbpwalks = 0;
baseball.onbasepercentage = 0.000;
baseball.slg = 0;
baseball.ops = 0;
baseball.homeAway = 'home';


baseball.fig = figure('color','[0 0.4470 0.7410]','numbertitle','off','name','Baseball Hitting Statistics'); %This creates the figure for my stat tracker

baseball.playernumberSelector = uicontrol('style','edit','units','normalized','position',[.35 .057 .14 .05],'string','Input Player #','Tag','EditField'); %This edit box is where you can input your players number 
baseball.playernumberDisplay = uicontrol('style','edit','units','normalized','position',[.38 .15 .09 .05],'string','0','horizontalalignment','right','Tag','EditField2','Enable','off'); %The second edit box that will just display the number inputted in the first edit box
baseball.playernumberEnter = uicontrol('style','pushbutton','units','normalized','position',[.80 .105 .14 .05],'string','Enter','callback', {@playerNumber,baseball.playernumberSelector,baseball.playernumberDisplay}); % This is a master enter button that will display the number in the second edit box as well as displaying a message with the players stats previously inputted with the other buttons. It also creates a csv with the players stats

baseball.teamSelector = uicontrol('style','radiobutton','units','normalized','position',[.60 .155 .14 .05],'string','Home','callback', {@home}); %button that switches the players team to home
baseball.teamSelector2 = uicontrol('style','radiobutton','units','normalized','position',[.60 .055 .14 .05],'string','Away','callback', {@away}); %button that switches the players team to away

baseball.atBats = uicontrol('style','pushbutton','units','normalized','position',[.034 .007 .14 .05],'string','Outs','callback', {@addAB,1}); %push button that uses a callback function to adds at bats 
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %display that shows the number of times at bats is added
baseball.atBatsText = uicontrol('style','text','units','normalized','position', [.37 .90 .10 .05],'string','At Bats','horizontalalignment','center'); %Text that is next to the display that shows at bats

baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2'); %display that adds all the hits including singles,doubles,triples,home runs
baseball.hitsText = uicontrol('style','text','units','normalized','position', [.37 .80 .10 .05],'string','Hits','horizontalalignment','center'); %Text that is next to the display that shows hits
baseball.singles = uicontrol('style','pushbutton','units','normalized','position',[.034 .100 .14 .05],'string','Single','callback', {@addSingles,1}); %push button that uses a callback function to adds 1 to hits  
baseball.doubles = uicontrol('style','pushbutton','units','normalized','position',[.034 .200 .14 .05],'string','Double','callback', {@addDoubles,1}); %push button that uses a callback function to adds 1 to hits  
baseball.triples = uicontrol('style','pushbutton','units','normalized','position',[.034 .300 .14 .05],'string','Triple','callback', {@addTriples,1}); %push button that uses a callback function to adds 1 to hits  
baseball.homeRuns = uicontrol('style','pushbutton','units','normalized','position',[.034 .400 .14 .05],'string','Home Run','callback', {@addHomeRuns,1}); %push button that uses a callback function to adds 1 to hits 

baseball.hbpWalks = uicontrol('style','pushbutton','units','normalized','position',[.034 .500 .14 .05],'string','Walks/HBP','callback', {@addhbpWalks,1}); %push button that uses a callback function to adds at bats 
baseball.hbpWalksDisplay = uicontrol('style','text','units','normalized','position',[.50 .70 .09 .05],'string', num2str(baseball.hbpwalks),'horizontalalignment','right'); %display that shows the number of times HBP/walks is added
baseball.hbpWalksText = uicontrol('style','text','units','normalized','position', [.37 .70 .10 .06],'string','Walks/HBP','horizontalalignment','center'); %Text that is next to the display that shows hBP/walks

baseball.playerBattingAverage = uicontrol('style','pushbutton','units','normalized','position',[.034 .600 .14 .05],'string','Calculate AVG','callback', {@calculateBattingAverage}); %push button that uses a callback function to takes in at bats and hits to calculate batting average
baseball.battingAverageDisplay = uicontrol('style','text','units','normalized','position',[.50 .60 .09 .05],'string', num2str(baseball.battingAverage),'horizontalalignment','right'); %display that shows the calculated batting average
baseball.battingAverageText = uicontrol('style','text','units','normalized','position', [.37 .60 .10 .06],'string','Batting Average','horizontalalignment','center'); %Text that is next to the display that shows batting average

baseball.onBasePercentage = uicontrol('style','pushbutton','units','normalized','position',[.034 .700 .14 .05],'string','Calculate OBP','callback', {@calculateOBP}); %push button that uses a callback function to take in at bats, hits, and HBP/Walks to calculate on base percentage
baseball.obpDisplay = uicontrol('style','text','units','normalized','position',[.50 .50 .09 .05],'string', num2str(baseball.battingAverage),'horizontalalignment','right'); %display that shows the calculated on base percentage
baseball.obpText = uicontrol('style','text','units','normalized','position', [.37 .50 .10 .06],'string','On Base Percentage','horizontalalignment','center'); %Text that is next to the display that shows OBP

baseball.SLG = uicontrol('style','pushbutton','units','normalized','position',[.034 .800 .14 .05],'string','Calculate SLG','callback', {@calculateSLG}); %push button that uses a callback function to take in singles, doubles, triples, homeruns, and atbats to calculate slugging
baseball.slgDisplay = uicontrol('style','text','units','normalized','position',[.50 .40 .09 .05],'string', num2str(baseball.slg),'horizontalalignment','right'); %display that shows the calculated slugging
baseball.slgText = uicontrol('style','text','units','normalized','position', [.37 .40 .10 .06],'string','Slugging Percentage','horizontalalignment','center'); %Text that is next to the display that shows SLG

baseball.OPS = uicontrol('style','pushbutton','units','normalized','position',[.034 .900 .14 .05],'string','Calculate OPS','callback', {@calculateOPS}); %push button that uses a callback function to add OBP and slugging
baseball.opsDisplay = uicontrol('style','text','units','normalized','position',[.50 .30 .09 .05],'string', num2str(baseball.ops),'horizontalalignment','right'); %display that shows the calculated on bass percentage plus slugging
baseball.opsText = uicontrol('style','text','units','normalized','position', [.37 .30 .10 .06],'string','On Base Plus SLG','horizontalalignment','center'); %Text that is next to the display that shows OPS

baseball.resetButton = uicontrol('style','pushbutton','units','normalized','position',[.80 .640 .14 .05],'string','Reset','callback', {@resetButton}); %Button that resets all the values previously stated back to their initial value of zero
baseball.closeButton = uicontrol('style','pushbutton','units','normalized','position',[.80 .50 .14 .05],'string','Close','callback', {@closeButton}); %button that closes program
set(baseball.teamSelector, 'Value', 1); %Starts off by having home button pressed
end
function[] = playerNumber(source,event,number,display) %callback function to put in the player number
 calculateBattingAverage(source,event) %calls batting average function in case the user doesn't
 calculateOPS(source,event); %calls OPS function in case user doesn't

global baseball; %global variable
if baseball.homeaway == 1 %checks if home or away ic clicked
    baseball.playernumber = str2num(number.String); %assigns the variable baseball.playernumber to the string inputed in the edit box
    display.String = num2str(baseball.playernumber);
    if isempty(str2num(number.String))
    set(baseball.playernumber,'string','0');%This if statement checks for numerical input for player number
    warndlg('Input must be numerical');
    return
    end
else
    warndlg('Choose Home or Away')
    return
end
   message = sprintf('Number %s on the %s team had %d at bats, %d hits, a batting average of %.3f, an OBP of %.3f, a SLG of %.3f, and an OPS of %.3f ', number.String, baseball.homeAway, baseball.atbats, baseball.hits, baseball.battingAverage, baseball.onbasepercentage, baseball.slg, baseball.ops);
    uiwait(msgbox(message)); %messagebox the is created to shows the players number, team, batting average, OBP, SLG, and OPS
   % writematrix([baseball.playernumber,baseball.atbats,baseball.hits,baseball.battingAverage,baseball.onbasepercentage,baseball.slg,baseball.ops],'baseball.csv'); %Writes a csv for the players stats so they can be tracked
end

function[] = home(~,~) %callback function that changes baseball.homeAway to 'home'
global baseball; %global variable
baseball.homeAway = 'home';
baseball.homeaway = 1;
set(baseball.teamSelector2, 'Value', 0); %turns off away button if home button is pressed
end

function[] = away(~,~) %callback function that changes baseball.homeAway to 'away'
global baseball; %global variable
baseball.homeAway = 'away';
baseball.homeaway = 1;
set(baseball.teamSelector, 'Value', 0); %turns off home button if away button is pressed
end
    

function[] = addAB(source,event,outs) %callback function that adds at bats 
global baseball; %global variable
baseball.atbats = baseball.atbats + outs; %reassigns baseball.atbats by adding 1 every time the push button is pressed
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %resets the display to show when an at bat is added
end

function[] = addSingles(source,event,single) %callback function
global baseball; %global variable
baseball.single = baseball.single + single; %reassigns baseball.single by adding 1 every time the push button is pressed
baseball.hits = baseball.single + baseball.double + baseball.triple + baseball.homerun; %reassigns hits every time a single, double, triple, or homerun is added
baseball.atbats = baseball.atbats + 1; %adds an at bat every time there is a hit
baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2'); %resets the display to show when a hit is added
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %resets the display to show when an at bat is added

end

function[] = addDoubles(source,event,double) %callback function
global baseball; %global variable
baseball.double = baseball.double + double; %reassigns baseball.double by adding 1 every time the push button is pressed
baseball.hits = baseball.single + baseball.double + baseball.triple + baseball.homerun; %reassigns hits every time a single, double, triple, or homerun is added
baseball.atbats = baseball.atbats + 1; %adds an at bat every time there is a hit
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %resets the display to show when an at bat is added
baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2'); %resets the display to show when a hit is added
end

function[] = addTriples(source,event,triple) %callback function
global baseball; %global variable
baseball.triple = baseball.triple + triple; %reassigns baseball.triple by adding 1 every time the push button is pressed
baseball.hits = baseball.single + baseball.double + baseball.triple + baseball.homerun; %reassigns hits every time a single, double, triple, or homerun is added
baseball.atbats = baseball.atbats + 1; %adds an at bat every time there is a hit
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %resets the display to show when an at bat is added
baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2'); %resets the display to show when a hit is added
end

function[] = addHomeRuns(source,event,homerun) %callback function
global baseball; %global variable
baseball.homerun = baseball.homerun + homerun; %reassigns baseball.homerun by adding 1 every time the push button is pressed
baseball.hits = baseball.single + baseball.double + baseball.triple + baseball.homerun; %reassigns hits every time a single, double, triple, or homerun is added
baseball.atbats = baseball.atbats + 1;%adds an at bat every time there is a hit
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %resets the display to show when an at bat is added
baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2'); %resets the display to show when a hit is added
end

function[] = addhbpWalks(source,event,walks) %callback function
global baseball; %global variable
baseball.walks = baseball.walks + walks; %reassigns baseball.walks by adding 1 every time the push button is pressed
baseball.hbpwalks = baseball.walks;
baseball.hbpWalksDisplay = uicontrol('style','text','units','normalized','position',[.50 .70 .09 .05],'string', num2str(baseball.hbpwalks),'horizontalalignment','right'); %resets the display to show when a walk/hbp is added
end

function[] = calculateBattingAverage(~,~) %callback function
global baseball; %global variable
if baseball.atbats == 0
    baseball.battingAverage = 0; %if statement that will keep the value of batting average 0 instead of NaN when calculating 0/0
    return
end
if baseball.atbats >= baseball.hits % if statement that checks if at bats is more than hits 
baseball.battingAverage = baseball.hits/baseball.atbats; %calculation for batting average
baseball.battingAverageDisplay = uicontrol('style','text','units','normalized','position',[.50 .60 .09 .05],'string', num2str(baseball.battingAverage),'horizontalalignment','right'); %resets the display to show when the batting average needs to be recalculated
else
msgbox('Hits exceed at bats!','User Error','error','modal') %error message that will show up if hits exceeds atbats
end
end

function[] = calculateOBP(~,~) %callback function
global baseball; %global variable
if baseball.atbats == 0 && baseball.hbpwalks == 0 %if statement that will keep the value of OBP 0 instead of NaN when calculating 0/0
    baseball.onbasepercentage = 0;
    return
end
if baseball.atbats >= baseball.hits % if statement that checks if at bats is more than hits 
baseball.onbasepercentage = (baseball.hits + baseball.hbpwalks)/(baseball.atbats + baseball.hbpwalks); %calculation for OBP
baseball.obpDisplay = uicontrol('style','text','units','normalized','position',[.50 .50 .09 .05],'string', num2str(baseball.onbasepercentage),'horizontalalignment','right'); %resets the display to show when the OBP needs to be recalculated
else
msgbox('Hits exceed at bats!','User Error','error','modal') %error message that will show up if hits exceeds atbats
end
end

function[] = calculateSLG(~,~) %callback function
global baseball; %global variable
if baseball.atbats == 0
    baseball.slg = 0; %if statement that will keep the value of SLG 0 instead of NaN when calculating 0/0
    return
end
if baseball.atbats >= baseball.hits % if statement that checks if at bats is more than hits 
baseball.slg = (baseball.single + (2*baseball.double) + (3*baseball.triple) + (4*baseball.homerun))/baseball.atbats; %calculation for SLG
baseball.slgDisplay = uicontrol('style','text','units','normalized','position',[.50 .40 .09 .05],'string', num2str(baseball.slg),'horizontalalignment','right'); %resets the display to show when the SLG needs to be recalculated
else
msgbox('Hits exceed at bats!','User Error','error','modal') %error message that will show up if hits exceeds atbats
end
end

function[] = calculateOPS(source,event) %callback function
calculateSLG(source,event); %calls SLG in case user does not as SLG is needed to calculate OPS
calculateOBP(source,event); %calls OBP in case user does not as SLG is needed to calculate OPS
global baseball; %global variable
if baseball.atbats >= baseball.hits % if statement that checks if at bats is more than hits 
baseball.ops = baseball.onbasepercentage + baseball.slg; %calculation for OPS
baseball.opsDisplay = uicontrol('style','text','units','normalized','position',[.50 .30 .09 .05],'string', num2str(baseball.ops),'horizontalalignment','right'); %resets the display to show when the OPS needs to be recalculated
else
msgbox('Hits exceed at bats!','User Error','error','modal') %error message that will show up if hits exceeds atbats
end
end

function[] = resetButton(~,~) % callback function for the reset button that just reassigns the variables and resets the uicontrol text for the variables
global baseball; %global variable
baseball.atbats = 0 ;
baseball.battingAverage = 0.000;
baseball.single = 0;
baseball.double = 0;
baseball.triple = 0;
baseball.homerun = 0; %reassign variables to 0
baseball.hits = 0;
baseball.walks = 0;
baseball.hbpwalks = 0;
baseball.onbasepercentage = 0;
baseball.slg = 0;
baseball.ops = 0;
baseball.atBatsDisplay = uicontrol('style','text','units','normalized','position',[.50 .90 .09 .05],'string', num2str(baseball.atbats),'horizontalalignment','right','Tag','EditField'); %to reassign variable displays to 0
baseball.hitsDisplay = uicontrol('style','text','units','normalized','position',[.50 .80 .09 .05],'string', num2str(baseball.hits),'horizontalalignment','right','Tag','EditField2');
baseball.hbpWalksDisplay = uicontrol('style','text','units','normalized','position',[.50 .70 .09 .05],'string', num2str(baseball.hbpwalks),'horizontalalignment','right');
baseball.battingAverageDisplay = uicontrol('style','text','units','normalized','position',[.50 .60 .09 .05],'string', num2str(baseball.battingAverage),'horizontalalignment','right');
baseball.obpDisplay = uicontrol('style','text','units','normalized','position',[.50 .50 .09 .05],'string', num2str(baseball.onbasepercentage),'horizontalalignment','right');
baseball.slgDisplay = uicontrol('style','text','units','normalized','position',[.50 .40 .09 .05],'string', num2str(baseball.slg),'horizontalalignment','right');
baseball.opsDisplay = uicontrol('style','text','units','normalized','position',[.50 .30 .09 .05],'string', num2str(baseball.ops),'horizontalalignment','right');
end

function[] = closeButton(~,~) %callback function for close button
global baseball % global variable
close(baseball.fig) % Closes figure
end



