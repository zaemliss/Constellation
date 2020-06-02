// you need a file called botconfig.json in the same directory that has the discord bot token and the comand prefix
// ex:
//{
//    "token": "34X90RX83Y49FH234785RYODIJEWFH73845NWDNQHCIUOR34OH",
//    "prefix": "~"
//}

const Discord = require('discord.js');
const botconfig = require('./botconfig.json');
var endOfLine = require('os').EOL;
const bot = new Discord.Client();
var request = require('request');
const fs = require('fs');

console.log("Process ID: " + process.pid);

process.on('uncaughtException', function (err) {
    console.log('Caught exception: ' + err);
    var fs = require('fs');
    fs.appendFile('logfile', err)
    process.kill(process.pid, 'SIGTERM');
});

bot.on('ready', () => {
      console.log(formatted + ' >Bot Ready....');
});

bot.on('message',function(message) {
        // Ignore other bots.
        if(message.author.bot) return;

        var command = message.content.split(" ")[0].slice(0).toLocaleLowerCase()
        var args = message.content.split(" ").slice(1);
        var msgBody = args.join(' ');

  if(command === '~your_command') {
         console.log("Command has been issued");
  }

  if(command === '~status'){
         bot.user.setPresence({ game: { name: args.join(' '), type: 0 }});
  }
});

bot.login(botconfig.token);
