const Discord = require('discord.js');
const botconfig = require('./botconfig.json');
const tweetConfig = require('./tweetconfig.json');
const bot = new Discord.Client();
const tweet = require('twit')
var request = require('request');
const T = new tweet(require('./config.js'));

var stream = T.stream('statuses/filter', { follow: ['961554324907163649', '956324383617765376', '931273791782535168'] })
//@newlylistedcoin => 961554324907163649
//@latestmarkets => 956324383617765376
//@CoinbaseCustody => 931273791782535168

//@ubiqannbot -> 3198742320

stream.on('tweet', function (tweet) {
  try {
        if(tweet.text.indexOf("@") == -1) {
                bot.channels.find("name", "coin-listings").send(tweet.text);
        }
        console.log("Coin Listings ==> " + tweet.text);
  } catch(e){
      console.log(e);
  }
})

bot.on('ready', () => {
        bot.user.setGame('autorefresh');
        console.log(' > ' + bot.user.username + ' ready.');
});

bot.login(botconfig.token);
